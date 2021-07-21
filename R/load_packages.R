#' Load all packages for your presentation
#'
#' A function to load all packages that you need for your presentation; relies
#' on an associated config file
#'
#' @param packages_config_file Character; the path to your packages config file
#'
#' @importFrom magrittr %>%
#'
#' @export

load_packages <-
  function (packages_config_file = "./content/config/packages_to_load") {

    readr::read_lines(
      "./content/config/packages_to_load"
    ) %>%
      easypackages::packages(
      )
  }
