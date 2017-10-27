#' @name ignore
#'
#' @title Ignore (or unignore) files and folders from version control
#'
#' @description By default, stow will keep track of (almost) all of the files in
#'   your project. You can use \code{ignore()} to make stow ignore certain files
#'   (not track different versions of them), and \code{unignore()} to make it
#'   track files that are currently ignored.
#'
#'   You can use wildcard characters to match multiple files, e.g.
#'   \code{ignore("*.csv")} to ignore all csv files.
#'
#' @param files a character vector of files to ignore
#'
#' @export
ignore <- function (files) {
  
  repo <- get_repo()
  gitignore <- gitignore_path(repo)
  
  # add to gitignore (if it isn't already there)
  entries <- readLines(gitignore)
  files <- files[!files %in% entries]
  entries <- c(entries, files)
  writeLines(entries, gitignore)
  
  # do git rm --cached on these files
  call_system("git", c("rm --cached", files))
  
}

#' @rdname ignore
#' @export
unignore <- function(files) {
  
  repo <- get_repo()
  files_ignore <- paste0("!", files)
  gitignore <- gitignore_path(repo)
  
  # remove from gitignore (if it's there) and explicitly ignore it
  entries <- readLines(gitignore)
  entries <- entries[!entries %in% files]
  entries <- c(entries, files_ignore)
  writeLines(entries, gitignore)
  
}

gitignore_path <- function (repo) {
  
  path <- file.path(repo@path, ".gitignore")
  
  if (!file.exists(path))
    file.create(path)
  
  path
  
}
