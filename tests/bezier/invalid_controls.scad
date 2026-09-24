/***
 * @function bezier_invalid_controls
 * @brief Deliberately open control list: the closure contract must reject it.
 * Source: [`bezier/invalid_controls.scad`](bezier/invalid_controls.scad)
 */
include <../../src/bezier/gear.scad>
curve_gear_bezier(.8,34,4,4.8,control_points=[[1,0],[1,.5523],[.5523,1],[0,1]],samples=120);
