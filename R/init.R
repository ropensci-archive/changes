# new version of git_init for use in create_repo()

#' @noRd
#' @importFrom git2r init commits
init <- function (path) {
  
  path <- normalizePath(path)
  
  # create/get a repo
  repo <- git2r::init(path)
  
  # check whether there are already commits
  commits <- git2r::commits(repo)
  
  # if there are existing commits, then a repo wasn't created!
  if (some(commits)) {
    
    if (identical(path, repo@path)) {
      stop ("this directory (",
            path,
            ") is already covered by a version control project",
            call. = FALSE)
      
    } else {
      
      stop ("this directory (",
            path,
            ") is already covered by a version control project, based in",
            repo@path,
            call. = FALSE)
      
    }

  }
  
}
