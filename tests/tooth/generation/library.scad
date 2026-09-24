/***
 * @function tooth_generation_library
 * @brief Focused contract test for the reusable tooth-generation library.
 * Source: [`tooth/generation/library.scad`](tooth/generation/library.scad)
 *
 * Exercise both the calculated polygon and the legacy compatibility module.
 */
include <../../../src/tooth/generation.scad>
include <../../../src/tooth/placement.scad>

$fn=64;
modul=.8;
tooth_number=34;
pressure_angle=20;
pitch_radius=modul*tooth_number/2;
angles=_cg_tooth_angles(modul,tooth_number,pressure_angle);
polygon_points=_cg_tooth_polygon(modul,tooth_number,pressure_angle);
candidate=_cg_reference_tooth_candidate(pitch_radius,modul,tooth_number,pressure_angle);

assert(abs(_cg_addendum(modul)-.88)<_cg_eps_len(),"tooth addendum contract changed");
assert(_cg_default_clearance(modul)>0,"tooth clearance contract failed");
assert(_cg_dedendum(modul)>0 && _cg_default_backlash(modul)>0,"tooth root contract failed");
assert(angles[0]>0 && angles[1]>angles[0] && angles[2]>0,"tooth angle contract failed");
assert(_cg_polyline_finite(polygon_points),"tooth polygon contains non-finite coordinates");
assert(_cg_polygon_area(polygon_points)>0,"tooth polygon has no area");
assert(candidate[0],str("reference tooth candidate failed: ",candidate[1]));
assert(len(candidate[8])>=6,"reference tooth boundary contract failed");

linear_extrude(height=4,convexity=4)
    polygon(polygon_points);
translate([pitch_radius*1.8,0,0])
    linear_extrude(height=4,convexity=4)
        _cg_involute_tooth(modul,tooth_number,pressure_angle);
