/***
 * @module Circle
 * @brief Circular reference geometry for the canonical CurveGears family.
 *
 * The circle family exists primarily for testing and reference purposes. It
 * is the constant-radius control case used to exercise the same public gear,
 * mate, and pair contracts as every curved family.
 */
include <../common/curve_gears_math.scad>

function _cg_circle_radius(modul,tooth_number) = modul*tooth_number/2;
function _cg_circle_points(modul,tooth_number,samples=480) =
    let(radius=_cg_circle_radius(modul,tooth_number))
    [for(i=[0:samples-1]) [radius*cos(360*i/samples),radius*sin(360*i/samples)]];
