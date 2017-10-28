#' Remove all unstaged changes
#'
#' Undo all of the changes you made since the last time you did \code{record()}.
#' \emph{WARNING: this will delete and change files and can't be undone!}
#' @importFrom git2r reset revparse_single
#' @export
scrub <- function()
{
  repo <- get_repo()
  head <- git2r::revparse_single(repo, "HEAD")
  git2r::reset(head, "hard")
}
