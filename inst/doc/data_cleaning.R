## ----, echo=FALSE--------------------------------------------------------
library(RcappeR)

## ------------------------------------------------------------------------
data(example_race)
(df <- example_race)

## ------------------------------------------------------------------------
df$race_id <- paste(df$date, df$time, sep = "_")
unique(df$race_id)

## ------------------------------------------------------------------------
df$new_time <- conv_times(df$wintime)
## the new times look like
df$new_time

## ----echo=FALSE----------------------------------------------------------
df$btn_l

## ------------------------------------------------------------------------
conv_margins(btn_l = df$btn_l)

## ------------------------------------------------------------------------
conv_margins(btn_l = df$btn_l, win_time = df$new_time)

## ------------------------------------------------------------------------
## our races are flat races, and going is good or quicker, so conditions = "f-gq"
conv_margins(btn_l = df$btn_l, win_time = df$new_time, conditions = "f-gq")

## ----warning=FALSE, message=FALSE----------------------------------------
library(dplyr)
df <- df %>%
    group_by(race_id) %>%
    mutate(ind_times = conv_margins(btn_l = btn_l, 
                                      cum_l = FALSE, 
                                      win_time = new_time))

select(df, race_id, pos, wintime, new_time, btn_l, ind_times)

## ----eval=FALSE----------------------------------------------------------
#  df %>%
#      group_by(race_id) %>%
#      mutate(btn_sec = btn_sec(times = ind_times))

## ------------------------------------------------------------------------
example_race %>%
    group_by(date, time) %>%
    mutate(race_id = paste(date, time, sep = "_"),
           new_time = conv_times(times = wintime),
           new_margins = conv_margins(btn_l = btn_l,
                                      cum_l = FALSE,
                                      win_time = new_time,
                                      conditions = "f-gq")) %>%
    select(race_id, pos, horse, wintime, new_time, btn_l, new_margins)    

