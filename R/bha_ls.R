#' BHA lengths per second conversion
#'
#' Return lengths per second scale employed by the BHA when they calculate
#' lengths beaten.  Use it convert the lengths back into seconds, see
#' \link{bhascale}
#'
#' @param \strong{conditions} abbreviated concatenation of race conditions, ie.
#' the type of race (flat or national hunt), and the official going.  To view
#' the dataset leave conditions blank.
#' 
#' @section Race Type abbreviations:
#' \itemize{
#'      \item \strong{f}-[going] flat
#'      \item \strong{nh}-[going] national hunt
#' }
#' @section Going abbreviations:
#' \itemize{
#'      \item [f, nh]-\strong{gq} good or quicker
#'      \item [f, nh]-\strong{ggs} good, good to soft
#'      \item [f, nh]-\strong{gsg} good to soft, good
#'      \item [f, nh]-\strong{gs} good to soft
#'      \item [f, nh]-\strong{gss} good to soft, soft
#'      \item [f, nh]-\strong{sgs} soft, good to soft
#'      \item [f, nh]-\strong{ss} soft or slower
#'      \item [f, nh]-\strong{aw} all-weather
#'      \item [f, nh]-\strong{fs} fibresand
#' }
#'
#' @export
#' @examples
#' \dontrun{
#' # conditions:
#' # race type: national hunt (nh) - going: good to soft, soft (gss)
#' bha_ls(conditions = "nh-gss")
#'
#' # unsure of conditions param, view the dataset
#' bha_ls()
#' }
bha_ls <- function(conditions = NULL) {

    # load bhascale dataset inside scope of function
    data(bhascale, envir = environment())

    # if conditions are left blank, return dataset
    if(is.null(conditions)) {
        return(bhascale)
    }

    # find correct scale
    scale <- subset(bhascale$scale, bhascale$conditions == conditions)

    # check if scale is returned, if not return default of 5
    if(length(scale) == 0) {
        scale <- 5
    }

    return(scale)
}
