# Test catalogue

## Documentation navigation

- [README](../README.md)
- Families
  - [Bézier](../docs/bezier.md) · [Cassini](../docs/cassini.md) · [Circle](../docs/circle.md) · [Ellipse](../docs/ellipse.md) · [Epitrochoid](../docs/epitrochoid.md) · [Fourier](../docs/fourier.md)
  - [Hypotrochoid](../docs/hypotrochoid.md) · [Lobed](../docs/lobed.md) · [Logarithmic spiral](../docs/logarithmic_spiral.md) · [Pascal](../docs/pascal.md) · [Superformula](../docs/superformula.md)
- Shared
  - [Examples catalogue](../examples/README.md) · [Test layout](README.md)
  - [Tooth construction](../docs/tooth-construction.md) · [Tooth placement](../docs/tooth-placement.md) · [Mate motion](../docs/mate-motion.md) · [Mate generation](../docs/mate-generation.md) · [Pair assembly](../docs/pair-assembly.md)


Each fixture below is catalogued as a function in one Doxydown test module. Make discovers fixtures and assigns mirrored regression outputs automatically; generated meshes and reports remain under the ignored build directory.

## Module `Test cases`

Executable regression and contract test fixtures.

### Brief content:

**Functions**:

> [`bezier_control_sets`](#function-bezier_control_sets): Verify Bézier control sets preserve closure and admissible sampling.

> [`bezier_full_pipeline`](#function-bezier_full_pipeline): Verify the complete Bezier gear, mate, and pair entry points.

> [`bezier_invalid_controls`](#function-bezier_invalid_controls): Deliberately open control list: the closure contract must reject it.

> [`bezier_invalid_tangent`](#function-bezier_invalid_tangent): Deliberately zero incoming tangent at the segment join.

> [`bezier_mate_pipeline`](#function-bezier_mate_pipeline): Verify Bézier mate construction through the shared pair pipeline.

> [`cassini_full_pipeline`](#function-cassini_full_pipeline): Verify the complete Cassini gear, mate, and pair entry points.

> [`cassini_invalid_ratio`](#function-cassini_invalid_ratio): Reject Cassini parameters outside the admissible radial range.

> [`cassini_pair_pipeline`](#function-cassini_pair_pipeline): Verify Cassini pair assembly and conjugate mate placement.

> [`cassini_tooth_pipeline`](#function-cassini_tooth_pipeline): Verify Cassini tooth placement through the shared tooth pipeline.

> [`circle_full_pipeline`](#function-circle_full_pipeline): Verify the complete Circle gear, mate, and pair entry points.

> [`common_ordinary_variants`](#function-common_ordinary_variants): Ordinary circular cases covering more than one module/tooth-count pair.

> [`ellipse_full_pipeline`](#function-ellipse_full_pipeline): Verify the complete Ellipse gear, mate, and pair entry points.

> [`ellipse_pair_pipeline`](#function-ellipse_pair_pipeline): Verify Ellipse pair assembly and conjugate mate placement.

> [`ellipse_tooth_pipeline`](#function-ellipse_tooth_pipeline): Verify Ellipse tooth placement through the shared tooth pipeline.

> [`epitrochoid_contact`](#function-epitrochoid_contact): Verify Epitrochoid contact geometry and pitch diagnostics.

> [`epitrochoid_full_pipeline`](#function-epitrochoid_full_pipeline): Verify the complete Epitrochoid gear, mate, and pair entry points.

> [`epitrochoid_pair_pipeline`](#function-epitrochoid_pair_pipeline): Verify Epitrochoid pair assembly and conjugate mate placement.

> [`epitrochoid_tooth_pipeline`](#function-epitrochoid_tooth_pipeline): Verify Epitrochoid tooth placement through the shared tooth pipeline.

> [`fourier_coefficient_sets`](#function-fourier_coefficient_sets): Verify Fourier coefficient sets produce the expected pitch curves.

> [`fourier_full_pipeline`](#function-fourier_full_pipeline): Verify the complete Fourier gear, mate, and pair entry points.

> [`fourier_invalid_coefficients`](#function-fourier_invalid_coefficients): Deliberately non-positive-radius coefficient envelope.

> [`hypotrochoid_full_pipeline`](#function-hypotrochoid_full_pipeline): Verify the complete Hypotrochoid gear, mate, and pair entry points.

> [`hypotrochoid_invalid_ratio`](#function-hypotrochoid_invalid_ratio): Reject Hypotrochoid parameters outside the admissible radial range.

> [`hypotrochoid_pair_pipeline`](#function-hypotrochoid_pair_pipeline): Verify Hypotrochoid pair assembly and conjugate mate placement.

> [`hypotrochoid_tooth_pipeline`](#function-hypotrochoid_tooth_pipeline): Verify Hypotrochoid tooth placement through the shared tooth pipeline.

> [`lobed_full_pipeline`](#function-lobed_full_pipeline): Verify the complete Lobed gear, mate, and pair entry points.

> [`lobed_pair_pipeline`](#function-lobed_pair_pipeline): Verify Lobed pair assembly and conjugate mate placement.

> [`lobed_tooth_pipeline`](#function-lobed_tooth_pipeline): Verify Lobed tooth placement through the shared tooth pipeline.

> [`logarithmic_spiral_full_pipeline`](#function-logarithmic_spiral_full_pipeline): Verify the complete Logarithmic spiral gear, mate, and pair entry points.

> [`logarithmic_spiral_pair_pipeline`](#function-logarithmic_spiral_pair_pipeline): Verify Logarithmic spiral pair assembly and conjugate mate placement.

> [`logarithmic_spiral_tooth_pipeline`](#function-logarithmic_spiral_tooth_pipeline): Verify Logarithmic spiral tooth placement through the shared tooth pipeline.

> [`logarithmic_spiral_wraparound`](#function-logarithmic_spiral_wraparound): Nautilus wraparound: the final/first placement boundary is exercised with

> [`mate_motion_direct_cases`](#function-mate_motion_direct_cases): Direct conjugate-mate construction regression.

> [`mate_motion_phase_cases`](#function-mate_motion_phase_cases): Shared mate-motion phase regression.

> [`mate_phase_forwarding`](#function-mate_phase_forwarding): Verify that mate tooth phase reaches the shared placement engine.

> [`pascal_full_pipeline`](#function-pascal_full_pipeline): Verify the complete Pascal gear, mate, and pair entry points.

> [`pascal_pair_pipeline`](#function-pascal_pair_pipeline): Verify Pascal pair assembly and conjugate mate placement.

> [`pascal_tooth_pipeline`](#function-pascal_tooth_pipeline): Verify Pascal tooth placement through the shared tooth pipeline.

> [`superformula_accessibility_cases`](#function-superformula_accessibility_cases): Focused accessibility checks: shallow concavity remains usable, while a

> [`superformula_contact`](#function-superformula_contact): Verify Superformula contact geometry and pitch diagnostics.

> [`superformula_full_pipeline`](#function-superformula_full_pipeline): Verify the complete Superformula gear, mate, and pair entry points.

> [`superformula_mate_pipeline`](#function-superformula_mate_pipeline): Verify Bézier mate construction through the shared pair pipeline.

> [`superformula_pair_pipeline`](#function-superformula_pair_pipeline): Verify Superformula pair assembly and conjugate mate placement.

> [`superformula_tooth_pipeline`](#function-superformula_tooth_pipeline): Verify Superformula tooth placement through the shared tooth pipeline.

> [`tooth_generation_candidate_pipeline`](#function-tooth_generation_candidate_pipeline): Render the current cached candidate tooth in the same local frame.

> [`tooth_generation_equivalence`](#function-tooth_generation_equivalence): Keep the oracle export non-empty so the regression runner can execute it as

> [`tooth_generation_include`](#function-tooth_generation_include): Direct include smoke test for the standalone tooth-generation layer.

> [`tooth_generation_library`](#function-tooth_generation_library): Focused contract test for the reusable tooth-generation library.

> [`tooth_generation_reference`](#function-tooth_generation_reference): Compact mathematical oracle derived from the pinned reference source:

> [`tooth_generation_reference_pipeline`](#function-tooth_generation_reference_pipeline): Render the compact mathematical reference tooth for STL comparison.

> [`tooth_placement_collision_failure`](#function-tooth_placement_collision_failure): Expected-failure gate for a complete placed-tooth collision.

> [`tooth_placement_include`](#function-tooth_placement_include): Direct include smoke test for the standalone tooth-placement layer.

> [`tooth_placement_polygon_failure`](#function-tooth_placement_polygon_failure): Expected-failure gate for the final polygon self-intersection validator.

> [`tooth_placement_validation_cases`](#function-tooth_placement_validation_cases): Deliberate local and boundary failures.  Each assertion confirms that the


## Functions

The module `Test cases` defines the following functions.

### Function `bezier_control_sets`


Source: [`bezier/control_sets.scad`](bezier/control_sets.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `bezier_full_pipeline`


Source: [`bezier/full_pipeline.scad`](bezier/full_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `bezier_invalid_controls`


Source: [`bezier/invalid_controls.scad`](bezier/invalid_controls.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `bezier_invalid_tangent`


Source: [`bezier/invalid_tangent.scad`](bezier/invalid_tangent.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `bezier_mate_pipeline`


Source: [`bezier/mate_pipeline.scad`](bezier/mate_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `cassini_full_pipeline`


Source: [`cassini/full_pipeline.scad`](cassini/full_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `cassini_invalid_ratio`


Source: [`cassini/invalid_ratio.scad`](cassini/invalid_ratio.scad)

The lemniscate and two-loop regimes are outside the radial family contract.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `cassini_pair_pipeline`


Source: [`cassini/pair_pipeline.scad`](cassini/pair_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `cassini_tooth_pipeline`


Source: [`cassini/tooth_pipeline.scad`](cassini/tooth_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `circle_full_pipeline`


Source: [`circle/full_pipeline.scad`](circle/full_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `common_ordinary_variants`


Source: [`common/ordinary_variants.scad`](common/ordinary_variants.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `ellipse_full_pipeline`


Source: [`ellipse/full_pipeline.scad`](ellipse/full_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `ellipse_pair_pipeline`


Source: [`ellipse/pair_pipeline.scad`](ellipse/pair_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `ellipse_tooth_pipeline`


Source: [`ellipse/tooth_pipeline.scad`](ellipse/tooth_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `epitrochoid_contact`


Source: [`epitrochoid/contact.scad`](epitrochoid/contact.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `epitrochoid_full_pipeline`


Source: [`epitrochoid/full_pipeline.scad`](epitrochoid/full_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `epitrochoid_pair_pipeline`


Source: [`epitrochoid/pair_pipeline.scad`](epitrochoid/pair_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `epitrochoid_tooth_pipeline`


Source: [`epitrochoid/tooth_pipeline.scad`](epitrochoid/tooth_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `fourier_coefficient_sets`


Source: [`fourier/coefficient_sets.scad`](fourier/coefficient_sets.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `fourier_full_pipeline`


Source: [`fourier/full_pipeline.scad`](fourier/full_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `fourier_invalid_coefficients`


Source: [`fourier/invalid_coefficients.scad`](fourier/invalid_coefficients.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `hypotrochoid_full_pipeline`


Source: [`hypotrochoid/full_pipeline.scad`](hypotrochoid/full_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `hypotrochoid_invalid_ratio`


Source: [`hypotrochoid/invalid_ratio.scad`](hypotrochoid/invalid_ratio.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `hypotrochoid_pair_pipeline`


Source: [`hypotrochoid/pair_pipeline.scad`](hypotrochoid/pair_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `hypotrochoid_tooth_pipeline`


Source: [`hypotrochoid/tooth_pipeline.scad`](hypotrochoid/tooth_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `lobed_full_pipeline`


Source: [`lobed/full_pipeline.scad`](lobed/full_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `lobed_pair_pipeline`


Source: [`lobed/pair_pipeline.scad`](lobed/pair_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `lobed_tooth_pipeline`


Source: [`lobed/tooth_pipeline.scad`](lobed/tooth_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `logarithmic_spiral_full_pipeline`


Source: [`logarithmic_spiral/full_pipeline.scad`](logarithmic_spiral/full_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `logarithmic_spiral_pair_pipeline`


Source: [`logarithmic_spiral/pair_pipeline.scad`](logarithmic_spiral/pair_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `logarithmic_spiral_tooth_pipeline`


Source: [`logarithmic_spiral/tooth_pipeline.scad`](logarithmic_spiral/tooth_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `logarithmic_spiral_wraparound`


Source: [`logarithmic_spiral/wraparound.scad`](logarithmic_spiral/wraparound.scad)

a phase near one full turn and the radial return remains canonical.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `mate_motion_direct_cases`


Source: [`mate/motion/direct_cases.scad`](mate/motion/direct_cases.scad)

The mate points are generated from driver-angle samples and the integrated
rolling increments.  No inverse motion-table lookup is involved.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `mate_motion_phase_cases`


Source: [`mate/motion/phase_cases.scad`](mate/motion/phase_cases.scad)

This is intentionally a small analytic fixture. It checks that every
dynamic family accepts negative, zero, positive and full-turn phases while
retaining the continuous wraparound convention used by pair assembly.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `mate_phase_forwarding`


Verify that mate tooth phase reaches the shared placement engine.

**Parameters:**

No parameters

**Returns:**

- `{geometry}`: Small validation solid.

Back to [module description](#module-test-cases).

### Function `pascal_full_pipeline`


Source: [`pascal/full_pipeline.scad`](pascal/full_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `pascal_pair_pipeline`


Source: [`pascal/pair_pipeline.scad`](pascal/pair_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `pascal_tooth_pipeline`


Source: [`pascal/tooth_pipeline.scad`](pascal/tooth_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `superformula_accessibility_cases`


Source: [`superformula/accessibility_cases.scad`](superformula/accessibility_cases.scad)

deep U-shaped contour deliberately omits blocked source positions.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `superformula_contact`


Source: [`superformula/contact.scad`](superformula/contact.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `superformula_full_pipeline`


Source: [`superformula/full_pipeline.scad`](superformula/full_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `superformula_mate_pipeline`


Source: [`superformula/mate_pipeline.scad`](superformula/mate_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `superformula_pair_pipeline`


Source: [`superformula/pair_pipeline.scad`](superformula/pair_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `superformula_tooth_pipeline`


Source: [`superformula/tooth_pipeline.scad`](superformula/tooth_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `tooth_generation_candidate_pipeline`


Source: [`tooth/generation/candidate_pipeline.scad`](tooth/generation/candidate_pipeline.scad)

The inward support segment exists only to establish curved-body splices.
Compare the active reference involute/top profile, including its historical
centre sentinel, so this STL remains a mathematical equivalence check.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `tooth_generation_equivalence`


Source: [`tooth/generation/equivalence.scad`](tooth/generation/equivalence.scad)

an ordinary OpenSCAD case while the assertions remain the actual test.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `tooth_generation_include`


Source: [`tooth/generation/include.scad`](tooth/generation/include.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `tooth_generation_library`


Source: [`tooth/generation/library.scad`](tooth/generation/library.scad)

Exercise both the calculated polygon and the legacy compatibility module.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `tooth_generation_reference`


Source: [`tooth/generation/reference.scad`](tooth/generation/reference.scad)

https://github.com/chrisspen/gears/tree/15793cf3377773e417f52dc91ea7f28a2d25dde0
This project does not vendor the upstream gears.scad repository.

This is a deliberately small, renderable reference tooth. It preserves the
pinned involute equations while leaving the production candidate and its
placement/validation code under test.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `tooth_generation_reference_pipeline`


Source: [`tooth/generation/reference_pipeline.scad`](tooth/generation/reference_pipeline.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `tooth_placement_collision_failure`


Source: [`tooth/placement/collision_failure.scad`](tooth/placement/collision_failure.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `tooth_placement_include`


Source: [`tooth/placement/include.scad`](tooth/placement/include.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `tooth_placement_polygon_failure`


Source: [`tooth/placement/polygon_failure.scad`](tooth/placement/polygon_failure.scad)

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `tooth_placement_validation_cases`


Source: [`tooth/placement/validation_cases.scad`](tooth/placement/validation_cases.scad)

expected diagnostic classification is produced rather than repaired away.

The assertions are the test; the final OpenSCAD export is kept valid so the
fixture can still be rendered normally.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
