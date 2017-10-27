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
  shas      <- vapply(commits, `@`, character(1), "sha")
  index     <- which(sha == shas)

  if (length(index) == 0) {
    stop("Can not find corresponding record.")
  }


  git2r::checkout(commits[[index[1]]], branch = timestamp, create = TRUE)
  git2r::checkout(branch = "master")

  msg <- sprintf("Retrieving previous state from sha: %s", sha)
  branch <- git2r::branches()[[timestamp]]
  git2r::merge(branch, `--strategy-option` = "theirs", `-m` = msg)
}
