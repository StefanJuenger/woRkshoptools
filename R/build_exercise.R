#' Build a exercise
#'
#' Builds a exercise and moves their files into the respective folders
#'
#' @param exercises_home Character; path to the exercises folder
#'
#' @importFrom magrittr %>%
#'
#' @export

build_exercise <-
  function (
    exercise_path  = NULL
  ) {

    # checks
    if (is.null(exercise_path)) {
      stop("Please define a proper path.")
    }

    # exercise
    rmarkdown::render(
      exercise_path,
      output_format =
        unilur::tutorial_html(suffix = ""),
      knit_root_dir = getwd()
    )

    html_file <-
      exercise_path %>%
      basename() %>%
      stringr::str_remove(".Rmd") %>%
      glue::glue(., ".html")

    file.copy(
      glue::glue("./content/exercises/", html_file),
      glue::glue("./exercises/", html_file),
      overwrite = TRUE
    )

    unlink(glue::glue("./content/exercises/", html_file))

    # solution
    rmarkdown::render(
      exercise_path,
      output_format =
        unilur::tutorial_html_solution(suffix = ""),
      knit_root_dir = getwd()
    )

    html_file <-
      exercise_path %>%
      basename() %>%
      stringr::str_remove(".Rmd") %>%
      glue::glue(., ".html")

    file.copy(
      glue::glue("./content/exercises/", html_file),
      glue::glue("./solutions/", html_file),
      overwrite = TRUE
    )

    unlink(glue::glue("./content/exercises/", html_file))
  }
