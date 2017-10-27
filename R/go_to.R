#' Go to a Specified Snapshot in the Version Control Timeline
#'
#' TODO Describe this better.
#'
#' @param sha The snapshot to go to.
#'
#' @return TODO
#' @export
go_to <- function(sha)
{
  repo <- get_repo()
  
  commits   <- git2r::commits(repo)
  shas      <- vapply(commits, function(x) x@sha, character(1))
  
  if (!sha %in% shas) {
    stop("The provided sha is not found.")
  }
  
  invisible(git2r::checkout(repo, sha))
}
