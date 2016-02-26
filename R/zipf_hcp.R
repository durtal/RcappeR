#' Handicap a race using many races
#'
#' Assess and establish the performance of a winner by using the ratings from
#' many different, but similar, races, calls \link{zipf_race}.
#'
#' @details The \strong{past_races} dataframe is split according to
#' \strong{race_id}, so each split should be a small dataframe of a single race.
#' For each of these races they are entered into the \link{zipf_race} function
#' as \emph{race_2}, while the \strong{race} being handicapped is the \emph{race}
#' param.  The return is a dataframe with the \strong{race_id} and a rating for
#' the winner of \strong{race} based on the data from each race in
#' \strong{past_races}.
#'
#' @return Depending on param in \strong{results} it either returns a solitary
#' rating (the mean of all ratings returned), or a detailed list that can be
#' analysed further, the list contains
#' \itemize{
#'      \item \strong{n_races} number of races used
#'      \item \strong{mean_rtg} mean rating for the race
#'      \item \strong{summary} summary statistics of ratings returned
#'      \item \strong{ratings} ratings dataframe (with vars \emph{race_id} and
#'      \emph{zipf_rtg})
#' }
#'
#' @param race dataframe of race to handicap
#' @param past_races dataframe of past races used to handicap
#' @param race_id name of variable to split \strong{past_races} up by
#' so each split is one race
#' @param btn_var name of variable in \strong{race} with margins
#' between horses
#' @param rating name of variable (if applicable) in
#' \strong{past_races} that contains the ratings of those runners
#' @param results default \strong{detail}, determines the output, other
#' option is \strong{simple}, which will return the mean rating.
#' @param .progress plyr's progress bar (default = "none", options inc.
#' "text", "time", "tk" or "win")
#'
#' @export
zipf_hcp <- function(race, past_races, race_id, btn_var, rating = NULL,
                     results = "detail", .progress = "none") {

    # 1. Split past_races up according to race_id
    # 2. Apply zipf_race to each 'piece' which returns a rating
    wnrs_ratings <- plyr::ddply(past_races, race_id,
                          .fun = function(x, race, btn_var, rating) {
                              c(zipf_rtg = zipf_race(race = race,
                                       btn_var = btn_var,
                                       race_2 = x,
                                       rating = rating))
                          }, race = race,
                          btn_var = btn_var,
                          rating = rating,
                          .progress = .progress)

    # option to return a simple rating, rather than detailed list
    if(results == "simple") {
        return(mean(wnrs_ratings$zipf_rtg, na.rm = T))
    }

    # begin constructing detailed list
    rcapper_output <- list()

    # assign a custom class to the list to allow S3 methods (see below)
    class(rcapper_output) <- "rcapper_zipf_hcp"

    # add number of races used
    rcapper_output$n_races <- dim(wnrs_ratings)[1]

    # add mean rating
    rcapper_output$mean_rtg <- mean(wnrs_ratings$zipf_rtg, na.rm = T)

    # add summary statistics
    rcapper_output$summary <- summary(wnrs_ratings$zipf_rtg)

    # add dataframe with ratings and the race they were derived from
    rcapper_output$ratings <- wnrs_ratings

    # add summary of past races
    if(!is.null(rating)) {
        var <- rating
    } else {
        var <- btn_var
    }
    rcapper_output$past_races <- summary(past_races[[var]])

    return(rcapper_output)
}

#' @export
print.rcapper_zipf_hcp <- function(x, ...) {

    object <- x
    n_races <- object$n_races
    n_races <- paste("No. of races used:\n\t", n_races, "\n")

    mean_rating <- round(object$mean_rtg, 2)
    mean_rating <- paste("\nMean Rating:\n\t", mean_rating, "\n")

    cat("Handicapping race using zipf_hcp:\n\n")
    cat(n_races)
    cat("Past Races Summary:\n")
    print(object$past_races)
    cat(mean_rating)
    cat("Rating Summary:\n")
    print(object$summary)
}

#' @export
summary.rcapper_zipf_hcp <- function(object, ...) {

    n_races <- object$n_races
    n_races <- paste("No. of races used:\n\t", n_races, "\n")

    mean_rating <- round(object$mean_rtg, 2)
    mean_rating <- paste("\nMean Rating:\n\t", mean_rating, "\n")

    cat("Handicapping race using zipf_hcp:\n\n")
    cat(n_races)
    cat("Past Races Summary:\n")
    print(object$past_races)
    cat(mean_rating)
    cat("Rating Summary:\n")
    print(object$summary)
}

#' @export
plot.rcapper_zipf_hcp <- function(x, ...) {

    object <- x
    df <- object$ratings
    mean_rtg <- round(object$mean_rtg, 2)
    ggplot2::ggplot(data = df, ggplot2::aes(x = zipf_rtg)) +
        ggplot2::geom_histogram(ggplot2::aes(y = ..density..), binwidth = 1,
                                fill = "#D9220F", color = "#fcfcfc") +
        ggplot2::geom_density(fill = "#f8f8f8", alpha = 0.25) +
        ggplot2::geom_vline(xintercept = mean(df$zipf_rtg), lwd = 1) +
        ggplot2::labs(title = paste("Mean Zipf_Rtg:", round(object$mean_rtg, 2), " - (", object$n_races, " races)", sep="")) +
        theme_rcapper()
}
