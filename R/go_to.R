#' Go to a Specified Snapshot in the Version Control Timeline
#'
#' TODO Describe this better.
#'
#' @param sha The snapshot to go to.
#'
#' @importFrom git2r commits checkout
#' 
#' @return TODO
#' @export
go_to <- function(sha)
{
  
  repo <- get_repo()
  
  shas <- get_shas(repo, nchar(sha))
  
  if (!sha %in% shas) {
    stop("The provided sha is not found.")
  }
  
  call_system("git", c("checkout", sha))
  
}
