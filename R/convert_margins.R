#' Convert lengths beaten into seconds
#'
#' Converts margins, between the winner of a race and the horses behind, from
#' lengths into seconds.
#'
#' @details As default, the lengths per second scale used is the US convention
#' of 5 lengths per second.  However, if the race was run under the jurisdiction
#' of the BHA, then entering an abbrevation of the races conditions will apply
#' the lengths per second scale employed by the BHA.  See also \link{bha_ls} and
#' \link{bhascale}.
#'
#' @param btn_l beaten lengths
#' @param cum_l default \code{TRUE}, indicates whether \strong{btn_l}
#' is cumulative or not
#' @param win_time winners time, optional param, entering will mean
#' the function returns an individual race time for each runner
#' @param conditions default \code{NULL}, enter race conditions if BHA
#' lengths per second scale is desired, or enter a scale manually
#'
#' @return \strong{margins}, in seconds, if \strong{win_time} is entered then
#' individual times per runner are returned
#'
#' @export
#'
#' @examples
#' \dontrun{
#' btn_l <- c(0, 0.2, 0.5, 1, 1.5)
#' conv_margins(btn_l = btn_l)
#' conv_margins(btn_l = btn_l, cum_l = FALSE)
#' conv_margins(btn_l = btn_l, win_time = 59)
#' conv_margins(btn_l = btn_l, win_time = 59, conditions = "f-ggf")
#' }
conv_margins <- function(btn_l, cum_l = TRUE, win_time = NULL,
                         conditions = NULL) {

    # check btn_l is numeric
    if(!is.numeric(btn_l)) {
        stop("\"btn_l\" is not numeric")
    }

    # check if conditions are entered, if it's for BHA scale, a manual scale
    if(!is.null(conditions)) {
        if(is.character(conditions)) {
            scale <- bha_ls(conditions = conditions)
        } else {
            if(is.numeric(conditions)) {
                scale <- conditions
            }
        }
    } else {
        scale <- 5.0
    }

    # convert lengths to cumulative if cum_l is flagged as false
    if(!cum_l) {
        btn_l <- cumsum(btn_l)
    }

    # calculate beaten seconds
    btnsec <- round(btn_l / scale, 2)

    # if win_time is entered return individual times
    if(!is.null(win_time)) {
        if(!is.numeric(win_time)) {
            stop("\"win_time\" is not numeric")
        }
        ind_times <- round(win_time + btnsec, 2)
        return(ind_times)
    } else {
        return(btnsec)
    }
}


#' Beaten seconds
#'
#' Calculates the margins (in seconds) between the winner of a race and horses
#' who finished behind
#'
#' @param \strong{times} time recorded by each runner
#'
#' @export
#'
btn_sec <- function(times) {

    if(!is.numeric(times)) {
        stop("\"times\" is not numeric")
    }

    # winners time is assumed to be the lowest
    btn_sec <- times - min(times, na.rm = TRUE)

    return(btn_sec)
}
