#' Check a message and give some advice 
#'
#' @return the message
#'
#' @noRd
check_message <- function (message) {
  
  if (missing(message))
    message <- ""
  
  bad <- !is.character(message) || nchar(message) == 0
  
  if (bad) {
    stop ("You can't record without a message saying what you changed. ",
          "Try putting something short but descriptive like: \"",
          random_good_message(),
          "\"",
          call. = FALSE)
  }
  
  message
  
}

random_good_message <- function () {
  
  good_messages <- c(
    "first attempt at plotting results",
    "spell-check manuscript",
    "add main README file",
    "fix typo that was breaking analysis",
    "adapt code for new dataset"
  )
  
  sample(good_messages, 1)
}