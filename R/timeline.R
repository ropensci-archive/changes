#' Shows the commit log
#'
#' This function shows the history of records made. 
#'
#' @return history object
#' @importFrom methods slot as 
#' @importFrom tibble tibble 
#' @importFrom git2r commits
#' 
#' @export

timeline <- function () {

  repo <- get_repo()
  records <- git2r::commits(repo)
  
  if (length(records) == 0) {
    message("No records yet added.")
  }
  
  record_id <- as.list(seq(length(records), 1, length.out = length(records)))
  raw_author <- lapply(records, methods::slot, 'author')
  author <- lapply(raw_author, methods::slot, 'name')
  when <- lapply(raw_author, methods::slot, 'when')
  when <- lapply(when, methods::as, 'POSIXct')
  when <- do.call(c, when)
  email <- lapply(raw_author, methods::slot, 'email')
  message <- lapply(records, methods::slot, 'message')
  sha <- lapply(records, methods::slot, 'sha')
  
  log <- tibble::tibble(record_id, author, when, email, message, sha)
  
  structure(log, class = c('timeline', class(log)))
  
}

