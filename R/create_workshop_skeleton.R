#' Create workshop skeleton
#'
#' Takes care of creating all folder and subfolder for a workshop
#'
#' @param where Character; path to the workshop folder
#' @param style Character; currently only \code{gesis} is supported
#'
#' @importFrom magrittr %>%
#'
#' @export

create_workshop_skeleton <-
  function(
    where = ".",
    style = "gesis"
    ) {

    skeleton_directories <-
      system.file("extdata/gesis_skeleton", package = "woRkshoptools") %>%
      list.dirs(recursive = FALSE)

    for (i in skeleton_directories) {
      file.copy(i, where, recursive = TRUE)
    }
  }
