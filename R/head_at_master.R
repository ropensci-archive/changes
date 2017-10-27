#' Check if HEAD is at master
#'
#' @return logical indicating if head is at master.
#'
#' @importFrom githug git_revision
#'
#' @noRd
head_at_master <- function()
{
  git_revision("HEAD")[1] == git_revision("master")[1]
}
