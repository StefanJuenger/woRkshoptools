#' Build the exercises
#'
#' Builds the exercises and moves their files into the respective folders
#'
#' @param exercises_home Character; path to the exercises folder
#' @param build_all Logical; defines whether all exercises are built
#' or only those that have been modified. Relies on a CSV file containing checksums that is
#' created the first time \code{build_sesssion()} was used; default is \code{FALSE}
#'
#' @importFrom magrittr %>%
#'
#' @export

build_exercises <-
  function (
    exercises_home  = "./content/exercises/",
    build_all = FALSE
  ) {

    # Load 'index' of files if it exists
    if(file.exists(glue::glue(exercises_home, "exercises_list.csv"))) {
      exercises_list_previous <-
        readr::read_csv(
          glue::glue(exercises_home, "exercises_list.csv")
        ) %>%
        dplyr::mutate(
          previous = current
        ) %>%
        dplyr::select(-current)
    }

    # Create list of current files in folder
    exercises_list_current <-
      tibble::tibble(
        excercise_name =
          list.files(exercises_home, recursive = FALSE) %>%
          .[stringr::str_detect(., "Rmd")]
      ) %>%
      dplyr::mutate(
        current = tools::md5sum(paste0(exercises_home, excercise_name))
      )

    # join lists and update existing one if it exists; otherwise create it
    if (file.exists(glue::glue(exercises_home, "exercises_list.csv"))) {
      exercises_list <-
        dplyr::full_join(
          exercises_list_previous,
          exercises_list_current
        ) %>%
        dplyr::mutate(
          previous = ifelse(is.na(previous), "...", previous)
        ) %>%
        dplyr::filter(!is.na(current))

      readr::write_csv(
        exercises_list,
        glue::glue(exercises_home, "exercises_list.csv")
      )
    } else {
      exercises_list <-
        exercises_list_current %>%
        dplyr::mutate(previous = "...") %>%
        dplyr::select(
          excercise_name, previous, current
        )

      readr::write_csv(
        exercises_list_current,
        glue::glue(exercises_home, "exercises_list.csv")
      )
    }

    # build files that have changed
    for (i in 1:nrow(exercises_list)) {

      if (isFALSE(exercises_list$previous[i] == exercises_list$current[i]) | isTRUE(build_all)) {

        # exercises
        rmarkdown::render(
          glue::glue("./content/exercises/", exercises_list$excercise_name[i]),
          output_format =
            unilur::tutorial_html(suffix = ""),
          knit_root_dir = getwd()
        )

        html_file <-
          list.files("./content/exercises/") %>%
          .[stringr::str_detect(., "html")]

        file.copy(
          glue::glue("./content/exercises/", html_file),
          glue::glue("./exercises/", html_file),
          overwrite = TRUE
        )

        unlink(glue::glue("./content/exercises/", html_file))

        # solutions
        rmarkdown::render(
          glue::glue("./content/exercises/", exercises_list$excercise_name[i]),
          output_format =
            unilur::tutorial_html_solution(suffix = ""),
          knit_root_dir = getwd()
        )

        html_file <-
          list.files("./content/exercises/") %>%
          .[stringr::str_detect(., "html")]

        file.copy(
          glue::glue("./content/exercises/", html_file),
          glue::glue("./solutions/", html_file),
          overwrite = TRUE
        )

        unlink(glue::glue("./content/exercises/", html_file))
      }
    }
  }
