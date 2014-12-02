#' Handicap a race using one race
#' 
#' Assess the performance of a winner (ie handicap) of a race using race
#' standardisation; which uses the performances of runners in a different, but 
#' similar, race for this assessment.  It is called by \link{zipf_hcp} and
#' \link{zipf_init}.
#' 
#' @details The method of race standardisation used was first explained by Simon
#' Rowlands and uses Zipfs Law.  The difference at the weights, from the race
#' to be handicapped, is applied to the second race, creating a vector of
#' possible ratings the victor could have achieved.  This is where Zipfs Law
#' plays its part, as depending on the finishing position, different weights
#' are assigned to each of the ratings in the vector, placing more significance
#' on horses towards the front of the field.
#' 
#' @source Article by Simon Rowlands explaining use of Zipf's Law:
#' 
#' \url{https://betting.betfair.com/horse-racing/bloggers/simon-rowlands/simon-rowlands-on-handicapping-060710.html}
#' 
#' @param \strong{race} dataframe of race to handicap
#' @param \strong{btn_var} name of variable which contains the margins between
#' the horses
#' @param \strong{race_2} dataframe of a race to be used to handicap
#' \strong{race}
#' @param \strong{rating} name of ratings variable (if applicable) in
#' \strong{race_2}
#' 
#' @export
zipf_race <- function(race, btn_var, race_2, rating = NULL) {
    
    # retrieve margins from both races, or ratings from race_2
    race_margins <- race[[btn_var]]
    if(!is.null(rating)) {
        race_2_margins <- race_2[[rating]]
    } else {
        race_2_margins <- -race_2[[btn_var]]
    }
    
    # remove any NA values - these should be horses who failed to complete the 
    # race they were in (either race or race_2)
    race_margins <- race_margins[!is.na(race_margins)]
    race_2_margins <- race_2_margins[!is.na(race_2_margins)]

    # makes sure lengths of both 'margins' vectors are equal
    if(length(race_margins) != length(race_2_margins)) {
        if(length(race_margins) > length(race_2_margins)) {
            race_margins <- race_margins[1:length(race_2_margins)]
        } else {
            race_2_margins <- race_2_margins[1:length(race_margins)]
        }
    }
    
    # calculate ratings based on each position
    rating <- race_2_margins + race_margins
    
    # calculate zipf factor
    zipf <- 1 / (1:length(rating))
    
    # multiply rating by zipf factor
    rating <- rating * zipf
    
    # sum all ratings
    total <- sum(rating, na.rm=T)
    
    # calculate winners rating
    winner <- round(total / sum(zipf), 2)
    
    return(winner)
}