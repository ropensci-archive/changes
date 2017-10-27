context("create = git init + project template")

test_path <- getwd()

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

test_that("create_repo(): create repo in a new directory different from getwd() with correct file structure", {
  path <- tempfile(pattern = "tmpInitFolder-")
  dir.create(path)
  path <- normalizePath(path)
  expect_message(create_repo(path, add_structure = TRUE, change_wd = TRUE), paste0("* Initialising git repository in:\n  ", path))
  expect_equal(getwd(), path)
  expect_false(getwd() == test_path)
  created_files  <-  c(".git/config", ".gitignore", "data/.keep", "data/README.md", "ignore/.keep", "output/.keep", "R/.keep", "R/utils.R", "README.md")
  for (j in seq_along(created_files)) {
    print(paste0(created_files[j], ' exists'))
    expect_true(file.exists(created_files[j]))
  }  
  setwd(test_path)
})

test_that("create_repo(): create repo in a new directory different from getwd() with no file structure", {
  path <- tempfile(pattern = "tmpInitFolder-")
  dir.create(path)
  path <- normalizePath(path)
  expect_message(create_repo(path, add_structure = FALSE, change_wd = TRUE), paste0("* Initialising git repository in:\n  ", path))
  expect_true(file.exists(".git/config"))
  created_files  <-  c(".gitignore", "data/.keep", "data/README.md", "ignore/.keep", "output/.keep", "R/.keep", "R/utils.R", "README.md")
  for (j in seq_along(created_files)) {
    print(paste0(created_files[j], ' exists'))
    expect_false(file.exists(created_files[j]))
  }  
  setwd(test_path)
})

test_that("create_repo(): create repo in a new directory different from getwd() with no file structure, no commits", {
  path <- tempfile(pattern = "tmpInitFolder-")
  dir.create(path)
  path <- normalizePath(path)
  expect_message(create_repo(path, add_structure = FALSE, change_wd = TRUE), paste0("* Initialising git repository in:\n  ", path))
  browser()
  system('git status')
  .cache  <-  stow:::.cache
  .cache$repo  <- NULL
  expect_message(changes(), "no changes since the last commit")
 
  # .git folder with no commits
  setwd(test_path)
})

# create repo twice: check for warning messages
