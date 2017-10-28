#' Record Changes in Files under Version Control.
#'
#' TODO Describe this better.
#'
#' @param message character: the message to be added to the version control
#'   checkpoint.
#'
#' @return the git2r commit object (S4). TODO: maybe return something nicer.
#'
#' @importFrom git2r add commit
#'
#' @export
record <- function (message) {
  
  repo <- get_repo()

  if (!head_at_master(repo)) {
    
    # We are in detached head state...
    # commit the diffs to master->head  on top and linearize.
    cat("You are currently behind the latest version.\n")
    cat("Do you want to add your changes and make this the latest version? [Yes/No]? ")
    answer <- readLines(n = 1, warn = FALSE)
    if (!any(c("y", "ye", "yes") %in% tolower(answer)))
      return (invisible(NULL))

    git2r::stash(repo)  # call_system("git", "stash")
    git2r::checkout(repo, "master")
    
    n_commits <- length(git2r::commits(repo))
    retrieve(n_commits)
    # git2r::stash_drop(repo) 
    call_system("git", "stash pop")
  }
  
  # check the message
  message <- check_message(message)

  # Stage unstaged changes
  git2r::add(repo, "*")

  capture.output(git2r::commit(repo, message = message))
  
  invisible(NULL)
  
}

