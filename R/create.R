
create_repo <- function(path = getwd(), add_dirs = TRUE, change_dir = TRUE){

  # Create a new repo
  # Possibly want more specific error messages than exist here?
  gr <- githug::git_init(path)

  # record current path
  old_dir <- getwd()
  if(!change_dir)
    on.exit(setwd(old_dir))

  # go into repo and setup directory structure
  setwd(gr)

  if(add_dirs){
    dir.create("data", TRUE, FALSE)
    dir.create("output", TRUE, FALSE)
    dir.create("ignore", TRUE, FALSE)
    dir.create("R", TRUE, FALSE)

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

  # initial commit
  # TODO: Call here to changes function to make first snapshot

}
