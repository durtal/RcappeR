Saratoga data
=============

Various datasets or R workspaces for racing at Saratoga.

To clone just this branch (ignoring the RcappeR package source, and gh-pages) run the following:

`git clone -b saratoga --single-branch https://github.com/durtal/RcappeR.git RcappeR-saratoga`

### Data folder

file | contains | vars | dim
-----|----------|------|-----
`saratoga_2014.RData` | Sectional data for 413 races at Saratoga in 2014. | `date`, `race`, `track`, `pos`, `horse`, `c2f`, `c4f`, `c5f`, `c6f`, `c7f`, `c8f`, `c12f`, `c16f`, `fintime` | 3247, 14

variables should be self explanatory, however those which begin with `c` (such as `c2f`) are the cumulative sectional times of runners, so `c2f` is the time a runner takes to cover the first 2 furlongs, `c4f` the first 4 furlongs.  It follows that `c4f - c2f` is the time taken for a runner to travel from the 2 furlong pole to the 4 furlong pole.

I still need to collect data about the 413 races at Saratoga, things like the type of race (Maiden, Stakes, Claiming, etc), the purse, track conditions, weight horses carried, etc.  This should be added over time.
