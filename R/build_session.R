#' Build the sessions
#'
#' Build session slides and moves their files into the respective folders
#'
#' @param session_path Character; path to the session
#'
#' @importFrom magrittr %>%
#'
#' @export

build_session <-
  function (
    session_path = NULL
  ) {

    # checks
    if (is.null(session_path)) {
      stop("Please define a proper path.")
    }

    # build session
    rmarkdown::render(
      session_path,
      output_format =
        xaringan::moon_reader(
          css = c("default", "../assets/css/gesis.css"),
          self_contained = TRUE,
          nature =
            list(
              highlightStyle = "github",
              highlightLines =  "true",
              countIncrementalSlides = "false"
            )
        ),
      knit_root_dir = getwd()
    )

    html_file <-
      session_path %>%
      basename() %>%
      stringr::str_remove(".Rmd") %>%
      glue::glue(., ".html")

    file.copy(
      glue::glue("./content/sessions/", html_file),
      glue::glue("./slides/", html_file),
      overwrite = TRUE
    )

    unlink(glue::glue("./content/sessions/", html_file))
  }

