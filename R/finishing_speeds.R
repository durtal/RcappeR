#' Finishing Speed Percentage
#'
#' Calculates finishing speed percentages, another innovation by Simon Rowlands
#' of Timeform
#'
#' @details Parameters must be in the same units, so time params \strong{fin_time}
#' and \strong{sect_time} will be in seconds, while distance params \strong{dist}
#' and \strong{sect_dist} will both be in furlongs, or both be in feet, or both
#' be in miles, metres, etc.
#'
#' @source Two Simon Rowlands articles explaining Finshing
#' Speeds (and sectionals):
#' \href{https://www.timeform.com/Racing/Articles/An_introduction_to_Sectional_Timing_Part_1}{Sectional Timing Part 1}
#' \href{https://www.timeform.com/Racing/Articles/An_introduction_to_Sectional_Timing_Part_2}{Sectional Timing Part 2}
#'
#' @param \strong{fin_time} final time
#' @param \strong{dist} race distance
#' @param \strong{sect_time} closing sectional time
#' @param \strong{sect_dist} closing sectional distance
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # 5 furlong race run in 59 seconds
#' # closing 2 furlongs run in 23 seconds
#' fin_spd(fin_time = 59, dist = 5, sect_time = 23, sect_dist = 2)
#' ## 102.61
#' }
fin_spd <- function(fin_time, dist, sect_time, sect_dist) {

    # check parameters are numeric
    if(!is.numeric(c(fin_time, dist, sect_time, sect_dist))) {
        stop("Parameters must be numeric")
    }

    f_spd <- (fin_time * sect_dist * 100) / (dist * sect_time)
    f_spd <- round(f_spd, 2)

    return(f_spd)
}

#' Finishing Sectional Time
#'
#' Calculates the finishing sectional, reverse engineers a Finishing Speed
#' Percentage (see \link{fin_spd}) into a sectional time
#'
#' @details The two distance parameters, \strong{dist} and \strong{sect_dist},
#' must be in the same units, be that furlongs, miles, metres, feet, etc.  While
#' the \strong{fin_time} parameter should be in seconds, and the \strong{fin_spd}
#' should be a number around 100.
#'
#' @param \strong{fin_time} final time
#' @param \strong{dist} distance
#' @param \strong{fin_spd} finishin speed percentage
#' @param \strong{sect_dist} closing sectional distance
#'
#' @export
#'
#' @examples
#' \dontrun{
#' # 5 furlong race run in 59 seconds
#' # finishing speed of 102.61 over closing sectional of 2 furlongs
#' fin_sect(fin_time = 59, dist = 5, fin_spd = 102.61, sect_dist = 2)
#' ## 23
#' }
fin_sect <- function(fin_time, dist, fin_spd, sect_dist) {

    # check parameters are numeric
    if(!is.numeric(c(fin_time, dist, fin_spd, sect_dist))) {
        stop("Parameters must be numeric")
    }

    f_sect <- (fin_time * sect_dist * 100) / (fin_spd * dist)
    f_sect <- round(f_sect, 2)

    return(f_sect)
}
