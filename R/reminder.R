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
    msg <- "reminders disabled"
  } else {
    msg <- paste("reminders set for", minutes, "minutes")
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
  .cache$reminder_paused <- FALSE
  
  # coerce to seconds here, so we can use minutes elsewhere
  if (delay > 0) {
    later::later(show_reminder,
                 delay = delay * 60)
  }
  
}

#' Show a reminder message
#'
#' @noRd
show_reminder <- function () {
  
  capture.output(changed <- changes())
  n_changes <- nrow(changed)
  
  paused <- .cache$reminder_paused
  
  if (n_changes > 0 & !paused) {
    
    msg <- paste_num(n_changes, "file", "changed since you last recorded your work!")
    cat("\nHey,", msg)
    
    # pause the reminder, until they use another stow function
    .cache$reminder_paused <- TRUE
    
  }
  
  # return nothing
  invisible (NULL)
}

