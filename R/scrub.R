#' Remove all unstaged changes
#'
#' Undo all of the changes you made since the last time you did \code{record()}.
#' \emph{WARNING: this will delete and change files and can't be undone!}
#'
#' @export
scrub <- function()
{
  call_system("git", "reset --hard HEAD")
}
