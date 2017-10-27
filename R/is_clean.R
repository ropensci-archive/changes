#' Check if the Repo is Clean
#'
#' @param repo A git2r repo object
#'
#' @importFrom git2r status
#'
#' @return logical TRUE if there are no changes.
#' @noRd
is_clean <- function(repo)
{
  sum(vapply(git2r::status(repo), length, numeric(1))) == 0
}