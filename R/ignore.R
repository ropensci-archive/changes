#' @name ignore
#'
#' @title Ignore (or unignore) files and folders from version control
#'
#' @description By default, changes will keep track of (almost) all of the files in
#'   your project. You can use \code{ignore()} to make changes ignore certain files
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
  
  # if any of these files are being tracked, do git rm --cached on them
  tracked <- vapply(files, is_tracked, FUN.VALUE = FALSE)
  if (any(tracked)) {
    call_system("git", c("rm --cached", files[tracked]))
  }
  
}

is_tracked <- function (file) {
  path <- call_system("git", c("ls-files", file))
  some(path)
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
