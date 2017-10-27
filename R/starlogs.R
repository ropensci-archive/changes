#' Show repo history in starlogs
#'
#' TODO: Describe this better.
#'
#' @return nothing
#' @noRd
starlog <- function() {
  repo <- get_repo()
  remote_url <- paste(strsplit(git2r::remote_url(repo, git2r::remotes(repo)),"/")[[1]][4:5], sep="", collapse="/")
  browseURL(url = paste("http://starlogs.net/#",remote_url, sep='', collapse=""))
}

