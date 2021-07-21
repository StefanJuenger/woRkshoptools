#' Add packages to your packages config file
#'
#' A function to add a package to your existing packages config file
#'
#' @param package_name Character; name of the package you want to add
#' @param packages_config_file Character; the path to your packages config file
#'
#' @importFrom magrittr %>%
#'
#' @export

add_package_to_config <-
  function(
    package_name,
    packages_config_file = "./content/config/packages_to_load"
  ) {

    readr::write_lines(
      package_name,
      packages_config_file,
      append = TRUE
    )
  }
