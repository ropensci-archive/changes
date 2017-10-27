#' Check a message and give some advice 
#'
#' @return the message
#'
#' @noRd
check_message <- function (message) {
  
  bad <- !is.character(message) || nchar(message) == 0
  
  if (bad) {
    stop ("you can't record without a message\n",
          "try putting something short but descriptive like: \"",
          random_good_message(),
          "\"")
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