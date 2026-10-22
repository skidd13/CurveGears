"""Checks for build classification and false-pass prevention."""
import tempfile
import unittest
import struct
import json
import zlib
import subprocess
from pathlib import Path
from utils.build_inventory import ROOT, dependencies, examples, group, render_case, validate, write_if_changed
from utils.check_build_output import check
from utils.check_docs import check_markdown_modules, check_source_text
from utils.cusp_cache import snapshot
from utils.regression.stl import MESH_VERTEX_TOLERANCE, metrics


def tetrahedron_stl(scale, crack=0):
    points = ((0, 0, 0), (scale, 0, 0), (0, scale, 0), (0, 0, scale))
    faces = ((0, 2, 1), (0, 1, 3), (0, 3, 2), (1, 2, 3))
    facets = []
    for index, face in enumerate(faces):
        triangle = [points[vertex] for vertex in face]
        if index == 3:
            triangle = [(x + crack, y, z) for x, y, z in triangle]
        facets.extend('facet normal 0 0 0\nouter loop\n')
        facets.extend(f'vertex {x:.12g} {y:.12g} {z:.12g}\n' for x, y, z in triangle)
        facets.append('endloop\nendfacet\n')
    return 'solid tetrahedron\n' + ''.join(facets) + 'endsolid tetrahedron\n'


