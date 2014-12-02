#' RcappeR
#' 
#' Tools to aid the analysis and handicapping of Thoroughbred Horse Racing
#' 
#' A collection of tools to aid the analysis and handicapping of Thoroughbred 
#' Horse Racing.  The primary tool \link{zipf_init} initialises a handicap 
#' using race standardisation, which establishes the merits of a horses' 
#' performance in a race by comparing it with different, but similar races.  
#' Other tools, \link{zipf_hcp} and \link{zipf_race} help maintain a handicap.
#' The package also includes various tools for cleaning and preparing data for
#' analysis, and the use of the primary functions.
#' 
#' @author Thomas Heslop
#' @name RcappeR
#' @aliases RcappeR-package
#' @docType package
NULL

#' BHA lengths per second scale
#' 
#' Dataset containing the lengths per second scale employed by the BHA
#' 
#' @section Variables:
#' \itemize{
#'      \item \strong{race_type} type of race, flat (f) or national hunt (nh)
#'      \item \strong{going} official going
#'      \item \strong{scale} lengths per second scale
#'      \item \strong{conditions} abbreviated concatenation of \strong{race_type}
#'      and \strong{going}
#' }
#' 
#' @docType data
#' @keywords dataset
#' @name bhascale
#' @source \href{http://www.britishhorseracing.com/wp-content/uploads/2014/04/Lengths-Per-Second-Scale-Tables.pdf}{BHA Scale PDF}
NULL

#' Example Dataset
#' 
#' Dataset of two fictional races, to highlight use of a few functions
#' 
#' @section Variables:
#' \itemize{
#'      \item \strong{date} race date
#'      \item \strong{time} race start time
#'      \item \strong{pos} finishing position
#'      \item \strong{horse} horse name
#'      \item \strong{wintime} winners final time
#'      \item \strong{going} official going
#'      \item \strong{code} race code, flat or national hunt race
#'      \item \strong{btn_l} beaten lengths
#'      \item \strong{dist} race distance
#' }
#' 
#' @docType data
#' @keywords dataset
#' @name example_race
NULL

#' Gulfstream Park Dataset
#' 
#' Dataset containing actual races from Gulfstream Park run in 2013 over 6 and
#' 8 furlongs on the dirt.
#' 
#' @format
#' 2863 rows
#' 17 columns
#' @section Variables:
#' \itemize{
#'      \item \strong{date} race date
#'      \item \strong{race} race number
#'      \item \strong{race_type} type of race, or class of race ("clm", 
#'      "mdn clm")
#'      \item \strong{dist} race distance (furlongs)
#'      \item \strong{surf} surface (all dirt in this case)
#'      \item \strong{value} race value (or purse)
#'      \item \strong{going} official going
#'      \item \strong{trainer} horse trainer
#'      \item \strong{jockey} horse jockey
#'      \item \strong{j_clm} jockey claim (any weight, in lbs, taken off horse)
#'      \item \strong{age} horse's age
#'      \item \strong{wgt} weight carried
#'      \item \strong{gate} starting gate
#'      \item \strong{pos} finishing position
#'      \item \strong{horse} horse
#'      \item \strong{fintime} final time
#'      \item \strong{sect_4f} time recorded over first 4 furlongs
#' }
#' 
#' @docType data
#' @keywords dataset
#' @name gulfstream
NULL