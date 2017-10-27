
get_shas <- function(repo, nchars = NULL) {
  
  # commits   <- git2r::commits(repo)
  # shas      <- vapply(commits, function(x) x@sha, character(1))
  
  shas <- call_system("git", c("rev-list", "--all"))
  
  if(!is.null(nchars)) {
    shas <- substr(shas,1,nchars)
  }
  
  shas
}

