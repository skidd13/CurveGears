/***
 * @function superformula_accessibility_cases
 * @brief Focused accessibility checks: shallow concavity remains usable, while a
 * Source: [`superformula/accessibility_cases.scad`](superformula/accessibility_cases.scad)
 *
 * deep U-shaped contour deliberately omits blocked source positions.
 */
include <../../src/superformula/gear.scad>

function accessibility_results(points,modul,tooth_number,candidate) =
    let(
        arc=_cg_polyline_arc_table(points),
        perimeter=arc[len(arc)-1][1],
        body=_cg_canonical_body_polyline(points,arc,perimeter,_cg_dedendum(modul),false)
    )
    [for(i=[0:tooth_number-1])
        let(target=perimeter*(i+.25)/tooth_number,
            result=_cg_accessibility_result(points,arc,perimeter,body,target,perimeter/tooth_number,modul,candidate,false))
        result];

function accessibility_indices(results) = [for(i=[0:len(results)-1]) if(results[i][0]) i];

shallow_modul=.8;
shallow_teeth=34;
shallow_samples=360;
shallow_scale=_cg_superformula_scale(shallow_modul,shallow_teeth,5,1,1,2.4,3.4,3.4,shallow_samples);
shallow_points=_cg_superformula_points(shallow_scale,5,1,1,2.4,3.4,3.4,shallow_samples);
shallow_candidate=_cg_reference_tooth_candidate(shallow_modul*shallow_teeth/2,shallow_modul,shallow_teeth,20);
shallow_results=accessibility_results(shallow_points,shallow_modul,shallow_teeth,shallow_candidate);
shallow_blocked=accessibility_indices(shallow_results);
assert(len(shallow_blocked)==0,str("expected shallow superformula to remain accessible, blocked=",shallow_blocked));
echo("stage=accessibility severity=info code=SHALLOW_ACCESSIBLE PASS blocked=0");

deep_modul=.8;
deep_teeth=24;
deep_samples=360;
deep_scale=_cg_superformula_scale(deep_modul,deep_teeth,5,1,1,.3,3.4,3.4,deep_samples);
deep_points=_cg_superformula_points(deep_scale,5,1,1,.3,3.4,3.4,deep_samples);
deep_candidate=_cg_reference_tooth_candidate(deep_modul*deep_teeth/2,deep_modul,deep_teeth,20);
deep_results=accessibility_results(deep_points,deep_modul,deep_teeth,deep_candidate);
deep_blocked=accessibility_indices(deep_results);
deep_accessible=[for(i=[0:deep_teeth-1]) if(!deep_results[i][0]) i];
deep_remote=[for(result=deep_results) if(result[1]>=0) result];
assert(len(deep_blocked)>0,str("expected deep U-shaped superformula to omit positions, blocked=",deep_blocked));
assert(len(deep_accessible)>0,str("expected neighbouring deep positions to remain accessible, blocked=",deep_blocked));
assert(len(deep_remote)>0,"expected at least one remote-body corridor obstruction");
echo(str("stage=accessibility severity=info code=DEEP_U_OMITTED PASS blocked=",deep_blocked));
echo(str("stage=accessibility severity=info code=DEEP_U_MIXED PASS accessible=",deep_accessible));
echo(str("stage=accessibility severity=info code=REMOTE_CORRIDOR_OBSTRUCTION PASS segment=",deep_remote[0][1]," point=",deep_remote[0][2]));

cube([0.01,0.01,0.01]);
