## ---- echo=FALSE---------------------------------------------------------
library(RcappeR)

## ------------------------------------------------------------------------
data(gulfstream)
str(gulfstream)

## ------------------------------------------------------------------------
gulfstream$date_race <- paste(gulfstream$date, gulfstream$race, sep = "_")

## ----warning=FALSE, message=FALSE----------------------------------------
library(dplyr)
gulfstream <- gulfstream %>%
    group_by(date_race) %>%
    mutate(btn_sec = btn_sec(fintime),
           scale = lbs_per_sec(dist = dist, surf = "dirt"),
           btn_lbs = scale * btn_sec,
           diff_wgts = diff_at_wgts(btn_lbs = btn_lbs, wgt_carried = wgt))

## ----eval=FALSE----------------------------------------------------------
#  one_race <- one_race %>%
#      mutate(btn_sec = btn_sec(fintime),
#             scale = lbs_per_sec(dist = dist, surf = "dirt"),
#             btn_lbs = scale * btn_sec,
#             diff_wgts = diff_at_wgts(btn_lbs = btn_lbs, wgt_carried = wgt))

## ----eval=FALSE----------------------------------------------------------
#  btn_sec(times = fintimes)

## ------------------------------------------------------------------------
gulfstream <- gulfstream %>%
    group_by(date_race) %>%
    mutate(btn_sec = btn_sec(times = fintime),   ## behind winner at the finish
           bhd_ldr_sect = btn_sec(times = sect_4f))  ## behind leader at the 4 furlong sectional

## ------------------------------------------------------------------------
# calculate the closing sectional time
gulfstream$sect_time <- gulfstream$fintime - gulfstream$sect_4f
# using the new sect_time variable and other data in the dataset
gulfstream$fin_spd <- fin_spd(fin_time = gulfstream$fintime, 
                              dist = gulfstream$dist, 
                              sect_time = gulfstream$sect_time, 
                              sect_dist = gulfstream$dist - 4)

## ---- fig.align='center', echo=FALSE, warning=FALSE----------------------
suppressPackageStartupMessages(library(ggplot2))
ggplot(gulfstream, aes(x = sect_4f, y = fin_spd)) +
    geom_point(alpha=.5, color = "#D8D8D8") +
    geom_point(data = subset(gulfstream, pos == 1), aes(x = sect_4f, y = fin_spd), col="#D9220F", alpha = .65) +
    theme_rcapper() +
    facet_wrap(~dist)

## ---- warning=FALSE, message=FALSE---------------------------------------
gulfstream %>%
    filter(dist == 6) %>%
    group_by(pos) %>%
    summarise(par_fs = mean(fin_spd, na.rm = TRUE),
              sd_fs = sd(fin_spd, na.rm = TRUE))

## ------------------------------------------------------------------------
gulfstream %>%
    group_by(date_race) %>%
    mutate(pct_btn = rnrs_btn(pos = pos)) %>%
    ungroup() %>%
    group_by(gate) %>%
    summarise(pct_btn = mean(pct_btn, na.rm = TRUE))

