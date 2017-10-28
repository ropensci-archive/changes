#' Shows the commit log
#'
#' This function shows the history of records made. 
#'
#' @return timeline object
#' @importFrom methods slot as 
#' @importFrom git2r commits
#' 
#' @export

timeline <- function () {

  repo <- get_repo()
  records <- git2r::commits(repo)
  
  if (none(records)) {
    message("You haven't made any records yet")
  }
  
  record_id <- rev(seq_along(records))
  raw_author <- lapply(records, slot, 'author')
  author <- vapply(raw_author, slot, 'name', FUN.VALUE = "")
  when <- lapply(raw_author, function (x) as(slot(x, "when"), "POSIXct"))
  when <- do.call(c, when)
  email <- vapply(raw_author, slot, 'email', FUN.VALUE = "")
  message <- vapply(records, slot, 'message', FUN.VALUE = "")
  sha <- vapply(records, slot, 'sha', FUN.VALUE = "")
  
  log <- data.frame(record_id, author, when, email, message, sha)
  
  structure(log, class = c('timeline', class(log)))
  
}

