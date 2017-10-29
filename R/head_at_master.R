#' Check if HEAD is at master
#'
#' @return logical indicating if head is at master.
#'
#' @importFrom git2r revparse_single
#'
#' @noRd
head_at_master <- function (repo) {
  master_commit <- git2r::revparse_single(repo, "master")
  head_commit <- git2r::revparse_single(repo, "HEAD")
  master_commit@sha == head_commit@sha
}

