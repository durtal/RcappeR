Saratoga data
=============

Various datasets or R workspaces for racing at Saratoga.

To clone just this branch (ignoring the RcappeR package source, and gh-pages) run the following:

`git clone -b saratoga --single-branch https://github.com/durtal/RcappeR.git RcappeR-saratoga`

### Data folder

file | contains | data.frames
-----|----------|---------------
`saratoga_2014.RData` | Data for 413 races at Saratoga in 2014. | `saratoga_2014_races`, `saratoga_2014_sects`

The two dataframes included in `saratoga_2014.RData` contain data about the races and data about the times horses recorded.  These dataframes require merging, after some small processing, they can be merged using the `date`, `race` and `pos` variables in each dataframe (but the `date` variable is in different formats, so it needs processing).  The sections below explain the variables in each of the dataframes.

##### `saratoga_2014_races`

This dataframe contains race conditions, as well as some data about the horses.

variable | what is it | format | examples
---------|------------|--------|------
`date` | race date | character | "July 18, 2014" ("%B %d, %Y")
`race` | race number | numeric ||
`race_type` | the type of race | character | "claiming", "allowance" <sup>1</sup>
`purse` | the race purse | numeric ||
`dist` | race distance in furlongs | numeric ||
`surf` | race surface | character | "dirt" or "turf"
`jockey` | horses' jockey | character | Surname, Firstname
`wgt` | the weight carried by horse in lbs | numeric | 122, 124, 118
`odds` | the odds the horse was sent off at | numeric ||
`pgm_id` | the number the horse was on the race card | numeric ||
`pos` | finishing position | numeric ||
`horse` | horses name (hopefully match across dataframes) | character ||

<sup>1</sup> the `race_type` variable will contain a number of stakes races, but these names will contain added detail, such as what grade the race was (such as Grade 1, which are races contested by the best horses).  Other race types, like Claiming races, put conditions on their runners, I'll try collect this data and add it over time.

##### `saratoga_2014_sects`

This dataframe contains sectional data.

variable | what is it | format | examples
---------|------------|--------|---------
`date` | race date | character | "07/18/2014" ("%m/%d/%Y")
`race` | race number | numeric ||
`track` | race track | character | "Saratoga"
`pos` | finishing position | numeric ||
`horse` | horses name | character ||
`c2f` | cumulative time recorded after 2f | numeric ||
`c4f` | cumulative time recorded after 4f | numeric ||
`c5f` | cumulative time recorded after 5f | numeric ||
`c6f` | cumulative time recorded after 6f | numeric ||
`c7f` | cumulative time recorded after 7f | numeric ||
`c8f` | cumulative time recorded after 8f | numeric ||
`c12f` | cumulative time recorded after 12f | numeric ||
`c16f` | cumulative time recorded after 16f | numeric ||
`fintime` | finishing time | numeric ||

The sectional data, found in variables starting with `c` is cumulative, and will contain a lot of NA values, for example if a race was over 6furlongs, then the horse won't have sectional data for `c7f`, `c8f` upwards.  Races over 6furlongs will also not contain sectional data for `c5f`, as data is typically recorded/available for 2f sectionals.
