#' Reminders to Record Your Work
#'
#' It's easy to get carried away and forget to record your work. stow can send
#' you a reminder if you have work that needs to be committed, but haven't used
#' a stow function for some time.
#'
#' @param after how long (in minutes) to wait before reminding you to record
#'   your work
#'
#' @details To turn off reminders, just do \code{remind_me(after = 0)}.
#'   \code{remind_me()} is called by default when you run
#'   \code{\link{create_repo}()}.
#'
#' @export
remind_me <- function(after = 60) {
  
  minutes <- as.integer(after)
  
  # convert minutes to seconds of reminder delay, store in .cache environment
  .cache[["reminder_delay"]] <- minutes
  
  if (minutes < 1) {
    msg <- "Reminders disabled"
  } else {
    msg <- paste("Reminders set for", minutes, "minutes")
  }
  
  cat(msg) 
  
  schedule_reminder()
  
}

#' Schedule a reminder
#'
#' Called in get_repo() so at the topof every user-exposed function
#' 
#' @noRd
schedule_reminder <- function() {
  
  # get the reminder delay from the .cache environment
  delay <- .cache$reminder_delay
  
  # coerce to seconds here, so we can use minutes elsewhere
  if (delay > 0) {
    later::later(show_reminder,
                 delay = delay * 60)
  }
  
}

#' Show a reminder message
#'
#' @noRd
#' 
#' @importFrom notifier notify
show_reminder <- function () {
  
  n_changes <- changes(silent = TRUE)
  
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
  # return nothing
  invisible (NULL)
}

