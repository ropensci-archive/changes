
set_reminder <- function(minutes) {
  # convert minutes to seconds of reminder delay in seconds somewhere 
}

# This needs to be called at the tope of every stow function,
# as well as in the .onLoad of the package
schedule_reminder <- function() {
  # get the reminder delay from wherever
  later::later(function() { print( changes())}, delay=delay)
}

