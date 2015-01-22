#' Convert race times
#'
#' Convert race times into more workable format.  Most Horse Racing times are
#' run in minutes, so times this function works on will be recorded as
#' 'minutes:seconds:milliseconds' and 'seconds:milliseconds', which will be
#' converted into seconds:milliseconds.
#'
#' @details Takes a character string representing a race time, splits it up
#' according to a regular expression that looks for punctuation, a space or the
#' letter 'm' (full regex = "[[:punct:]]\\s?|\\s?[[:alpha:]]\\s?|\\s+"), so times like '1m39.99',
#' '1 39.99' or '1.39.99' are split into '1', '39' and '99', it then recombines
#' to return a numeric time in seconds.  If there are any race times that this
#' doesn't cater for then use the \strong{regex} param to enter a specific
#' regular expression to split the times by.
#'
#' @param \strong{times} times to be converted
#' @param \strong{regex} specific regular expression to split times by (if
#' function doesn't cater for the times entered)
#'
#' @export
#' @examples
#' \dontrun{
#' times <- c("1.39.99", "1m39.99", "1 39.99")
#' conv_times(times = times)
#' }
conv_times <- function(times, regex = NULL) {

    # if no regex is included use default
    if(is.null(regex)) {
        regex <- "[[:punct:]]\\s?|\\s?[[:alpha:]]+\\s?|\\s+"
    }
    
    # check if times are in character format
    if(is.factor(times)) {
        times <- as.character(times)
    }
    
    # split times according to regex
    split_times <- strsplit(times, regex)

    # for each splited time, call the mmss_ss function
    new_times <- sapply(split_times, mmss_ss)

    return(new_times)
}

#' convert time in mm.ss.00 to ss.00
#'
#' @param \strong{time} list of length 1 with character vector of length 2 or 3,
#' which represent minutes, seconds, and milliseconds
mmss_ss <- function(time) {

    # length of time
    len <- length(time)

    # if length is 3 then assumes it's in minutes:seconds:milliseconds
    if(len == 3) {
        # convert from character to numeric
        time <- as.numeric(time)
        # convert minutes to seconds (*60) and milliseconds to seconds (/100)
        time <- (time[1]*60) + (time[2]) + (time[3]/100)
    }
    # if length is 2 then assumes it's in seconds:milliseconds
    if(len == 2) {
        time <- as.numeric(time)
        time <- (time[1]) + (time[2]/100)
    }

    return(time)
}
