/** @function curve_gear_logistic_dwell_example
 * @brief Logistic Dwell gear example.
  * @image ../images/functions/logistic_dwell/curve_gear_logistic_dwell.png logistic dwell example preview
*/
include <../../../src/logistic_dwell/gear.scad>
include <../../palette.scad>;
$fn=64;
include <../../../src/logistic_dwell/pair.scad>;

module _main_example_logistic_dwell_view(view="gear") {
    if (view=="pair") {
            curve_gear_logistic_dwell_pair(.8,34,4,4.8,gain=8,depth=.2,samples=240,together_built=true,backlash=.3,driver_color=example_driver_color,mate_color=example_mate_color);
    }
    else if  (view=="body") {
        color(example_driver_color)
            curve_gear_logistic_dwell_body(.8,34,4,4.8,gain=8,depth=.2,samples=240);
    }
    else if  (view=="mate") {
        color(example_mate_color)
            curve_gear_logistic_dwell_mate(.8,34,4,4.8,gain=8,depth=.2,samples=240);
    }
    else if  (view=="gear_2d") {
        color(example_driver_color)
            curve_gear_logistic_dwell_2d(.8,34,4.8,gain=8,depth=.2,samples=240);
    }
    else if  (view=="body_2d") {
        color(example_driver_color)
            curve_gear_logistic_dwell_body_2d(.8,34,4.8,gain=8,depth=.2,samples=240);
    }
    else {
        $fn=64;
        color(example_driver_color)
            curve_gear_logistic_dwell(.8,34,4,4.8,samples=240);
    }
}
module _main_example_logistic_dwell() { _main_example_logistic_dwell_view(); }
_main_example_logistic_dwell();
