#' lbs per second scale
#' 
#' @description uses a loess model to return a simple lbs per second scale, race
#' distance the only input.  As such, at the moment, only races between 5 
#' furlongs and 16 furlongs (2 miles) are covered, if a distance outside this 
#' range is entered the value returned will be NA.
#' 
#' @param \strong{dist} race distance
#' @param \strong{surf} race surface, default is "turf", other option "dirt", if
#' race is on fibresand, use the dirt option, if all-weather use turf
#' 
#' @return lbs per second scale
#' @export
lbs_per_sec <- function(dist, surf = "turf") {
    
    data(package = "RcappeR", scales, envir = environment())
    
    if(surf == "dirt") {
        scale <- predict(dirt_model, dist)
    } else {
        scale <- predict(turf_model, dist)
    }
    
    scale <- round(scale, 2)
    return(scale)
}