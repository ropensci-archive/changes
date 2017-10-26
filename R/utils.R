# Creates a file with specified text

file_create <- function(txt, filename){
  if(!file.exists(filename)){
    writeLines(txt, filename)
  }
}
