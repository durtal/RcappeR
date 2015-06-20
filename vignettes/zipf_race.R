## ---- echo=FALSE---------------------------------------------------------
library(RcappeR)

## ----message=FALSE, warning=FALSE----------------------------------------
# load dplyr and example_race dataset
library(dplyr)
data(example_race)

clean_df <- example_race %>%
    mutate(race_id = paste(date, time, sep = "_"),
           newtime = conv_times(times = wintime),
           fintime = conv_margins(btn_l = btn_l, win_time = newtime),
           btn_sec = fintime - newtime)

## ------------------------------------------------------------------------
race_one <- filter(clean_df, race_id == "01/01/01_2:20")
race_two <- filter(clean_df, race_id != "01/01/01_2:20")

## ------------------------------------------------------------------------
race_two <- race_two %>%
    mutate(scale = lbs_per_sec(dist, surf = "turf"),    # calculate lbs per second scale
           btn_lbs = scale * btn_sec,                   # calculate beaten lbs
           rating = 70 - btn_lbs)                       # calculate arbitrary ratings, winner gets 70

## ------------------------------------------------------------------------
race_one <- race_one %>%
    mutate(scale = lbs_per_sec(dist, surf = "turf"),
           btn_lbs = scale * btn_sec)

## ------------------------------------------------------------------------
output <- zipf_race(race = race_one, btn_var = "btn_lbs", race_2 = race_two, rating = "rating")

## ------------------------------------------------------------------------
# Step One
race_one_margins <- race_one[["btn_lbs"]]
race_two_ratings <- race_two[["rating"]]

# Step Two
race_one_margins <- race_one_margins[!is.na(race_one_margins)]
race_two_ratings <- race_two_ratings[!is.na(race_two_ratings)]

# Step Three
if(length(race_one_margins) != length(race_two_ratings)) {
    if(length(race_one_margins) > length(race_two_ratings)) {
        race_one_margins <- race_one_margins[1:length(race_two_ratings)]
    } else {
        race_two_ratings <- race_two_ratings[1:length(race_one_margins)]
    }
}

## ------------------------------------------------------------------------
race_one_margins
race_two_ratings

## ------------------------------------------------------------------------
(ratings <- race_two_ratings + race_one_margins)

## ------------------------------------------------------------------------
(zipf <- 1 / (1:length(ratings)))

## ------------------------------------------------------------------------
(ratings <- ratings * zipf)

## ------------------------------------------------------------------------
(total <- sum(ratings, na.rm = TRUE))

## ------------------------------------------------------------------------
(winning_rating <- round(total / sum(zipf), 2))

