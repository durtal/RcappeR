RcappeR 0.2.0
========

### Overview
A collection of tools to aid the analysis and handicapping of Thoroughbred Horse Racing.  A number of tools help with grunt work, cleaning and preparing data for the more complicated tools.  These cleaning tools include converting margins from lengths into seconds, converting character string times into numeric times, etc.  The more complicated tools help with handicapping the races, by using race standardisation.

There are help pages available, found [here](http://durtal.github.io/RcappeR).

### Installation
Within R
```R
devtools::install_github(repo = "durtal/RcappeR")

# to build the package vignettes, supply the build_vignettes param to install_github
devtools::install_github(repo = "durtal/RcappeR", build_vignettes = TRUE)
```

### Vignettes
Five vignettes walking through data cleaning and preparation, as well as explaining (hopefully) the use of the more complicated functions `zipf_race`, `zipf_hcp` and `zipf_init`, are included in the package.  To view them from within R they must be built on installation (see above), these vignettes can also be found in the help pages.

```R
browseVignettes(package = "RcappeR")
```

### To Do
1. A way to calculate the difference in class between different race types, ie:
    * how many lbs better/worse is an average winner of a maiden special weight compared to a maiden claiming winner
    * how many lbs better/worse is an average winner of a grade 1 compared to a listed winner
2. More complete lbs per second scale
    * all runners over same distance get same lbs per second scale, regardless of speed they ran.
3. Weight for Age dataset and function to calculate weight for age scale using the date the race
4. More
5. Even more

### Contribute

Please feel free to get in touch with suggestions, contributions, improvements, etc.
