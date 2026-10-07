/**
 * @function temple_fay_full_pipeline
 * @brief Exercise Temple Fay gear, body, mate and reference pair calls.
 */
include <../../src/temple_fay/pair.scad>
translate([-100,0,0]) curve_gear_temple_fay(.8,34,4,4.8,samples=240);
translate([-35,0,0]) curve_gear_temple_fay_body(.8,34,4,4.8,samples=240);
translate([35,0,0]) curve_gear_temple_fay_mate(.8,34,4,4.8,samples=240);
translate([100,0,0]) curve_gear_temple_fay_pair(.8,34,4,4.8,samples=240);
