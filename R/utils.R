#' @keywords internal
build_active_session <- function () {
  build_session(rstudioapi::getActiveDocumentContext()$path)
}
