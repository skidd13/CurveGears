"""Coverage omissions and wrong fixture roles must not shrink a successful run."""
from pathlib import Path
import tempfile
import unittest
import subprocess

ROOT = Path(__file__).resolve().parents[2]
from utils.regression.manifest import load, smoke_assignments


class ManifestCoverageTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        self.manifest = self.root / 'build/checks/smoke_manifest.tsv'
        self.manifest.parent.mkdir(parents=True)
        for source, text in {
            'common/probe.scad': 'cube(1);',
            'mate/full_pipeline.scad': 'cube(1);',
            'circle/probe.scad': 'cube(1);',
            'circle/manual.scad': '// @regression: manual\ncube(1);',
            'circle/deliberate.scad': '// @regression: deliberate\nassert(false);',
            'circle/invalid_input.scad': 'assert(false);',
        }.items():
            path = self.root / 'tests' / source
            path.parent.mkdir(parents=True, exist_ok=True)
            path.write_text(text)
        self.rows = [
            'tests/common/probe.scad\tbuild/checks/smoke/common/probe.stl',
            'tests/mate/full_pipeline.scad\tbuild/checks/smoke/mate/full_pipeline.csg',
            'tests/circle/probe.scad\tbuild/checks/smoke/circle/probe.stl',
        ]

    def write(self, rows):
        self.manifest.write_text('\n'.join(rows)+'\n' if rows else '')
        return load(self.manifest, self.root)

    def test_complete_catalogue_preserves_family_selection(self):
        cases = self.write(self.rows)
        self.assertEqual({'common_math','mate_motion','circle'}, {row[0] for row in cases})
        self.assertEqual(1, len([row for row in cases if row[0]=='circle']))

    def test_empty_or_missing_row_is_rejected(self):
        for rows in ([], self.rows[:-1], self.rows[1:]):
            with self.subTest(rows=rows), self.assertRaises(AssertionError):
                self.write(rows)

    def test_non_smoke_roles_cannot_substitute_for_a_required_case(self):
        for name in ('manual','deliberate','invalid_input'):
            with self.subTest(name=name), self.assertRaises(AssertionError):
                self.write(self.rows[:-1]+[f'tests/circle/{name}.scad\tbuild/checks/smoke/circle/{name}.stl'])

    def test_wrong_output_location_or_tier_is_rejected(self):
        for output in ('build/checks/smoke/common/probe.csg', 'build/elsewhere/probe.stl', '../probe.stl'):
            with self.subTest(output=output), self.assertRaises(AssertionError):
                self.write([self.rows[0].split('\t')[0]+'\t'+output]+self.rows[1:])

    def test_duplicate_assignment_is_rejected(self):
        with self.assertRaises(AssertionError):
            self.write(self.rows+[self.rows[0]])

    def test_absolute_source_is_rejected_even_when_it_is_canonical(self):
        absolute = str(self.root/'tests/common/probe.scad')
        with self.assertRaisesRegex(AssertionError, 'absolute manifest source'):
            self.write([absolute+'\t'+self.rows[0].split('\t')[1]]+self.rows[1:])

    def test_duplicate_output_is_rejected(self):
        duplicate = self.rows[1].split('\t')[0]+'\t'+self.rows[0].split('\t')[1]
        with self.assertRaisesRegex(AssertionError, 'duplicate manifest output'):
            self.write([self.rows[0],duplicate,self.rows[2]])

    def test_manifest_noop_retains_timestamp(self):
        with tempfile.TemporaryDirectory(dir=ROOT/'build') as directory:
            manifest = Path(directory)/'smoke_manifest.tsv'
            command = ['make',str(manifest.relative_to(ROOT)),
                       f'REGRESSION_DIR={Path(directory).relative_to(ROOT)}']
            subprocess.run(command,cwd=ROOT,capture_output=True,text=True,check=True)
            before = manifest.stat().st_mtime_ns
            subprocess.run(command,cwd=ROOT,capture_output=True,text=True,check=True)
            self.assertEqual(before, manifest.stat().st_mtime_ns)
            self.assertEqual(len(load(manifest,ROOT)),
                             len(smoke_assignments(ROOT, manifest.parent)))

    def test_common_alias_keeps_all_four_shared_groups(self):
        with tempfile.TemporaryDirectory(dir=ROOT/'build') as directory:
            result = subprocess.run(['make','-n','test','family=common',
                f'REGRESSION_DIR={Path(directory).relative_to(ROOT)}','OPENSCAD=openscad'],
                cwd=ROOT,capture_output=True,text=True,check=True)
        for family in ('common_math','tooth_generation','tooth_placement','mate_motion'):
            self.assertIn('--family '+family, result.stdout)
