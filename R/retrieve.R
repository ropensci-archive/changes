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
  
  sha <- number_to_sha(repo, number)

  if (!is_clean(repo)) {
    stop ("there are some changes that haven't been recorded, ",
         "you need to record (or scrub) them before you can retrieve ",
         "a past record.", call. = FALSE)
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

  msg <- sprintf("Retrieving previous state from record %i", number)
  git2r::commit(repo, message = msg)
}
