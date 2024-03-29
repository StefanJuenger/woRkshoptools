#' Build the sessions and exercises
#'
#' Builds the sessions and exercises and moves their files into the respective folders
#'
#' @param sessions_home Character; path to the sessions folder
#' @param exercises_home Character; path to the exercises folder
#' @param build_all Logical; defines whether all sessions and exercises are built
#' or only those that have been modified. Relies on a CSV file containing checksums that is
#' created the first time \code{build_sesssion()} is used; default is
#' \code{FALSE}
#'
#' @importFrom magrittr %>%
#'
#' @export

build_all <-
  function (
    sessions_home  = "./content/sessions/",
    exercises_home  = "./content/exercises/",
    build_all = FALSE
  ) {

    woRkshoptools::build_sessions(
      sessions_home = sessions_home,
      build_all = build_all
    )

    woRkshoptools::build_exercises(
      exercises_home = exercises_home,
      build_all = build_all
    )

  }
