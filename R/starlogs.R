#' Show repo history in starlogs
#'
#' Display your past record messages at starlogs.net. This requires internet
#' access and only works for version control projects that have an online copy
#'
#' @export
#' @importFrom git2r remotes remote_url
#' @importFrom utils browseURL
starlog <- function() {
  
  repo <- get_repo()
  remote_urls <- git2r::remote_url(repo)
  
  if (some(remote_urls)) {
    remote_url <- remote_urls[1] 
    remote_parts <- strsplit(remote_url, "/")[[1]]
    last_parts <- remote_parts[length(remote_parts) - 1:0]
    starlogs_url <- sprintf("http://starlogs.net/#%s/%s",
                   last_parts[1],
                   last_parts[2])
    browseURL(starlogs_url)
    
  } else {
    message("this version control project has no online copies, ",
            "so you can't use starlog just yet")
  }
  
}

