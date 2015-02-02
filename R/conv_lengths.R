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
#' second is a fraction (like "3/4"), it calculates the total
#' 
#' @param \strong{lengths} character vector of lengths
#' 
#' @export
#' @examples
#' \dontrun{
#' lengths <- c("0", "nse", "hd", "3/4", "1 1/2")
#' conv_len(lengths = lengths)
#' }
#' 
conv_len <- function(lengths) {
    
    lenlist <- list("0" = 0, "dh" = 0, "nse" = 0.02, "shd" = 0.05, "sh" = 0.05, 
                    "hd" = 0.1, "nk" = 0.2, "1/4" = 0.25, "1/2" = 0.5, "3/4" = 0.75)
    
    lens <- sapply(lengths, function(x) {
        
        x <- unlist(strsplit(x, "\\s+|-"))
        
        if(length(x) == 2) {
            frac <- x[2]
            frac <- as.numeric(unlist(strsplit(frac, "/")))
            frac <- frac[1] / frac[2]
            
            len <- as.numeric(x[1]) + frac
        }
        
        if(length(x) == 1) {
            if(grepl(pattern = "[[:alpha:]]+", x = x)) {
                x <- tolower(x)
                len <- lenlist[[x]]
                if(is.null(len)) {
                    len <- as.numeric(x)
                }
            } else {
                len <- lenlist[[x]]
                len <- as.numeric(len)
            }
        }
        
        if(length(x) == 0) {
            len <- as.numeric(0)
        }
        
        return(len)
    })
    
    lens <- as.vector(lens)

    return(lens)
}