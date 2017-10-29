#' Go to a Specified Record in the Version Control Timeline
#'
#' TODO Describe this better.
#'
#' @param number the record number to go to
#'
#' @importFrom git2r commits checkout
#' 
#' @export
go_to <- function (number) {
  
  repo <- get_repo()
  
  sha <- number_to_sha(repo, number)
  
  commit <- git2r::revparse_single(repo, sha)
  git2r::checkout(commit)  # call_system("git", c("checkout", sha))
  
  # if HEAD is now at master, reattach HEAD to master
  if (head_at_master(repo)) {
    master <- git2r::branches(repo)$master
    git2r::checkout(master)
  }
  
}
