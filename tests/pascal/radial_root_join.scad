/***
 * @function pascal_radial_root_join
 * @brief Verify the previously failing radial mate junction and retain rejection of unsupported splice overlaps.
 * Source: [`pascal/radial_root_join.scad`](pascal/radial_root_join.scad)
 */
include <../../src/pascal/mate.scad>

m=.8;z=34;e=.68;n=120;
shape=_cg_pascal_shape(m,z,e,n);
scale=shape[1](0)/(1+e);
mx=scale*(1+e);
assert(abs(shape[2]-(mx+.01))<1e-10 && abs(shape[3]-4*mx)<1e-10,"Pascal distance bracket changed");
D=curve_gear_pascal_centre_distance(m,z,e,n);
prepared=_cg_mate_preparation(_cg_sample_polar_radii(shape[1],n),_cg_sample_polar_radii(shape[1],n,true),shape[2],shape[3]);
pitch=prepared[2];
state=_cg_tooth_geometry_state(pitch,m,z,20,0,true,undef,undef,false,true);
assert(_cg_tooth_geometry_state_valid(state),"corrected radial mate is not valid");
assert(len([for(p=state[5]) if(p[0]=="placed") p])==34,"radial correction lost a tooth");
assert(len(_cg_polygon_intersections(state[7]))==0,"exposed radial outline still intersects");
raw_failures=_cg_splice_failures(state[5],state[2]);
assert(len(raw_failures)==1 && raw_failures[0][0]=="SPLICE_INTERVAL_INTERLEAVED","raw interval diagnostic changed");
assert(len(_cg_splice_failures(state[5],state[2],undef,state[12]))==0,"proved radial junction was not accepted");
assert(len(_cg_join_adjacent_root_boundaries(state[12][16],state[12][17]))==3,"radial junction is not unique");

function changed_tooth_index(placement,index) = [for(k=[0:len(placement)-1]) k==2 ? index : placement[k]];
non_neighbours=[for(i=[0:len(state[5])-1]) i==17 ? changed_tooth_index(state[5][i],100) : state[5][i]];
assert(len(_cg_splice_failures(non_neighbours,state[2],undef,state[12]))>0,"non-neighbouring roots escaped rejection");
shifted=[for(i=[0:len(state[12])-1]) i==17 ? [for(p=state[12][i]) [p[0]+1000,p[1]]] : state[12][i]];
assert(len(_cg_splice_failures(state[5],state[2],undef,shifted))>0,"unsupported root junction escaped rejection");

function synthetic_placement(index,target,start_s,end_s) =
    ["placed","PASS",index,target,[],[],[],[],[[0,0],0,0,0,0,start_s],[[0,0],0,0,0,0,end_s],[],[]];
nested=[synthetic_placement(0,2,1,6),synthetic_placement(1,4,3,4)];
assert(_cg_splice_failures(nested,10,undef,[state[12][16],state[12][17]])[0][0]=="SPLICE_INTERVAL_OVERLAP",
    "nested splice intervals escaped rejection");
a=[for(i=[0:11]) i<6 ? [-2,-2-i] : i%2==0 ? [1,-1] : [1,1]];
b=[for(i=[0:11]) i<6 ? i%2==0 ? [0,0] : [2,0] : [3,3+i]];
assert(len(_cg_join_adjacent_root_boundaries(a,b))==0,"ambiguous root crossings escaped rejection");

linear_extrude(4) difference() {
    polygon(state[7]);
    circle(d=4.8,$fn=48);
}
