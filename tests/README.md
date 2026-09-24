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

> [`test_bezier_control_sets`](#function-test_bezier_control_sets): [`bezier/control_sets.scad`](bezier/control_sets.scad) — Bezier control sets test case.

> [`test_bezier_full_pipeline`](#function-test_bezier_full_pipeline): [`bezier/full_pipeline.scad`](bezier/full_pipeline.scad) — Bezier full pipeline test case.

> [`test_bezier_invalid_controls`](#function-test_bezier_invalid_controls): [`bezier/invalid_controls.scad`](bezier/invalid_controls.scad) — Deliberately open control list: the closure contract must reject it.

> [`test_bezier_invalid_tangent`](#function-test_bezier_invalid_tangent): [`bezier/invalid_tangent.scad`](bezier/invalid_tangent.scad) — Deliberately zero incoming tangent at the segment join.

> [`test_bezier_mate_pipeline`](#function-test_bezier_mate_pipeline): [`bezier/mate_pipeline.scad`](bezier/mate_pipeline.scad) — Bezier mate pipeline test case.

> [`test_cassini_full_pipeline`](#function-test_cassini_full_pipeline): [`cassini/full_pipeline.scad`](cassini/full_pipeline.scad) — Cassini family full maintained-entry-point render.

> [`test_cassini_invalid_ratio`](#function-test_cassini_invalid_ratio): [`cassini/invalid_ratio.scad`](cassini/invalid_ratio.scad) — The lemniscate and two-loop regimes are outside the radial family contract.

> [`test_cassini_pair_pipeline`](#function-test_cassini_pair_pipeline): [`cassini/pair_pipeline.scad`](cassini/pair_pipeline.scad) — Cassini family: common pair assembly plus standalone mate API.

> [`test_cassini_tooth_pipeline`](#function-test_cassini_tooth_pipeline): [`cassini/tooth_pipeline.scad`](cassini/tooth_pipeline.scad) — Cassini family promotion of the circular tooth pipeline.

> [`test_circle_full_pipeline`](#function-test_circle_full_pipeline): [`circle/full_pipeline.scad`](circle/full_pipeline.scad) — Public circle family contract: gear, mate, and pair.

> [`test_common_ordinary_variants`](#function-test_common_ordinary_variants): [`common/ordinary_variants.scad`](common/ordinary_variants.scad) — Ordinary circular cases covering more than one module/tooth-count pair.

> [`test_ellipse_full_pipeline`](#function-test_ellipse_full_pipeline): [`ellipse/full_pipeline.scad`](ellipse/full_pipeline.scad) — Ellipse full pipeline test case.

> [`test_ellipse_pair_pipeline`](#function-test_ellipse_pair_pipeline): [`ellipse/pair_pipeline.scad`](ellipse/pair_pipeline.scad) — Ellipse family: common pair assembly plus standalone mate API.

> [`test_ellipse_tooth_pipeline`](#function-test_ellipse_tooth_pipeline): [`ellipse/tooth_pipeline.scad`](ellipse/tooth_pipeline.scad) — Ellipse family promotion of the circular tooth pipeline.

> [`test_epitrochoid_contact`](#function-test_epitrochoid_contact): [`epitrochoid/contact.scad`](epitrochoid/contact.scad) — Epitrochoid contact test case.

> [`test_epitrochoid_full_pipeline`](#function-test_epitrochoid_full_pipeline): [`epitrochoid/full_pipeline.scad`](epitrochoid/full_pipeline.scad) — Epitrochoid full pipeline test case.

> [`test_epitrochoid_pair_pipeline`](#function-test_epitrochoid_pair_pipeline): [`epitrochoid/pair_pipeline.scad`](epitrochoid/pair_pipeline.scad) — Epitrochoid family: corrected sampling and radial-root semantics.

> [`test_epitrochoid_tooth_pipeline`](#function-test_epitrochoid_tooth_pipeline): [`epitrochoid/tooth_pipeline.scad`](epitrochoid/tooth_pipeline.scad) — Epitrochoid family: regular non-cusped profile through the shared pipeline.

> [`test_fourier_coefficient_sets`](#function-test_fourier_coefficient_sets): [`fourier/coefficient_sets.scad`](fourier/coefficient_sets.scad) — Fourier coefficient sets test case.

> [`test_fourier_full_pipeline`](#function-test_fourier_full_pipeline): [`fourier/full_pipeline.scad`](fourier/full_pipeline.scad) — Fourier full pipeline test case.

> [`test_fourier_invalid_coefficients`](#function-test_fourier_invalid_coefficients): [`fourier/invalid_coefficients.scad`](fourier/invalid_coefficients.scad) — Deliberately non-positive-radius coefficient envelope.

> [`test_hypotrochoid_full_pipeline`](#function-test_hypotrochoid_full_pipeline): [`hypotrochoid/full_pipeline.scad`](hypotrochoid/full_pipeline.scad) — Hypotrochoid family full maintained-entry-point render.

> [`test_hypotrochoid_invalid_ratio`](#function-test_hypotrochoid_invalid_ratio): [`hypotrochoid/invalid_ratio.scad`](hypotrochoid/invalid_ratio.scad) — Hypotrochoid invalid ratio test case.

> [`test_hypotrochoid_pair_pipeline`](#function-test_hypotrochoid_pair_pipeline): [`hypotrochoid/pair_pipeline.scad`](hypotrochoid/pair_pipeline.scad) — Hypotrochoid family: common pair assembly plus standalone mate API.

> [`test_hypotrochoid_tooth_pipeline`](#function-test_hypotrochoid_tooth_pipeline): [`hypotrochoid/tooth_pipeline.scad`](hypotrochoid/tooth_pipeline.scad) — Hypotrochoid family promotion of the circular tooth pipeline.

> [`test_lobed_full_pipeline`](#function-test_lobed_full_pipeline): [`lobed/full_pipeline.scad`](lobed/full_pipeline.scad) — Lobed full pipeline test case.

> [`test_lobed_pair_pipeline`](#function-test_lobed_pair_pipeline): [`lobed/pair_pipeline.scad`](lobed/pair_pipeline.scad) — Lobed family: common pair assembly plus standalone mate API.

> [`test_lobed_tooth_pipeline`](#function-test_lobed_tooth_pipeline): [`lobed/tooth_pipeline.scad`](lobed/tooth_pipeline.scad) — Lobed family promotion after the circular and elliptical basis cases.

> [`test_logarithmic_spiral_full_pipeline`](#function-test_logarithmic_spiral_full_pipeline): [`logarithmic_spiral/full_pipeline.scad`](logarithmic_spiral/full_pipeline.scad) — Logarithmic spiral full pipeline test case.

> [`test_logarithmic_spiral_pair_pipeline`](#function-test_logarithmic_spiral_pair_pipeline): [`logarithmic_spiral/pair_pipeline.scad`](logarithmic_spiral/pair_pipeline.scad) — Logarithmic spiral family: static/reference pair classification.

> [`test_logarithmic_spiral_tooth_pipeline`](#function-test_logarithmic_spiral_tooth_pipeline): [`logarithmic_spiral/tooth_pipeline.scad`](logarithmic_spiral/tooth_pipeline.scad) — Logarithmic-spiral family: radial return segments must omit inaccessible teeth.

> [`test_logarithmic_spiral_wraparound`](#function-test_logarithmic_spiral_wraparound): [`logarithmic_spiral/wraparound.scad`](logarithmic_spiral/wraparound.scad) — Nautilus wraparound: the final/first placement boundary is exercised with

> [`test_mate_motion_direct_cases`](#function-test_mate_motion_direct_cases): [`mate/motion/direct_cases.scad`](mate/motion/direct_cases.scad) — Direct conjugate-mate construction regression. The mate points are generated from driver-angle samples and the integrated rolling increments.  No inverse motion-table lookup is involved.

> [`test_mate_motion_phase_cases`](#function-test_mate_motion_phase_cases): [`mate/motion/phase_cases.scad`](mate/motion/phase_cases.scad) — Shared mate-motion phase regression. This is intentionally a small analytic fixture. It checks that every dynamic family accepts negative, zero, positive and full-turn phases while retaining the continuous wraparound convention used by pair assembly.

> [`test_pascal_full_pipeline`](#function-test_pascal_full_pipeline): [`pascal/full_pipeline.scad`](pascal/full_pipeline.scad) — Pascal full pipeline test case.

> [`test_pascal_pair_pipeline`](#function-test_pascal_pair_pipeline): [`pascal/pair_pipeline.scad`](pascal/pair_pipeline.scad) — Pascal family: convex pair and standalone mate API through the common assembly.

> [`test_pascal_tooth_pipeline`](#function-test_pascal_tooth_pipeline): [`pascal/tooth_pipeline.scad`](pascal/tooth_pipeline.scad) — Pascal family: validate one non-convex body with the shared tooth pipeline.

> [`test_superformula_accessibility_cases`](#function-test_superformula_accessibility_cases): [`superformula/accessibility_cases.scad`](superformula/accessibility_cases.scad) — Focused accessibility checks: shallow concavity remains usable, while a

> [`test_superformula_contact`](#function-test_superformula_contact): [`superformula/contact.scad`](superformula/contact.scad) — Superformula contact test case.

> [`test_superformula_full_pipeline`](#function-test_superformula_full_pipeline): [`superformula/full_pipeline.scad`](superformula/full_pipeline.scad) — Superformula full pipeline test case.

> [`test_superformula_mate_pipeline`](#function-test_superformula_mate_pipeline): [`superformula/mate_pipeline.scad`](superformula/mate_pipeline.scad) — Deliberate high-curvature mate splice failure; the structured diagnostic is expected.

> [`test_superformula_pair_pipeline`](#function-test_superformula_pair_pipeline): [`superformula/pair_pipeline.scad`](superformula/pair_pipeline.scad) — Superformula family: moderate pair used for the cached mate boundary.

> [`test_superformula_tooth_pipeline`](#function-test_superformula_tooth_pipeline): [`superformula/tooth_pipeline.scad`](superformula/tooth_pipeline.scad) — Superformula family: high-curvature single-gear tooth placement.

> [`test_tooth_generation_candidate_pipeline`](#function-test_tooth_generation_candidate_pipeline): [`tooth/generation/candidate_pipeline.scad`](tooth/generation/candidate_pipeline.scad) — Render the current cached candidate tooth in the same local frame.

> [`test_tooth_generation_equivalence`](#function-test_tooth_generation_equivalence): [`tooth/generation/equivalence.scad`](tooth/generation/equivalence.scad) — Keep the oracle export non-empty so the regression runner can execute it as

> [`test_tooth_generation_include`](#function-test_tooth_generation_include): [`tooth/generation/include.scad`](tooth/generation/include.scad) — Direct include smoke test for the standalone tooth-generation layer.

> [`test_tooth_generation_library`](#function-test_tooth_generation_library): [`tooth/generation/library.scad`](tooth/generation/library.scad) — Focused contract test for the reusable tooth-generation library.

> [`test_tooth_generation_reference`](#function-test_tooth_generation_reference): [`tooth/generation/reference.scad`](tooth/generation/reference.scad) — Compact mathematical oracle derived from the pinned reference source:

> [`test_tooth_generation_reference_pipeline`](#function-test_tooth_generation_reference_pipeline): [`tooth/generation/reference_pipeline.scad`](tooth/generation/reference_pipeline.scad) — Render the compact mathematical reference tooth for STL comparison.

> [`test_tooth_placement_collision_failure`](#function-test_tooth_placement_collision_failure): [`tooth/placement/collision_failure.scad`](tooth/placement/collision_failure.scad) — Expected-failure gate for a complete placed-tooth collision.

> [`test_tooth_placement_include`](#function-test_tooth_placement_include): [`tooth/placement/include.scad`](tooth/placement/include.scad) — Direct include smoke test for the standalone tooth-placement layer.

> [`test_tooth_placement_polygon_failure`](#function-test_tooth_placement_polygon_failure): [`tooth/placement/polygon_failure.scad`](tooth/placement/polygon_failure.scad) — Expected-failure gate for the final polygon self-intersection validator.

> [`test_tooth_placement_validation_cases`](#function-test_tooth_placement_validation_cases): [`tooth/placement/validation_cases.scad`](tooth/placement/validation_cases.scad) — Deliberate local and boundary failures.  Each assertion confirms that the


## Functions

The module `Test cases` defines the following functions.

### Function `test_bezier_control_sets`


[`bezier/control_sets.scad`](bezier/control_sets.scad) — Bezier control sets test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_bezier_full_pipeline`


[`bezier/full_pipeline.scad`](bezier/full_pipeline.scad) — Bezier full pipeline test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_bezier_invalid_controls`


[`bezier/invalid_controls.scad`](bezier/invalid_controls.scad) — Deliberately open control list: the closure contract must reject it.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_bezier_invalid_tangent`


[`bezier/invalid_tangent.scad`](bezier/invalid_tangent.scad) — Deliberately zero incoming tangent at the segment join.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_bezier_mate_pipeline`


[`bezier/mate_pipeline.scad`](bezier/mate_pipeline.scad) — Bezier mate pipeline test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_cassini_full_pipeline`


[`cassini/full_pipeline.scad`](cassini/full_pipeline.scad) — Cassini family full maintained-entry-point render.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_cassini_invalid_ratio`


[`cassini/invalid_ratio.scad`](cassini/invalid_ratio.scad) — The lemniscate and two-loop regimes are outside the radial family contract.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_cassini_pair_pipeline`


[`cassini/pair_pipeline.scad`](cassini/pair_pipeline.scad) — Cassini family: common pair assembly plus standalone mate API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_cassini_tooth_pipeline`


[`cassini/tooth_pipeline.scad`](cassini/tooth_pipeline.scad) — Cassini family promotion of the circular tooth pipeline.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_circle_full_pipeline`


[`circle/full_pipeline.scad`](circle/full_pipeline.scad) — Public circle family contract: gear, mate, and pair.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_common_ordinary_variants`


[`common/ordinary_variants.scad`](common/ordinary_variants.scad) — Ordinary circular cases covering more than one module/tooth-count pair.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_ellipse_full_pipeline`


[`ellipse/full_pipeline.scad`](ellipse/full_pipeline.scad) — Ellipse full pipeline test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_ellipse_pair_pipeline`


[`ellipse/pair_pipeline.scad`](ellipse/pair_pipeline.scad) — Ellipse family: common pair assembly plus standalone mate API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_ellipse_tooth_pipeline`


[`ellipse/tooth_pipeline.scad`](ellipse/tooth_pipeline.scad) — Ellipse family promotion of the circular tooth pipeline.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_epitrochoid_contact`


[`epitrochoid/contact.scad`](epitrochoid/contact.scad) — Epitrochoid contact test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_epitrochoid_full_pipeline`


[`epitrochoid/full_pipeline.scad`](epitrochoid/full_pipeline.scad) — Epitrochoid full pipeline test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_epitrochoid_pair_pipeline`


[`epitrochoid/pair_pipeline.scad`](epitrochoid/pair_pipeline.scad) — Epitrochoid family: corrected sampling and radial-root semantics.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_epitrochoid_tooth_pipeline`


[`epitrochoid/tooth_pipeline.scad`](epitrochoid/tooth_pipeline.scad) — Epitrochoid family: regular non-cusped profile through the shared pipeline.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_fourier_coefficient_sets`


[`fourier/coefficient_sets.scad`](fourier/coefficient_sets.scad) — Fourier coefficient sets test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_fourier_full_pipeline`


[`fourier/full_pipeline.scad`](fourier/full_pipeline.scad) — Fourier full pipeline test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_fourier_invalid_coefficients`


[`fourier/invalid_coefficients.scad`](fourier/invalid_coefficients.scad) — Deliberately non-positive-radius coefficient envelope.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_hypotrochoid_full_pipeline`


[`hypotrochoid/full_pipeline.scad`](hypotrochoid/full_pipeline.scad) — Hypotrochoid family full maintained-entry-point render.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_hypotrochoid_invalid_ratio`


[`hypotrochoid/invalid_ratio.scad`](hypotrochoid/invalid_ratio.scad) — Hypotrochoid invalid ratio test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_hypotrochoid_pair_pipeline`


[`hypotrochoid/pair_pipeline.scad`](hypotrochoid/pair_pipeline.scad) — Hypotrochoid family: common pair assembly plus standalone mate API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_hypotrochoid_tooth_pipeline`


[`hypotrochoid/tooth_pipeline.scad`](hypotrochoid/tooth_pipeline.scad) — Hypotrochoid family promotion of the circular tooth pipeline.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_lobed_full_pipeline`


[`lobed/full_pipeline.scad`](lobed/full_pipeline.scad) — Lobed full pipeline test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_lobed_pair_pipeline`


[`lobed/pair_pipeline.scad`](lobed/pair_pipeline.scad) — Lobed family: common pair assembly plus standalone mate API.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_lobed_tooth_pipeline`


[`lobed/tooth_pipeline.scad`](lobed/tooth_pipeline.scad) — Lobed family promotion after the circular and elliptical basis cases.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_logarithmic_spiral_full_pipeline`


[`logarithmic_spiral/full_pipeline.scad`](logarithmic_spiral/full_pipeline.scad) — Logarithmic spiral full pipeline test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_logarithmic_spiral_pair_pipeline`


[`logarithmic_spiral/pair_pipeline.scad`](logarithmic_spiral/pair_pipeline.scad) — Logarithmic spiral family: static/reference pair classification.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_logarithmic_spiral_tooth_pipeline`


[`logarithmic_spiral/tooth_pipeline.scad`](logarithmic_spiral/tooth_pipeline.scad) — Logarithmic-spiral family: radial return segments must omit inaccessible teeth.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_logarithmic_spiral_wraparound`


[`logarithmic_spiral/wraparound.scad`](logarithmic_spiral/wraparound.scad) — Nautilus wraparound: the final/first placement boundary is exercised with

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_mate_motion_direct_cases`


[`mate/motion/direct_cases.scad`](mate/motion/direct_cases.scad) — Direct conjugate-mate construction regression. The mate points are generated from driver-angle samples and the integrated rolling increments.  No inverse motion-table lookup is involved.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_mate_motion_phase_cases`


[`mate/motion/phase_cases.scad`](mate/motion/phase_cases.scad) — Shared mate-motion phase regression. This is intentionally a small analytic fixture. It checks that every dynamic family accepts negative, zero, positive and full-turn phases while retaining the continuous wraparound convention used by pair assembly.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_pascal_full_pipeline`


[`pascal/full_pipeline.scad`](pascal/full_pipeline.scad) — Pascal full pipeline test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_pascal_pair_pipeline`


[`pascal/pair_pipeline.scad`](pascal/pair_pipeline.scad) — Pascal family: convex pair and standalone mate API through the common assembly.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_pascal_tooth_pipeline`


[`pascal/tooth_pipeline.scad`](pascal/tooth_pipeline.scad) — Pascal family: validate one non-convex body with the shared tooth pipeline.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_superformula_accessibility_cases`


[`superformula/accessibility_cases.scad`](superformula/accessibility_cases.scad) — Focused accessibility checks: shallow concavity remains usable, while a

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_superformula_contact`


[`superformula/contact.scad`](superformula/contact.scad) — Superformula contact test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_superformula_full_pipeline`


[`superformula/full_pipeline.scad`](superformula/full_pipeline.scad) — Superformula full pipeline test case.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_superformula_mate_pipeline`


[`superformula/mate_pipeline.scad`](superformula/mate_pipeline.scad) — Deliberate high-curvature mate splice failure; the structured diagnostic is expected.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_superformula_pair_pipeline`


[`superformula/pair_pipeline.scad`](superformula/pair_pipeline.scad) — Superformula family: moderate pair used for the cached mate boundary.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_superformula_tooth_pipeline`


[`superformula/tooth_pipeline.scad`](superformula/tooth_pipeline.scad) — Superformula family: high-curvature single-gear tooth placement.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_tooth_generation_candidate_pipeline`


[`tooth/generation/candidate_pipeline.scad`](tooth/generation/candidate_pipeline.scad) — Render the current cached candidate tooth in the same local frame.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_tooth_generation_equivalence`


[`tooth/generation/equivalence.scad`](tooth/generation/equivalence.scad) — Keep the oracle export non-empty so the regression runner can execute it as

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_tooth_generation_include`


[`tooth/generation/include.scad`](tooth/generation/include.scad) — Direct include smoke test for the standalone tooth-generation layer.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_tooth_generation_library`


[`tooth/generation/library.scad`](tooth/generation/library.scad) — Focused contract test for the reusable tooth-generation library.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_tooth_generation_reference`


[`tooth/generation/reference.scad`](tooth/generation/reference.scad) — Compact mathematical oracle derived from the pinned reference source:

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_tooth_generation_reference_pipeline`


[`tooth/generation/reference_pipeline.scad`](tooth/generation/reference_pipeline.scad) — Render the compact mathematical reference tooth for STL comparison.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_tooth_placement_collision_failure`


[`tooth/placement/collision_failure.scad`](tooth/placement/collision_failure.scad) — Expected-failure gate for a complete placed-tooth collision.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_tooth_placement_include`


[`tooth/placement/include.scad`](tooth/placement/include.scad) — Direct include smoke test for the standalone tooth-placement layer.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_tooth_placement_polygon_failure`


[`tooth/placement/polygon_failure.scad`](tooth/placement/polygon_failure.scad) — Expected-failure gate for the final polygon self-intersection validator.

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).

### Function `test_tooth_placement_validation_cases`


[`tooth/placement/validation_cases.scad`](tooth/placement/validation_cases.scad) — Deliberate local and boundary failures.  Each assertion confirms that the

**Parameters:**

No parameters

**Returns:**

No return

Back to [module description](#module-test-cases).


Back to [top](#).

---

[Back to the CurveGears README](../README.md)

*Generated by Doxydown from repository source comments; do not edit this page directly.*
