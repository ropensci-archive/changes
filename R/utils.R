# Creates a file with specified text
file_create <- function(txt, filename){
  if(!file.exists(filename)){
    writeLines(txt, filename)
  }
}

# helpers
some <- function (x) {
  length(x) > 0
}

none <- function (x) {
  !some(x)
}

one <- function (x) {
  length(x) == 1
}

# nicely format the number of file changes or line additions / deletions
paste_num <- function (number, item, event, fallback = NULL) {

  if (number == 0) {
    text <- fallback
  } else if (number == 1) {
    text <- sprintf("%i %s %s", number, item, event)
  } else {
    text <- sprintf("%i %ss %s", number, item, event)
  }

  text
}