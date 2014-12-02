#' Bootstrap helper function
#' 
#' To be used as a parameter inside \link{boot::boot}, which 'generates
#' bootstrap replicates of a statistic', the statistic in this case is the mean
#' zipf_rtg in the dataframe of ratings returned by \link{zipf_hcp}.
#' 
#' @details The dataframe to be used is inside a list, so either extract the
#' dataframe and give it its own name, or reference it using '$ratings'.
#' 
#' @param \strong{data} dataframe
#' @param \strong{index} indexes
#' 
#' @export
#' 
#' @examples
#' \dontrun{
#' library(boot)
#' # assume we have called zipf_hcp and the returned list is called "zipf"
#' # to use the mean_rating within boot::boot function:
#' boot(data = zipf$ratings, statistic = mean_rating, R = 1000)
#' }
mean_rating <- function(data, index) {
    
    with(data[index, ], mean(zipf_rtg, na.rm = TRUE))
    
}