/***
 * @function common_tanh_limits
 * @brief Verify finite saturation, odd symmetry and continuity of the shared tanh helper.
 * Source: [`common/tanh_limits.scad`](common/tanh_limits.scad)
 */
include <../../src/common/common_math.scad>
assert(_cg_tanh(0)==0);
for(x=[.000001,.1,1,5,400,1e6]) {
    positive=_cg_tanh(x);
    negative=_cg_tanh(-x);
    assert(positive==positive && negative==negative && positive>=0 && positive<=1);
    assert(abs(positive+negative)<1e-12);
    if(x<10) assert(abs(positive-(exp(2*x)-1)/(exp(2*x)+1))<1e-12);
    if(x>=400) assert(positive==1 && negative==-1);
}
echo("PASS: finite tanh saturation and odd symmetry");
cube(.01);
