source('R/functions.R')
library('git2r')
library('githug')
repo <- repository(getwd())

devtools::install_github("jennybc/githug")

is_empty(repo)
branches(repo)

repo_path(repo)
repo_path()

git_history <- function(repo = ".", ...) {
  commits <- git2r::commits(as.git_repository(repo), ...)
  if (length(commits) == 0L) {
    message("No commits yet.")
    return(invisible())
  }
  raw_author <- purrr::map(commits, methods::slot, "author")
  ctbl <- tibble::tibble(
    sha = purrr::map_chr(commits, methods::slot, "sha"),
    message = purrr::map_chr(commits, methods::slot, "message"),
    when = purrr::map(raw_author, methods::slot, "when"),
    author = purrr::map_chr(raw_author, methods::slot, "name"),
    email = purrr::map_chr(raw_author, methods::slot, "email")
  )
  ctbl$when <- purrr::map(ctbl$when, ~ methods::as(.x, "POSIXct"))
  ctbl$when <- do.call(c, ctbl$when)
  structure(ctbl, class = c("git_history", class(ctbl)))
}

#' @export
print.git_history <- function(x, ...) {
  x_pretty <- tibble::tibble(
    sha = substr(x$sha, 1, 7),
    message = sprintf("%-24s", ellipsize(x$message, 24)),
    when = format(x$when, format = "%Y-%m-%d %H:%M"),
    author = x$author,
    email = x$email
  )
  print(x_pretty)
  invisible(x)
}
