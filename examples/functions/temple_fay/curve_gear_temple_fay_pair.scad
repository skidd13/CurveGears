/***
 * @function curve_gear_temple_fay_pair_example
 */
include <../../../src/temple_fay/pair.scad>
include <../../palette.scad>;
curve_gear_temple_fay_pair(.8,34,4,4.8,wing=.05,fold=.01,samples=240,phase=180,together_built=true,backlash=.5,clearance=.5,driver_color=example_driver_color,mate_color=example_mate_color);
