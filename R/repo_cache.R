
# set up a cache
.cache <- new.env()

#' get the git repository from the cache
#'
#' @details if no repo is in the cache, this function will try to instantiate
#'   it. If the working directory is not within the directory of the repo, it
#'   will error.
#'
#' @return a git2r repository
#' @noRd
#' @importFrom git2r discover_repository repository
#'
#' @examples
get_repo <- function () {
  
  # see where we are
  cwd <- getwd()
  
  # see if a repo exists
  repo <- .cache[["repo"]]
  
  # if a repo isn't cached, look for one
  if (is.null(repo)) {
    repo_path <- discover_repository(cwd)
    if (!is.null(repo_path)) {
      repo <- repository(path = cwd)
      .cache[["repo"]] <- repo
    }
  }
  
  # if it's still not there, error
  if (is.null(repo)) {
    
    stop ("no version control project could be found in this directory:\n\t",
          cwd,
          "\nyou can create a version control project with create_repo()",
          call. = FALSE)
    
  } else {
    
    # otherwise check we're in the correct directory
    repo_path <- file.path(repo@path, ".git/")
    visible_repo_path <- discover_repository(cwd)
    same_directory <- identical(repo_path, visible_repo_path)
    
    if (!same_directory) {
      stop ("The current working directory (", cwd,
            ") is not in the directory of this version control project.\n",
            "You could do setwd(\"", repo@path,
            "\") to move back into the directory and rerun this function.",
            call. = FALSE)
    }
    
  }
  
  # return the object
  invisible(repo)
  
}