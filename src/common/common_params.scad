/***
 * @module Common Parameters
 * @brief Shared constants and tolerances used by the CurveGears implementation.
 *
 * Historical constants are retained for numerical compatibility.
 */
// Historical constants are retained for numerical compatibility.
_cg_pi = 3.14159;
_cg_deg_per_rad = 57.29578;
_cg_tolerance = 1e-7;
_cg_default_fn = 50;
_cg_circle_pi = 3.141592653589793;

/**
 * @module _cg_assert_samples
 * @brief Validate a sampled-curve count while preserving the caller diagnostic.
 * @param samples {integer >= minimum} Requested sample count.
 * @param message {string} Caller-specific diagnostic message.
 * @param minimum {integer, default 120} Minimum supported sample count.
 */
module _cg_assert_samples(samples,message="samples must be an integer >= 120",minimum=120) {
    assert(samples >= minimum && floor(samples)==samples,message);
}
