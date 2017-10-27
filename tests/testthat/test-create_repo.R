context("create = git init + project template")

test_path <- getwd()

# tempfile

# parse a path name, working directory after creation should be in that path or not in that path (depending on whether change_wd s TRUE)

# add_structure = TRUE ass various template folders and files -- check with dir() to see if they exist after creation

# .git folder with no commits

# create repo twice: check for warning messages

test_that("create_repo(): create repo in the same directory as getwd() with correct file structure", {
  path <- tempfile(pattern = "tmpInitFolder-")
  dir.create(path)
  path <- normalizePath(path)
  setwd(path)
  expect_message(create_repo(add_structure = TRUE, change_wd = FALSE), paste0("* Initialising git repository in:\n  ", path))
  expect_equal(getwd(), path)
  created_files  <-  c(".git/config", ".gitignore", "data/.keep", "data/README.md", "ignore/.keep", "output/.keep", "R/.keep", "R/utils.R", "README.md")
  for (j in seq_along(created_files)) {
  	print(paste0(created_files[j], ' exists'))
  	expect_true(file.exists(created_files[j]))
  }  
  setwd(test_path)
})
