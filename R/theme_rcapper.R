#' Custom RcappeR ggplot2 theme
#'
#' A custom theme to help generate smart and identifiable plots
#'
#' @param base_size font size
#' @param base_family font family
#'
#' @export
theme_rcapper <- function(base_size = 10, base_family = "") {

    ggplot2::theme(
        line = ggplot2::element_line(colour = "#000000", size = 0.5, linetype = 1, lineend = "butt"),
        rect = ggplot2::element_rect(fill = "#FCFCFC", colour = "#FCFCFC", size = 0.5, linetype = 1),
        text = ggplot2::element_text(family = base_family, face = "plain", colour = "#000000", size = base_size),
        panel.background = ggplot2::element_rect(fill = "#FCFCFC"),
        plot.background = ggplot2::element_rect(fill = "#FCFCFC"),
        axis.ticks = ggplot2::element_line(colour = "#D8D8D8"),
        panel.grid.major = ggplot2::element_line(colour = "#D8D8D8"),
        panel.grid.minor = ggplot2::element_line(colour = "#F2F2F2")
    )
}
