#' @keywords internal
build_active_session <- function () {
  build_session(rstudioapi::getActiveDocumentContext()$path)
}

#' @keywords internal
build_active_exercise <- function () {
  build_exercise(rstudioapi::getActiveDocumentContext()$path)
}
