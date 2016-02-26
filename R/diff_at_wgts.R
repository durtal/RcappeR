#' Difference at the weights
#'
#' Calculates the difference at the weights, taking into account the number of
#' lbs behind the winner the horse was, and the weight the horse carried
#' compared to the winner.
#'
#' @param btn_lbs beaten lbs between runners
#' @param wgt_carried weight carried (in lbs)
#'
#' @export
diff_at_wgts <- function(btn_lbs, wgt_carried) {

    wgt_diff <- wgt_carried[1] - wgt_carried

    wgt_diff <- wgt_diff + btn_lbs

    return(wgt_diff)
}
