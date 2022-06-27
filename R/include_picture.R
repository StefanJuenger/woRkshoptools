#' Add a picture to your xaringan presentation
#'
#' A path normalizing wrapper around code{knitr::include_graphics()}
#'
#' @param picture_name Character; the name of the picture and its extension
#' @param picture_path Character; the path to the folder containing your pictures
#'
#' @importFrom magrittr %>%
#'
#' @export

include_picture <-
  function(
    picture_name,
    picture_path = "./content/img/"
  ) {
    paste0(picture_path, picture_name) %>%
      normalizePath() %>%
      knitr::include_graphics(error = FALSE)
  }
