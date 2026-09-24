// Render the current cached candidate tooth in the same local frame.
include <../../../src/common/curve_gears_math.scad>

$fn=96;
modul=.8;
tooth_number=34;
candidate=_cg_reference_tooth_candidate(modul*tooth_number/2,modul,tooth_number,20);
assert(candidate[0],str("candidate tooth invalid: ",candidate[1]));
left=candidate[4];
right=candidate[5];
left_start=left[0][0] < left[1][0]-_cg_eps_len() ? 1 : 0;
right_start=right[0][0] < right[1][0]-_cg_eps_len() ? 1 : 0;
// The inward support segment exists only to establish curved-body splices.
// Compare the active reference involute/top profile, including its historical
// centre sentinel, so this STL remains a mathematical equivalence check.
reference_profile=concat(
    [[0,0]],
    [for(i=[left_start:len(left)-2]) left[i]],
    [candidate[6],candidate[7]],
    [for(i=[len(right)-2:-1:right_start]) right[i]]
);
linear_extrude(height=4,convexity=4)
    polygon(reference_profile);
