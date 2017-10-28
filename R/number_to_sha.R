#' convert a user-provided commit number to a sha
#'
#' @param repo a git2r git repository
#' @param number a positive integer giving the record number, as returned by
#'   timeline
#' @return a character giving the commit sha
#' 
#' @importFrom git2r revparse_single
#'
#' @noRd
number_to_sha <- function (repo, number) {
  
  records <- git2r::commits(repo)
  
  n_records <- length(records)
  
  if (!number %in% seq_len(n_records)) {
    stop("the records are numbered 1-", n_records,
         ", there's no record ", number,
         call. = FALSE)
  }
  
  # count back from n_records
  reference <- paste0("HEAD~", n_records - number)
  commit <- git2r::revparse_single(repo, reference)
  commit@sha
  
}