## ----echo=FALSE----------------------------------------------------------
library(RcappeR)

## ------------------------------------------------------------------------
data(gulfstream)

## ------------------------------------------------------------------------
str(gulfstream)

## ------------------------------------------------------------------------
gulfstream$date_race <- paste(gulfstream$date, gulfstream$race, sep = "_")

## ----warning=FALSE, message=FALSE----------------------------------------
library(dplyr)
new_gulfstream <- gulfstream %>%
    group_by(date_race) %>%
    mutate(btn_sec = btn_sec(fintime),
           scale = lbs_per_sec(dist = dist, surf = "dirt"),
           btn_lbs = scale * btn_sec,
           diff_wgts = diff_at_wgts(btn_lbs = btn_lbs, wgt_carried = wgt))

## ----echo=FALSE----------------------------------------------------------
start.time <- Sys.time()

our_hcp <- zipf_init(races = new_gulfstream, group_by = "race_type", race_id = "date_race", btn_var = "diff_wgts")

end.time <- Sys.time()
time.taken <- end.time - start.time

## ----eval=FALSE----------------------------------------------------------
#  our_hcp <- zipf_init(races = new_gulfstream, group_by = "race_type", race_id = "date_race", btn_var = "diff_wgts", .progress = "text")

## ------------------------------------------------------------------------
our_hcp

summary(our_hcp)

## ----fig.align='center'--------------------------------------------------
plot(our_hcp)

## ------------------------------------------------------------------------
initial_hcp <- merge_zipf_init(zipf_list = our_hcp, races = new_gulfstream, btn_var = "diff_wgts")
# Let's have a look at the first few rows of our skeleton handicap
initial_hcp %>%
    select(race_type, date_race, pos, fintime, btn_sec:zipf_rtg) %>%
    head(15)

