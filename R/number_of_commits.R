#' determine the number of commits on master in the past, in total or in the
#' future
#'
#' @param repo a git2r git repository
#' @param which one of "past", "total", or "future"
#'
#' @noRd
number_of_commits <- function (repo, which = c("past", "total", "future")) {
  which <- match.arg(which)
  
  switch (which,
          past = past_number_of_commits(repo),
          total = total_number_of_commits(repo),
          future = future_number_of_commits(repo))
}

# how many commits behind HEAD?
past_number_of_commits <- function (repo) {
  records <- git2r::commits(repo)
  length(records)
}

# how many commits behind master?
total_number_of_commits <- function (repo) {
  past_number_of_commits(repo) + future_number_of_commits(repo)
}

# how many commits from HEAD to master?
future_number_of_commits <- function (repo) {
  master_commit <- git2r::revparse_single(repo, "master")
  head_commit <- git2r::revparse_single(repo, "HEAD")
  diff(git2r::ahead_behind(head_commit, master_commit))
}
