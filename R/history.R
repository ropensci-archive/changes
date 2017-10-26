#' Shows the commit log
#'
#' This function shows me
#'
#' @param process_object process object obtained from process function
#' @return decon list containing amended dataframe, bounds, model output, mass fractions
#' @keywords thermogravimetry fraser-suzuki deconvolution
#' @import git2r 
#' @importFrom stats integrate setNames loess
#' @examples
#'
#' @export

history <- function ( ) {
  library('git2r')
  #repo <- get_repo()
  repo <- git2r::repository(getwd())
  records <- git2r::commits(repo)
  
  
  
  obj <- 'A; B; C'
  grViz("

  digraph boxes_and_circles {

  node [shape = circle]
  obj

  node [shape = box]
  1
  }
      
        
  ")
    
  
}




