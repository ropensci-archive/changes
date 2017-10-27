#' Set the reminder delay in minutes for commit reminder messages
#'
#' TODO: Describe this better.
#'
#' @param minutes delay in minutes
#'
#' @return nothing
#' @export
reminder_delay <- function(minutes) {
  
  minutes <- as.integer(minutes)
  
  # convert minutes to seconds of reminder delay, store in .cache environment
  .cache[["reminder_delay"]] <- minutes
  
  if (minutes < 1) {
    msg <- "Reminders disabled"
  } else {
    msg <- paste("Reminders set for", minutes, "minutes")
  }
  
  message(msg) 
  
  schedule_reminder()
  
}

#' Schedule a reminder
#'
#' TODO: This needs to be called at the tope of every stow function, as well as in the .onLoad of the package
#'
#' @return nothing
#' @noRd
schedule_reminder <- function() {
  
  # get the reminder delay from the .cache environment
  delay <- .cache$reminder_delay
  
  if (delay > 0) {
    later::later(show_reminder,
                 delay = delay * 60)
  }
  
}

#' Show a reminder message
#'
#' @return nothing
#' @noRd
show_reminder <- function() {
  
  n_changes <- changes(silent = TRUE)
  
  if (n_changes > 0) {
    
    if (n_changes < 4) {
      msg <- "\nHey, it's been a while since you record()ed your changes..\n"
    } else {
      msg <- "\nHey, there are a shedload of changes which you should record()!\n"
    }      
    
    message(msg)
    changes()
  }
  
  # reschedule the reminder
  schedule_reminder()
  
  # return nothing
  invisible (NULL)
}

