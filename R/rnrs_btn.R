#' Runners Beaten
#' 
#' Calculates the percentage of runners beaten.
#' 
#' @details It is best used with the power of the \link{dplyr} package, to
#' calculate the percentage of runners beaten across numerous races
#' in the same dataframe (see examples)
#' 
#' @param \strong{pos} finishing position
#' 
#' @export
#' 
#' @examples
#' \dontrun{
#' # dataframe consisting of position (pos) variable and starting gate (gate)
#' # find percentage of runners beaten per starting gate
#' races %>%
#'      mutate(pct_btn = rnrs_btn(pos)) %>%
#'      group_by(gate) %>%
#'      summarise(pct_btn = mean(pct_btn))
#' }
rnrs_btn <- function(pos) {
    
    # check if vector is numeric
    if(!is.numeric(pos)) {
        stop("\"pos\" variable is not numeric")
    }
    
    rivals_btn <- max(pos) - pos
    
    pct_btn <- rivals_btn / (max(pos) - 1)
    
    pct_btn <- round(pct_btn, 2)
    
    return(pct_btn)
}