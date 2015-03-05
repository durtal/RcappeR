#' Convert lengths
#'
#' Convert lengths from character vector, containing values like "3/4" and "hd"
#' into a numeric vector.
#'
#' @details This function makes some assumptions, so may need tweaking over time.
#' For each string in a vector it is first split up by the spaces in it, so "1 3/4"
#' is split into "1" "3/4", if there are no spaces then it assesses the single
#' number/letters against a list of common length margins.  If the split vector
#' has length 2 then it assumes the first element is a whole number, and the
#' second is a fraction (like "3/4"), it calculates the total margin.  There is no
#' doubt for edge cases that this function doesn't cover which will cause errors,
#' the function was harder to write than initially thought, and will likely need
#' improvements as edge cases are encountered
#'
#' @param \strong{lengths} character vector of lengths
#'
#' @export
#' @examples
#' \dontrun{
#' lengths <- c("0", "nse", "hd", "3/4", "1 1/2")
#' conv_len(lengths = lengths)
#' }
conv_len <- function(lengths) {

    lens <- sapply(lengths, helper_len)
    lens <- as.vector(lens)

    return(lens)
}

#' Helper function for conv_len
#'
#' @param length character string representing a margin in lengths
helper_len <- function(length) {

    lenlist <- list("0" = 0, "dh" = 0, "nse" = 0.02, "shd" = 0.05, "sh" = 0.05,
                    "hd" = 0.1, "nk" = 0.2, "1/4" = 0.25, "1/2" = 0.5, "3/4" = 0.75)

    x <- unlist(strsplit(length, "\\s+|-"))

    if(length(x) == 2) {
        frac <- x[2]
        frac <- as.numeric(unlist(strsplit(frac, "/")))
        frac <- frac[1] / frac[2]

        len <- as.numeric(x[1]) + frac
    } else if(length(x) == 1) {
        if(grepl("[[:alpha:]]+", x)) {
            x <- tolower(x)
            len <- lenlist[[x]]
        } else {
            if(grepl("/", x)) {
                frac <- as.numeric(unlist(strsplit(x, "/")))
                len <- frac[1] / frac[2]
            } else {
                len <- as.numeric(x)
            }
        }
    }
    return(len)
}
