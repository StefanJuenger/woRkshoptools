#' Build the sessions
#'
#' Build the sessions and moves their files accordingly
#'
#' @param sessions_home Character; path to the sessions folder
#' @param build_all Logical; defines whether all sessions are build or only the
#' changed ones. Relies on a CSV file comprising checksums that is created the
#' first time \code{build_sesssion()} was used; default is \code{FALSE}
#'
#' @importFrom magrittr %>%
#'
#' @export

build_sessions <-
  function (
    sessions_home  = "./content/sessions/",
    build_all = FALSE
  ) {

    # Load 'index' of files if it exists
    if(file.exists(glue::glue(sessions_home, "sessions_list.csv"))) {
      sessions_list_previous <-
        readr::read_csv(
          glue::glue(sessions_home, "sessions_list.csv")
        ) %>%
        dplyr::mutate(
          previous = current
        ) %>%
        dplyr::select(-current)
    }

    # Create list of current files in folder
    sessions_list_current <-
      tibble::tibble(
        session_name =
          list.files(sessions_home, recursive = FALSE) %>%
          .[stringr::str_detect(., "Rmd")]
      ) %>%
      dplyr::mutate(
        current = tools::md5sum(paste0(sessions_home, session_name))
      )

    # join lists and update existing one if it exists; otherwise create it
    if (file.exists(glue::glue(sessions_home, "sessions_list.csv"))) {
      sessions_list <-
        dplyr::full_join(
          sessions_list_previous,
          sessions_list_current
        ) %>%
        dplyr::mutate(
          previous = ifelse(is.na(previous), "...", previous)
        ) %>%
        dplyr::filter(!is.na(current))

      readr::write_csv(
        sessions_list,
        glue::glue(sessions_home, "sessions_list.csv")
      )
    } else {
      sessions_list <-
        sessions_list_current %>%
        dplyr::mutate(previous = current) %>%
        dplyr::select(
          session_name, previous, current
        )

      readr::write_csv(
        sessions_list_current,
        glue::glue(sessions_home, "sessions_list.csv")
      )
    }

    # build files that changed
    for (i in 1:nrow(sessions_list)) {

      if (isFALSE(sessions_list$previous[i] == sessions_list$current[i]) | isTRUE(build_all)) {

        rmarkdown::render(
          glue::glue(sessions_home, sessions_list$session_name[i]),
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
          list.files(sessions_home) %>%
          .[stringr::str_detect(., "html")]

        file.copy(
          glue::glue(sessions_home, html_file),
          glue::glue("./slides/", html_file),
          overwrite = TRUE
        )

        unlink(glue::glue(sessions_home, html_file))
      }
    }


  }
