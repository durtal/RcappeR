## ----echo=FALSE----------------------------------------------------------
library(RcappeR)

## ------------------------------------------------------------------------
data(gulfstream)

## ------------------------------------------------------------------------
gulfstream$date_race <- paste(gulfstream$date, gulfstream$race, sep = "_")
head(gulfstream$date_race)

# subset the race
race <- subset(gulfstream, date_race == "01/01/13_1")
gulfstream <- subset(gulfstream, date_race != "01/01/13_1")

## ------------------------------------------------------------------------
gulfstream <- subset(gulfstream, race_type == "mdn clm")

## ----warning=FALSE, message=FALSE----------------------------------------
# load dplyr
library(dplyr)
# prepare gulfstream dataset for use of zipf_init
gulfstream <- gulfstream %>%
    group_by(date_race) %>%
    mutate(btn_sec = btn_sec(fintime),
           scale = lbs_per_sec(dist = dist, surf = "dirt"),
           btn_lbs = scale * btn_sec,
           diff_wgts = diff_at_wgts(btn_lbs = btn_lbs, wgt_carried = wgt))
# call zipf_init
our_hcp <- zipf_init(races = gulfstream, group_by = "race_type", race_id = "date_race", btn_var = "diff_wgts")
# merge dataframe
gulfstream <- merge_zipf_init(zipf_list = our_hcp, races = gulfstream, btn_var = "diff_wgts")
# at the moment ratings for winners have a mean of 0, make this mean about 80 by simply adding 80 to zipf_rtg variable
gulfstream$zipf_rtg <- gulfstream$zipf_rtg + 80

## ----warning=FALSE, message=FALSE----------------------------------------
race <- race %>%
    mutate(btn_sec = btn_sec(fintime),
           scale = lbs_per_sec(dist = dist, surf = "dirt"),
           btn_lbs = scale * btn_sec,
           diff_wgts = diff_at_wgts(btn_lbs = btn_lbs, wgt_carried = wgt))

## ---- echo=FALSE, warning=FALSE, message=FALSE---------------------------
suppressPackageStartupMessages(library(ggplot2))

ggplot(subset(gulfstream, pos == 1), aes(x = zipf_rtg)) + 
    geom_histogram(aes(y = ..density..), fill = "#d9220f", binwidth = 2, color = "#fcfcfc") +
    geom_density() +
    theme_rcapper()

## ----echo=FALSE----------------------------------------------------------
start.time <- Sys.time()

our_hcp <- zipf_hcp(race = race, past_races = gulfstream, race_id = "date_race", btn_var = "diff_wgts", rating = "zipf_rtg")

end.time <- Sys.time()
time.taken <- end.time - start.time

## ----eval=FALSE----------------------------------------------------------
#  our_hcp <- zipf_hcp(race = race, past_races = gulfstream, race_id = "date_race", btn_var = "diff_wgts", rating = "zipf_rtg", .progress = "text")

## ------------------------------------------------------------------------
our_hcp

summary(our_hcp)

## ----fig.align='center'--------------------------------------------------
plot(our_hcp)

## ------------------------------------------------------------------------
possible_rtgs <- our_hcp$ratings
head(possible_rtgs)

