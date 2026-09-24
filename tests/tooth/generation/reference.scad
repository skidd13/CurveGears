// Compact mathematical oracle derived from the pinned reference source:
// https://github.com/chrisspen/gears/tree/15793cf3377773e417f52dc91ea7f28a2d25dde0
// This project does not vendor the upstream gears.scad repository.
rad=57.29578; clearance=0.05;
function grad(a)=a*rad;
function radian(a)=a/rad;
function polar_to_cartesian(p)=[p[0]*cos(p[1]),p[0]*sin(p[1])];
function ev(r,rho)=[r/cos(rho),grad(tan(rho)-radian(rho))];

function reference_tooth_points(modul,tooth_number,pressure_angle=20,backlash=undef) =
    let(
        d=modul*tooth_number,
        r=d/2,
        rb=d*cos(pressure_angle)/2,
        ra=((modul < 1) ? d+modul*2.2 : d+modul*2)/2,
        rho_ra=acos(rb/ra),
        rho_r=acos(rb/r),
        phi_r=grad(tan(rho_r)-radian(rho_r)),
        step=rho_ra/16,
        half_width=is_undef(backlash)
            ? 180*(1-clearance)/tooth_number
            : 180/tooth_number-360*backlash/(3.141592653589793*modul*tooth_number),
        tooth_width=half_width+2*phi_r
    )
    concat(
        [[0,0]],
        [for(rho=[0:step:rho_ra]) polar_to_cartesian(ev(rb,rho))],
        [polar_to_cartesian(ev(rb,rho_ra))],
        [for(rho=[rho_ra:-step:0])
            polar_to_cartesian([ev(rb,rho)[0],tooth_width-ev(rb,rho)[1]])]
    );

// This is a deliberately small, renderable reference tooth.  It preserves
// the pinned involute equations while leaving the production candidate and
// its placement/validation code under test.
module reference_oracle_tooth(modul,tooth_number,width,pressure_angle=20,backlash=undef) {
    assert(modul > 0 && tooth_number >= 3 && width > 0,
        "reference_oracle_tooth: invalid dimensions");
    linear_extrude(height=width,convexity=4)
        polygon(reference_tooth_points(modul,tooth_number,pressure_angle,backlash));
}
