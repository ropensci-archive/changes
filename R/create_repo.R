#' Create a Repository for Version Control
#'
#' TODO: Describe this better.
#'
#' @param path TODO
#' @param add_structure TODO
#' @param change_wd TODO
#' @param reminders set reminder delay in minutes, zero disables reminders
#'
#' @export
create_repo <- function (path = getwd(), add_structure = TRUE, change_wd = TRUE, reminders = 30) {

  # Create a new repo
  # Possibly want more specific error messages than exist here?
  init(path)

  # record current path
  old_dir <- getwd()
  if (path != old_dir && !change_wd) {
    on.exit(setwd(old_dir))
  }

  # go into repo and setup directory structure
  setwd(path)

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
                  "Thumbs.db",
                  "ignore", "output"),
                ".gitignore")
  }

  # set the reminders delay and schedule the first reminder
  reminder_delay(reminder_delay)
  schedule_reminder()
  
  # initial commit
  # TODO: Call here to changes function to make first snapshot

}
