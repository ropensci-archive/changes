#' Retrieve code from a past record
#'
#' TODO Describe this better.
#' 
#' @param number the record number to retrieve
#'
#' @importFrom git2r checkout commits
#'
#' @export
retrieve <- function (number) {
  
  repo <- get_repo()
  
  if (!is_clean(repo)) {
    stop ("there are some changes that haven't been recorded, ",
         "you need to record (or scrub) them before you can retrieve ",
         "a past record.", call. = FALSE)
  }
  
  # check the number is valid
  number_to_sha(repo, number)
  index <- number - 1

  if (index == 0) {
    commit_range <- "master"
  } else {
    commit_range <- sprintf("master~%d..master", index)
  }

  # TODO make this work using git2r, and don't do system calls.
  call_system("git", c("revert", "--no-commit", commit_range))

  msg <- sprintf("retrieving previous state from record %i", number)
  record(msg)
  
  # checkout master, in case anything went awry (e.g. nothing to commit)
  master <- git2r::branches(repo)$master
  git2r::checkout(master)
  
  invisible(NULL)
}
