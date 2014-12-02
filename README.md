RcappeR
========

### Overview
A collection of tools to aid the analysis and handicapping of Thoroughbred Horse Racing.  A number of tools help do grunt work, helping to clean and prepare data for the more complicated tools.  These cleaning tools include converting margins from lengths into seconds, converting character string times into numeric times, etc.  The more complicated tools help with handicapping the races, by using race standardisation.

### Vignettes
Five vignettes walking through data cleaning and preparation, as well as explaining (hopefully) the use of the more complicated functions `zipf_race`, `zipf_hcp` and `zipf_init`.

```R
browseVignettes(package = "RcappeR")
```

### To Do
1. A way to calculate the difference in class between different race types, ie:
    * how many lbs better/worse is an average winner of a maiden special weight compared to a maiden claiming winner
    * how many lbs better/worse is an average winner of a grade 1 compared to a listed winner
2. More complete lbs per second scale
    * all runners over same distance get same lbs per second scale, regardless of speed they ran.
3. More cleaning tools
    * clean a character vector of lengths into numeric, ie "3/4" into 0.75 or "1 3/4" into 1.75
4. Weight for Age dataset and function to calculate weight for age scale using the date the race
5. More
6. Even more