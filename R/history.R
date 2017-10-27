#' Shows the commit log
#'
#' This function shows the history of records made. 
#'
#' @return history object
#' @keywords  
#' @import git2r purrr
#' @importFrom methods slot as
#' This script borrows from the 'githug' package: https://github.com/jennybc/githug
#' @examples
#' 
#' @export

history <- function ( ) {

  #repo <- get_repo()
  repo <- git2r::repository(getwd())
  records <- git2r::commits(repo)
  
  if (length(records) == 0) {
    message("No records yet added.")
  }
  
  record_id <- as.list(seq(length(records), 1, length.out = length(records)))
  raw_author <- purrr::map(records, methods::slot, "author")
  author <- purrr::map(raw_author, methods::slot, 'name')
  when <- purrr::map(raw_author, methods::slot, "when")
  when <- purrr::map(when, ~ methods::as(.x, "POSIXct"))
  when <- do.call(c, when)
  email <- purrr::map_chr(raw_author, methods::slot, "email")
  message <- purrr::map_chr(records, methods::slot, "message")
  sha <- purrr::map_chr(records, methods::slot, "sha")
  
  log <- tibble::tibble(record_id, author, when, email, message, sha)
  
  structure(log, class = c('history', class(log)))
  log
  
}

