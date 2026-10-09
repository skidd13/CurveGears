/***
 * @function mate_invalid_preparation_lengths
 * @brief Reject mismatched boundary and midpoint radius arrays.
 * Source: [`mate/invalid_preparation_lengths.scad`](mate/invalid_preparation_lengths.scad)
 */
include <../../src/common/mate/preparation.scad>
echo(_cg_mate_preparation([10,10,10],[10,10,10,10],15,40));
