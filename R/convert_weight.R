#' Convert weights
#' 
#' Convert weight from different formats/measurements into lbs
#' 
#' @details Converts a numeric weight from kilograms ("kg") or stones ("st")
#' into lbs.  It also converts a character string of stones and lbs, ie. 9-7
#' representing 9 stone 7 lbs, into lbs using regex.
#' 
#' @param \strong{wgt} vector of weights to be converted, see examples.
#' @param \strong{regex} specific regular expression to split wgt by (if wgt is
#' a character string representing stones and lbs)
#' @param \strong{from} convert from "kg" to lbs, if wgt is numeric
#' @param \strong{round} round weight to nearest
#' 
#' @export
#' @examples
#' \dontrun{
#' wgts <- c("9-7", "9-0", "11-8")
#' conv_wgt(wgt = wgts)
#' 
#' wgts <- c(57, 58, 59)
#' conv_wgt(wgt = wgts, from = "kg")
#' }
conv_wgt <- function(wgt, regex = NULL, from = "st", round = 0) {
    
    if(is.numeric(wgt)) {
        if(from == "kg") {
            wgt <- wgt * 2.20462
        } else if(from == "st") {
            wgt <- wgt * 14
        }
    }
    
    if(is.character(wgt)) {
        if(!is.null(regex)) {
            regex <- regex
        } else {
            regex <- "-|\\s+"
        }
        
        wgt_split <- strsplit(wgt, split = regex)
        
        wgt <- sapply(wgt_split, function(x) {
            x <- as.numeric(x)
            x <- (x[1] * 14) + x[2]
        })
    }
    
    wgt <- round(wgt, round)
    return(wgt)
}