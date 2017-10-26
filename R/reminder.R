
set_reminder <- function(minutes) {
  # convert minutes to seconds of reminder delay, store in .cache environment
  .cache[["reminder_delay"]] <- minutes*60
}

# This needs to be called at the tope of every stow function,
# as well as in the .onLoad of the package
schedule_reminder <- function() {
  # get the reminder delay from wherever
  delay <- .cache$reminder_delay
  later::later(function() { print(getwd())}, delay=delay)
}

