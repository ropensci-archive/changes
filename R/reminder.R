#' Set the reminder delay in minutes for commit reminder messages
#'
#' TODO: Describe this better.
#'
#' @param minutes Delay in minutes
#'
#' @return NULL
#' @export
#'
#' @examples TODO
reminder_delay <- function(minutes) {
  assertCount(minutes)
  # convert minutes to seconds of reminder delay, store in .cache environment
  .cache[["reminder_delay"]] <- minutes*60
  invisible(NULL)
}

#' Schedule a reminder
#'
#' TODO: This needs to be called at the tope of every stow function, as well as in the .onLoad of the package
#'
#' @param 
#'
#' @return NULL
#' @export
#'
#' @examples TODO
schedule_reminder <- function() {
  # get the reminder delay from the .cache environment
  delay <- .cache$reminder_delay
  if (delay > 0) {
    later::later(~cat("Hey, you should commit your changes!\n"), delay=delay)
  }
  invisible(NULL)
}

