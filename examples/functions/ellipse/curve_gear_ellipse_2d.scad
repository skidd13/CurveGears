/***
 * @function curve_gear_ellipse_2d
 * @brief Render the complete ellipse gear profile as flat 2D geometry.
 * Source: [`functions/ellipse/curve_gear_ellipse_2d.scad`](functions/ellipse/curve_gear_ellipse_2d.scad)
 * @image ../images/functions/ellipse/curve_gear_ellipse_2d.png ellipse 2D gear outline
 * @image ../utils/doxydown-support/table-spacer-512.png ⠀
 */
include <../../../src/ellipse/gear.scad>;
curve_gear_ellipse_2d(0.8, 34, 4.8, eccentricity=0.72, samples=240);
