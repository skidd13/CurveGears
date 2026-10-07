/**
 * @function logistic_dwell_full_pipeline
 * @brief Verify the complete Logistic Dwell gear, mate and pair entry points.
 */
include <../../src/logistic_dwell/pair.scad>
$fn=48;
translate([-100,0,0]) curve_gear_logistic_dwell(.8,34,4,4.8,samples=120);
translate([-35,0,0]) curve_gear_logistic_dwell_body(.8,34,4,4.8,samples=120);
translate([35,0,0]) curve_gear_logistic_dwell_mate(.8,34,4,4.8,samples=120);
translate([100,0,0]) curve_gear_logistic_dwell_pair(.8,34,4,4.8,samples=120);
