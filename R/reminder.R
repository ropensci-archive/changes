#' Set the reminder delay in minutes for commit reminder messages
#'
#' TODO: Describe this better.
#'
#' @param minutes delay in minutes
#'
#' @return nothing
#' @importFrom checkmate assertCount
#' @export
reminder_delay <- function(minutes) {
  assertCount(minutes)
  # convert minutes to seconds of reminder delay, store in .cache environment
  secs_delay <- minutes * 60
  .cache[["reminder_delay"]] <- secs_delay
  if (minutes < 1) {
    msg <- "Reminders disabled"
  } else {
    msg <- paste("Reminders set for", minutes, "minutes")
  }
  message(msg) 
  schedule_reminder()
  invisible(NULL)
}

#' Schedule a reminder
#'
#' TODO: This needs to be called at the tope of every stow function, as well as in the .onLoad of the package
#'
#' @return nothing
schedule_reminder <- function() {
  # get the reminder delay from the .cache environment
  delay <- NULL
  delay <- .cache$reminder_delay
  if (is.null(delay)) delay <- 60*30
  if (delay > 0) {
    later::later(function() { show_reminder() }, delay=delay)
  }
  invisible(NULL)
}

#' Show a reminder message
#'
#' @return nothing
#' @importFrom notifier notify
show_reminder <- function() {
  n_changes <- changes(silent=TRUE)
  if (n_changes) {
    if (n_changes < 2) {
      msg <- c(paste("Hey, there is", n_changes, "file that"),
                     "has changed since your last commit to git!")
    } else {
      msg <- c(paste("Hey, there are", n_changes, "files that"),
                     "have changed since your last commit to git!")
    }  
    notify(msg, title="A gentle reminder from stow")
  }
  # No need to reschedule the reminder, at least on macOS, it is persistent
  # schedule_reminder()
  # return nothing
  invisible(NULL)
}

