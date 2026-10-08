// @regression: manual
/**
 * @function cusp_envelope_mate_fixture
 * @brief Build the full swept-envelope reference mate once for collision phases.
 * Source: [`cusp/envelope_mate_fixture.scad`](cusp/envelope_mate_fixture.scad)
 */
include <../../src/cusp/mate.scad>
cusps=3;
profile=false;
mate_file="";
// Preserve nine decimal places in the state snapshot rather than the default
// six significant digits used by echo. All fixture values are finite and small.
function _cache_join(values,start=0,end=undef) =
    let(stop=is_undef(end) ? len(values) : end,count=stop-start,mid=start+floor(count/2))
    count<=0 ? "" : count==1 ? values[start] :
    str(_cache_join(values,start,mid),",",_cache_join(values,mid,stop));
// Number digits need no separators; JSON array values do.
function _cache_digits(values,i=0) = i>=len(values) ? "" : str(values[i],_cache_digits(values,i+1));
function _cache_scalar(value) =
    let(scaled=round(abs(value)*1e9),whole=floor(scaled/1e9),fraction=scaled-whole*1e9)
    str(value<0 ? "-" : "",whole,".",_cache_digits([for(i=[8:-1:0]) floor(fraction/pow(10,i))%10]));
function _cache_json(value) = is_list(value) ?
    str("[",_cache_join([for(item=value) _cache_json(item)]),"]") : _cache_scalar(value);
module _native_envelope_mate() {
    geometry=_cg_cusp_pair_motion_geometry(1.2,cusps==3 ? 36 : 12*cusps,20,undef,undef,720,cusps);
    if (profile)
        echo(str("CUSP_CACHE_JSON:",_cache_json([geometry[3],_cg_cusp_envelope_driver_outline(geometry[0]),geometry[4][2]])));
    _cg_cusp_envelope_mate_from_geometry(geometry,1.2,4,0,360,.5,.08,0);
}
if (mate_file!="")
    linear_extrude(height=4,center=true) import(mate_file);
else if (profile)
    projection(cut=true) _native_envelope_mate();
else
    _native_envelope_mate();
