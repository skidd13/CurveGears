/***
 * @function mate_invalid_preparation_bracket
 * @brief Reject exterior bounds which do not enclose rolling closure.
 * Source: [`mate/invalid_preparation_bracket.scad`](mate/invalid_preparation_bracket.scad)
 */
include <../../src/common/mate/preparation.scad>
echo(_cg_mate_preparation([10,10,10],[10,10,10],30,40));
