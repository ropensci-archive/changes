#' Create a Repository for Version Control
#'
#' TODO: Describe this better.
#'
#' @param path TODO
#' @param add_structure TODO
#' @param change_wd TODO
#' @param remind_me_after set reminder delay in minutes, zero disables reminders
#'
#' @details See \code{\link{remind_me}()} for more information on reminders
#'
#' @export
create_repo <- function (path = getwd(), add_structure = TRUE, change_wd = TRUE, remind_me_after = 60) {

  # Create a new git repo
  init(path)
  message("started version control project at ", path)
  
  # record current path
  old_dir <- getwd()
  if (path != old_dir && !change_wd) {
    on.exit(setwd(old_dir))
  }

  # go into repo and setup directory structure
  setwd(path)

  # make sure this is the repo being pointed at now
  .cache$repo <- NULL
  get_repo()
  
  if (add_structure) {
    folders  <-  c("data", "output", "ignore", "R")
    for (k in seq_along(folders)) {
      dir.create(folders[k], TRUE, FALSE)
      file_create("", file.path(folders[k], '.keep'))
    }

    file_create(c("# About my project", "", "My data is..."), "README.md")
    file_create(c("# About my data", "", "My data is..."), "data/README.md")
    file_create(c("# My R functions", ""), "R/utils.R")
    file_create(c("# Ignore these files",
                  ".DS_Store", "*.Rapp.history", "*.Rhistory",
                  "*.RData", "*tmp*", "*.rda", "*.rds", "*~$*",
                  ".Rproj.user", "ehthumbs.db", "Icon?",
                  "Thumbs.db", "ignore", "output", ".gitignore"),
                ".gitignore")
    
    # commit the new structure
    record("set up project structure")
    
  }

  remind_me(remind_me_after)
  
}
