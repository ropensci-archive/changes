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
#' @param 
#'
#' @return NULL
#' @export
#'
#' @examples TODO
schedule_reminder <- function() {
  # get the reminder delay from the .cache environment
  delay <- NULL
  delay <- .cache$reminder_delay
  if (is.null(delay)) delay <= 60*30
  if (delay > 0) {
    later::later(function() { show_reminder() }, delay=delay)
  }
  invisible(NULL)
}

#' Show a reminder message
#'
#' @param 
#'
#' @return NULL
#' @export
#'
#' @examples TODO
show_reminder <- function() {
  n_changes <- changes(silent=TRUE)
  if (n_changes) {
    if (n_changes < 4) {
      msg <- "\nHey, it's been a while since you record()ed your changes..\n"
    } else {
      msg <- "\nHey, there are a shedload of changes which you should record()!\n"
    }      
    message(msg)
    changes()
    quote_df <- as.data.frame(statquotes::statquote())
    message(paste("\n",quote_df$text,"\n--- ",quote_df$source, "\n", sep=""))
  }
  # reschedule the reminder
  schedule_reminder()
  # return nothing
  invisible(NULL)
}