class InventoryTests(unittest.TestCase):
    def test_actual_api_and_boundary_matrix(self):
        sources = validate()
        self.assertEqual(len(sources), len(set(sources)))
        families = {group(p) for p in sources} - {'core', 'overview'}
        for family in families:
            selected = [p for p in sources if group(p) == family and render_case(p)]
            self.assertEqual(4, len(selected), (family, selected))
            self.assertEqual(2, sum('_alternative' in p for p in selected))

    def test_removed_canonical_example_is_detected(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'src').mkdir()
            (root / 'src/new.scad').write_text('module curve_gear_new() {}')
            with self.assertRaisesRegex(ValueError, 'missing='):
                validate(root)

    def test_transitive_includes_cycles_and_comments(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'entry.scad').write_text('// include <missing.scad>\n/* use <absent.scad> */\necho("include <no.scad>");\nuse <child.scad>')
            (root / 'child.scad').write_text('include <entry.scad>\ninclude <leaf.scad>')
            (root / 'leaf.scad').write_text('cube(1);')
            self.assertEqual(['child.scad', 'entry.scad', 'leaf.scad'], dependencies('entry.scad', root))
            (root / 'leaf.scad').unlink()
            with self.assertRaisesRegex(ValueError, 'missing OpenSCAD dependency'):
                dependencies('entry.scad', root)


    def test_alternative_dependency_reaches_owning_wrapper(self):
        deps = dependencies('examples/functions/cusp/curve_gear_cusp_pair_alternative.scad')
        self.assertIn('examples/functions/cusp/curve_gear_cusp_alternative.scad', deps)
        self.assertIn('src/cusp/mate.scad', deps)
        self.assertFalse(any('/ellipse/' in p for p in deps))

    def test_unchanged_inventory_does_not_invalidate_outputs(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / 'manifest.tsv'
            write_if_changed(output, 'first\n')
            original = output.stat().st_mtime_ns
            write_if_changed(output, 'first\n')
            self.assertEqual(original, output.stat().st_mtime_ns)
            write_if_changed(output, 'changed\n')
            self.assertEqual('changed\n', output.read_text())

    def test_missing_cached_mate_rebuilds_phase_even_with_marker(self):
        with tempfile.TemporaryDirectory(dir=ROOT / 'build') as directory:
            relative = Path(directory).relative_to(ROOT)
            marker = Path(directory) / 'cusp/envelope_3_0.25.ok'
            marker.parent.mkdir()
            marker.touch()
            result = subprocess.run(['make', '-n', str(marker.relative_to(ROOT)),
                                     f'REGRESSION_DIR={relative}', 'OPENSCAD=openscad'],
                                    cwd=ROOT, capture_output=True, text=True, check=True)
            self.assertIn(f'-o "{relative}/cusp/mate_3.stl"', result.stdout)
            self.assertIn('utils.check_build_output empty', result.stdout)

    def test_shared_mate_selection_runs_its_invalid_inputs(self):
        with tempfile.TemporaryDirectory(dir=ROOT / 'build') as directory:
            relative = Path(directory).relative_to(ROOT)
            result = subprocess.run(['make', '-n', 'test', 'family=mate_motion',
                                     f'REGRESSION_DIR={relative}', 'OPENSCAD=openscad'],
                                    cwd=ROOT, capture_output=True, text=True, check=True)
            for name in ['lengths', 'bracket', 'radius']:
                self.assertIn(f'tests/mate/invalid_preparation_{name}.scad', result.stdout)
            self.assertNotIn('tests/circle/invalid_backlash.scad', result.stdout)
            self.assertIn('--family mate_motion', result.stdout)


class MeshClosureTests(unittest.TestCase):
    def test_vertex_tolerance_controls_mesh_closure(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / 'tetrahedron.stl'
            for scale in (1, 0.01):
                for crack, closed in ((0, True), (1e-8, True),
                                       (MESH_VERTEX_TOLERANCE, True),
                                       (MESH_VERTEX_TOLERANCE + 1e-7, False)):
                    with self.subTest(scale=scale, crack=crack):
                        output.write_text(tetrahedron_stl(scale, crack))
                        self.assertEqual(closed, metrics(output)['closed'])


class OutputTests(unittest.TestCase):
    def setUp(self):
        self.directory = tempfile.TemporaryDirectory()
        self.addCleanup(self.directory.cleanup)
        self.output = Path(self.directory.name) / 'probe.stl'
        self.log = self.output.with_suffix('.log')

    def test_missing_import_cannot_pass_as_empty(self):
        self.log.write_text('WARNING: Could not read file missing.stl\nCurrent top level object is empty.\n')
        with self.assertRaisesRegex(ValueError, 'failed OpenSCAD log'):
            check(self.output, 'empty')

    def test_partial_mesh_with_assertion_cannot_pass(self):
        self.output.write_text('partial exported geometry')
        self.log.write_text('ERROR: Assertion failed in the omitted mate\nTop level object is a 3D object (manifold)\n')
        with self.assertRaisesRegex(ValueError, 'failed OpenSCAD log'):
            check(self.output, 'mesh')

    def test_empty_probe_requires_diagnostic_and_absent_mesh(self):
        self.log.write_text('Current top level object is empty.\n')
        check(self.output, 'empty')
        self.output.write_text('unexpected geometry')
        with self.assertRaisesRegex(ValueError, 'not empty'):
            check(self.output, 'empty')
        self.output.unlink()
        self.log.write_text('renderer crashed')
        with self.assertRaisesRegex(ValueError, 'not empty'):
            check(self.output, 'empty')

    def test_numeric_helpers_need_finite_echo(self):
        output = self.output.with_suffix('.csg')
        output.write_text('\n')
        source = 'curve_gear_cusp_centre_distance.scad'
        self.log.write_text('ECHO: 40.25\n')
        check(output, 'compile', source)
        self.log.write_text('ECHO: undef\n')
        with self.assertRaisesRegex(ValueError, 'invalid numeric'):
            check(output, 'compile', source)
        self.log.write_text('')
        with self.assertRaisesRegex(ValueError, 'empty geometry'):
            check(output, 'compile', 'curve_gear_cusp.scad')


    def test_blank_image_and_wrong_dimensions_are_rejected(self):
        def chunk(kind, payload):
            return struct.pack('>I', len(payload)) + kind + payload + struct.pack('>I', zlib.crc32(kind + payload))
        output = self.output.with_suffix('.png')
        Path(str(output) + '.log').write_text('')
        header = b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('>IIBBBBB', 2, 1, 8, 2, 0, 0, 0))
        output.write_bytes(header + chunk(b'IDAT', zlib.compress(b'\0' + b'\xff' * 6)) + chunk(b'IEND', b''))
        with self.assertRaisesRegex(ValueError, 'blank image'):
            check(output, 'image', size='2,1')
        output.write_bytes(header + chunk(b'IDAT', zlib.compress(b'\0' + b'\xff' * 3 + b'\0' * 3)) + chunk(b'IEND', b''))
        check(output, 'image', size='2,1')
        with self.assertRaisesRegex(ValueError, 'incorrect PNG dimensions'):
            check(output, 'image', size='3,1')


    def test_planar_cache_requires_a_closed_finite_outline(self):
        output = self.output.with_suffix('.dxf')
        output.with_suffix('.profile.log').write_text('')
        pairs = [(0,'SECTION'),(2,'ENTITIES'),(0,'LWPOLYLINE'),(90,3),(70,1),
                 (10,0),(20,0),(10,1),(20,0),(10,0),(20,1),(0,'ENDSEC'),(0,'EOF')]
        def write(groups):
            output.write_text(''.join(f'{code}\n{value}\n' for code,value in groups))
        write(pairs)
        check(output, 'profile')
        write([(code,0 if code==70 else value) for code,value in pairs])
        with self.assertRaisesRegex(ValueError, 'open or incomplete'):
            check(output, 'profile')
        write([(code,'nan' if code==20 else value) for code,value in pairs])
        with self.assertRaisesRegex(ValueError, 'invalid DXF edge'):
            check(output, 'profile')


    def test_state_snapshot_rejects_missing_or_nonfinite_native_data(self):
        output = self.output.with_suffix('.scad')
        payload = [30.123456789, [[0,0],[1,0],[0,1]], [[i,i] for i in range(121)]]
        self.log.write_text('ECHO: ' + json.dumps('CUSP_CACHE_JSON:' + json.dumps(payload)) + '\n')
        snapshot(self.log, output)
        self.assertIn('cached_distance=30.123456789;', output.read_text())
        self.assertIn('envelope_solver_collision_probe.scad>', output.read_text())
        self.log.write_text('')
        with self.assertRaisesRegex(ValueError, 'expected one'):
            snapshot(self.log, output)
        payload[1][0][0] = float('nan')
        self.log.write_text('ECHO: ' + json.dumps('CUSP_CACHE_JSON:' + json.dumps(payload)) + '\n')
        with self.assertRaisesRegex(ValueError, 'invalid native'):
            snapshot(self.log, output)

    def test_missing_or_invalid_mate_is_rejected(self):
        self.log.write_text('')
        with self.assertRaisesRegex(ValueError, 'missing/empty'):
            check(self.output, 'mesh')
        self.output.write_text('not a mesh')
        with self.assertRaises((AssertionError, ValueError)):
            check(self.output, 'mesh')


class DocumentationTests(unittest.TestCase):
    def test_public_parameters_require_types_and_matching_optional_defaults(self):
        source = '''/**
 * @function curve_gear_sample
 * @brief Build a sample shape.
 * @param required {number > 0} Required value.
 * @param optional {integer, default 4} Optional value.
 * @return {number} The input value.
 */
function curve_gear_sample(required, optional=4) = required + optional;
'''
        self.assertEqual([], check_source_text(source, 'sample.scad'))

    def test_missing_type_or_mismatched_default_is_reported(self):
        source = '''/**
 * @function curve_gear_sample
 * @brief Build a sample shape.
 * @param required Required value.
 * @param optional {integer, default 3} Optional value.
 * @return {number} The input value.
 */
function curve_gear_sample(required, optional=4) = required + optional;
'''
        findings = check_source_text(source, 'sample.scad')
        self.assertTrue(any('required' in finding and 'type' in finding for finding in findings))
        self.assertTrue(any('optional' in finding and 'default' in finding for finding in findings))

    def test_required_parameter_may_document_a_canonical_example_value(self):
        source = '''/**
 * @function curve_gear_sample
 * @brief Build a sample shape.
 * @param required {number > 0, default 0.8} Canonical example value.
 * @return {number} The input value.
 */
function curve_gear_sample(required) = required;
'''
        self.assertEqual([], check_source_text(source, 'sample.scad'))

    def test_every_definition_needs_its_own_documentation_entry(self):
        source = '''/**
 * @module Sample
 * @brief A source group.
 */
function _cg_undocumented(value) = value;
'''
        findings = check_source_text(source, 'sample.scad')
        self.assertTrue(any('_cg_undocumented' in finding for finding in findings))

    def test_markdown_allows_zero_or_one_module_and_rejects_multiple(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / 'plain.md').write_text('# Readme\n')
            (root / 'single.md').write_text('## Module `One`\n')
            (root / 'multiple.md').write_text('## Module `One`\n## Module `Two`\n')
            findings = check_markdown_modules(root)
            self.assertEqual(1, len(findings))
            self.assertIn('multiple.md', findings[0])


if __name__ == '__main__':
    unittest.main()
