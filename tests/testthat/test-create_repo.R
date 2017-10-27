context("create = git init + project template")
library(stow)

test_path <- getwd()

# tempfile

# parse a path name, working directory after creation should be in that path or not in that path (depending on whether change_wd s TRUE)

# add_structure = TRUE ass various template folders and files -- check with dir() to see if they exist after creation

# .git folder with no commits

test_path <- getwd()

test_that("create_repo(): create repo in the same directory as getwd()", {
  path <- tempfile(pattern = "tmpInitFolder-")
  dir.create(path)
  setwd(path)
  create_repo(path, add_structure = TRUE, change_wd = FALSE)
  git2r::config(repo, user.name = "tmpUser", user.email = "tmpUser@example.com")
  write(a <- "a", file = file.path(path, "a"))
  
  expect_message(changes(), "Untracked files:\n a")
  setwd(test_path)
})
