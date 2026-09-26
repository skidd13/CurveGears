/***
 * @function superformula_mate_pipeline
 * @brief Deliberately exercise the shared splice validator with an interleaved pair.
 * Source: [`superformula/mate_pipeline.scad`](superformula/mate_pipeline.scad)
 */
include <../../src/tooth/placement.scad>

interleaved_a=[1,5,0,2];
interleaved_b=[3,7,1,4];
assert(_cg_splice_relation(interleaved_a,interleaved_b)=="PASS",
    "SPLICE_INTERVAL_INTERLEAVED");
