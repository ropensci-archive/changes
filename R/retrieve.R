#' Retrieve code from a past commit.
#'
#' If the argument files is NULL will reteive state of entire repo
#'
#' TODO Describe this better.
#' @param sha The sha to retrieve
#' @param files vector or list files to retrive TODO: add this
#'
#' @importFrom git2r checkout commits
#'
#' @return TODO
#' @export
retrieve <- function(sha, files = NULL) {
  
  repo <- get_repo()

  # TODO scrub the existing changes.
  if (!is_clean(repo)) {
    stop("You need to record or scrub before you ",
         "can retrieve when there are changes.")
  }

  timestamp <- gsub("[^0-9]", "", Sys.time())
  commits   <- git2r::commits(repo)
  shas      <- get_shas(nchar(sha))
  index     <- which(sha == shas) - 2

  if (index < 0) {
    stop("Can not find corresponding record.")
  } else if (index == 1) {
    commit_range <- "master"
  } else {
    commit_range <- sprintf("master~%d..master", index)
  }

  # TODO make this work using git2r, and don't do system calls.
  call_system("git", c("revert", "--no-commit", commit_range))

  msg <- sprintf("Retrieving previous state from sha: %s", sha)
  git2r::commit(repo, message = msg)
}
