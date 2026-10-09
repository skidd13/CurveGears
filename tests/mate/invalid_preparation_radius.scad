/***
 * @function mate_invalid_preparation_radius
 * @brief Reject non-positive physical radii before integration.
 * Source: [`mate/invalid_preparation_radius.scad`](mate/invalid_preparation_radius.scad)
 */
include <../../src/common/mate/preparation.scad>
echo(_cg_mate_preparation([10,0,10],[10,10,10],15,40));
