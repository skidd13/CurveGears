/***
 * @module Logarithmic Spiral
 * @brief Experimental logarithmic-spiral gear geometry.
 *
 * The implemented sector form is `r=rmin*g^(2*pi*t)` with a radial return
 * between sectors. In local polar form this is `r(phi)=rmin exp(k phi)` with
 * `k=ln(growth_rate)`. Tooth count must be divisible by the sector count.
 * Reference: https://mathshistory.st-andrews.ac.uk/Curves/Equiangular/.
 */
include <../common/curve_gears_math.scad>

// Logarithmic spiral: r=rmin*g^(2*pi*t). Radial returns are broad transitions, not ordinary teeth.
/***
 * @function _cg_logspiral_radius(rmin, growth_rate, t)
 * @brief Evaluate the logarithmic-spiral radius at a sector parameter.
 * @param rmin {number > 0} Minimum radius in mm.
 * @param growth_rate {number > 1} Exponential growth base in the sector formula.
 * @param t {number} Normalised sector parameter.
 * @return {number} Radius in mm.
 */
function _cg_logspiral_radius(rmin,growth_rate,t) = rmin*pow(growth_rate,2*_cg_pi*t);
/***
 * @function _cg_logspiral_angle(sectors, sector, t)
 * @brief Convert a spiral sector parameter to a polar angle.
 * @param sectors {integer >= 1} Number of repeated sectors.
 * @param sector {integer >= 0} Sector index.
 * @param t {number} Normalised sector parameter.
 * @return {angle} Polar angle in degrees.
 */
function _cg_logspiral_angle(sectors,sector,t) = (sector+t)*360/sectors;
/***
 * @function _cg_logspiral_point(rmin, growth_rate, sectors, sector, t)
 * @brief Evaluate one Cartesian logarithmic-spiral point.
 * @param rmin {number > 0} Minimum radius in mm.
 * @param growth_rate {number > 1} Exponential growth base in the sector formula.
 * @param sectors {integer >= 1} Number of repeated sectors.
 * @param sector {integer >= 0} Sector index.
 * @param t {number} Normalised sector parameter.
 * @return {array} Cartesian point `[x, y]` in mm.
 */
function _cg_logspiral_point(rmin,growth_rate,sectors,sector,t) =
    let(r=_cg_logspiral_radius(rmin,growth_rate,t),phi=_cg_logspiral_angle(sectors,sector,t)) [r*cos(phi),r*sin(phi)];
/***
 * @function _cg_logspiral_tangent(rmin, growth_rate, sectors, sector, t)
 * @brief Evaluate the tangent vector of the logarithmic spiral.
 * @param rmin {number > 0} Minimum radius in mm.
 * @param growth_rate {number > 1} Exponential growth base in the sector formula.
 * @param sectors {integer >= 1} Number of repeated sectors.
 * @param sector {integer >= 0} Sector index.
 * @param t {number} Normalised sector parameter.
 * @return {array} Cartesian tangent vector.
 */
function _cg_logspiral_tangent(rmin,growth_rate,sectors,sector,t) =
    let(
        r=_cg_logspiral_radius(rmin,growth_rate,t),
        phi=_cg_logspiral_angle(sectors,sector,t),
        dr=sectors*ln(growth_rate)*r
    )
    [dr*cos(phi)-r*sin(phi),dr*sin(phi)+r*cos(phi)];
/***
 * @function _cg_logspiral_sector_points(rmin, growth_rate, sectors, sector, samples)
 * @brief Sample one logarithmic-spiral sector.
 * @param rmin {number > 0} Minimum radius in mm.
 * @param growth_rate {number > 1} Exponential growth base in the sector formula.
 * @param sectors {integer >= 1} Number of repeated sectors.
 * @param sector {integer >= 0} Sector index.
 * @param samples {integer >= 1, default 360} Number of samples.
 * @return {array} Sector points in Cartesian coordinates.
 */
function _cg_logspiral_sector_points(rmin,growth_rate,sectors,sector,samples=360) =
    [for(i=[0:samples-1]) _cg_logspiral_point(rmin,growth_rate,sectors,sector,i/(samples-1))];
/**
 * @function _cg_logspiral_pitch_points
 * @brief Build the closed pitch polyline, retaining each radial sector return.
 * @param rmin {number > 0} Minimum radius in mm.
 * @param growth_rate {number > 1} Exponential growth base in the sector formula.
 * @param sectors {integer >= 1} Number of repeated sectors.
 * @param samples {integer >= 1, default 360} Samples per sector.
 * @return {array of points} Closed logarithmic-spiral pitch polyline.
 */
function _cg_logspiral_pitch_points(rmin,growth_rate,sectors,samples=360) =
    [for(sector=[0:sectors-1],i=[0:samples-1])
        _cg_logspiral_point(rmin,growth_rate,sectors,sector,i/(samples-1))];
/***
 * @function _cg_logspiral_sector_length_for_rmin(rmin, growth_rate, sectors, samples)
 * @brief Calculate the sampled length of one spiral sector.
 * @param rmin {number > 0} Minimum radius in mm.
 * @param growth_rate {number > 1, default 1.17} Exponential growth base in the sector formula.
 * @param sectors {integer >= 1, default 1} Number of repeated sectors.
 * @param samples {integer >= 1, default 360} Number of samples.
 * @return {number} Sector length in mm.
 */
function _cg_logspiral_sector_length_for_rmin(rmin,growth_rate=1.17,sectors=1,samples=360) =
    let(points=_cg_logspiral_sector_points(rmin,growth_rate,sectors,0,samples),arc=_cg_open_arc_table(points)) arc[len(arc)-1][1];
/***
 * @function _cg_logspiral_rmin(modul, tooth_number, sectors, growth_rate)
 * @brief Calculate the minimum radius for the requested tooth pitch.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param sectors {integer >= 1, default 1} Number of repeated sectors.
 * @param growth_rate {number > 1, default 1.17} Exponential growth base in the sector formula.
 * @return {number} Minimum radius in mm.
 */
function _cg_logspiral_rmin(modul,tooth_number,sectors=1,growth_rate=1.17) =
    _cg_pi*modul*tooth_number/(sectors*_cg_logspiral_sector_length_for_rmin(1,growth_rate,sectors,360));
/***
 * @function _cg_logspiral_rmax(modul, tooth_number, sectors, growth_rate)
 * @brief Calculate the maximum radius for the requested tooth pitch.
 * @param modul {number > 0} Tooth module in mm.
 * @param tooth_number {integer >= 3} Number of teeth.
 * @param sectors {integer >= 1, default 1} Number of repeated sectors.
 * @param growth_rate {number > 1, default 1.17} Exponential growth base in the sector formula.
 * @return {number} Maximum radius in mm.
 */
function _cg_logspiral_rmax(modul,tooth_number,sectors=1,growth_rate=1.17) =
    _cg_logspiral_rmin(modul,tooth_number,sectors,growth_rate)*pow(growth_rate,2*_cg_pi);
