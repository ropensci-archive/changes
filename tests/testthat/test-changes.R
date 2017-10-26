context("changes = git status")

test_path <- getwd()

test_that("changes() message: there\"s something untracked", {
  path <- tempfile(pattern = "tmpInitFolder-")
  dir.create(path)
  repo <- git2r::init(path)
  git2r::config(repo, user.name = "tmpUser", user.email = "tmpUser@example.com")
  write(a <- "a", file = file.path(path, "a"))
  setwd(repo@path)
  expect_message(changes(), "Untracked files:\n a")
  setwd(test_path)
})

test_that("changes() message: there\"s something staged that needs to be committed", {
  path <- tempfile(pattern = "tmpInitFolder-")
  dir.create(path)
  repo <- git2r::init(path)
  git2r::config(repo, user.name = "tmpUser", user.email = "tmpUser@example.com")
  write(a <- "a", file = file.path(path, "a"))
  setwd(repo@path)
  git2r::add(repo, "a")
  expect_message(changes(), "new file:\t a")
  setwd(test_path)
})

test_that("changes() message: clean history", {
  path <- tempfile(pattern = "tmpInitFolder-")
  dir.create(path)
  repo <- git2r::init(path)
  git2r::config(repo, user.name = "tmpUser", user.email = "tmpUser@example.com")
  write(a <- "a", file = file.path(path, "a"))
  git2r::add(repo, "a")
  invisible(git2r::commit(repo, message = "init"))
  setwd(repo@path)
  expect_message(changes(), "no changes since the last commit")
  setwd(test_path)
})

# test_that("status messages and returns NULL if not in git repo", {
#   path <- tmp_repo_path()
#   dir.create(path)
#   expect_true(dir.exists(path))
#   expect_false(is_in_repo(path))
#   expect_error(git_status(repo = path), "no git repo exists here")
# })

# test_that("status in empty repo", {
#   path <- init_tmp_repo()
#   expect_identical(git_status_check(repo = path), empty_status)
# })

# test_that("status reports new files", {
#   path <- init_tmp_repo()
#   write_file(c("staged", "untracked", "tracked", "ignored"), dir = path)
#   write("ignored", file.path(path, ".gitignore"))
#   git_commit(c(".gitignore", "tracked"), message = "init", repo = path)
#   git_add("staged", repo = path)
#   expect_status(git_status_check(repo = path),
#                 tibble::frame_data(
#                   ~status,     ~path,
#                   "staged",    "staged",
#                   "untracked", "untracked"
#                 ))
#   expect_status(git_status_check(repo = path, ls = TRUE),
#                 tibble::frame_data(
#                   ~status,     ~path,
#                   "staged",    "staged",
#                   "untracked", "untracked",
#                   "ignored",   "ignored",
#                   "tracked",   "tracked"
#                 ))
# })

# test_that("status reports deleted files", {
#   path <- init_tmp_repo()
#   files <- c("staged", "unstaged")
#   write_file(files, dir = path)
#   git_commit(files, message = "init", repo = path)
#   file.remove(file.path(path, files))
#   git_add("staged", repo = path)
#   expect_status(git_status_check(repo = path),
#                 tibble::frame_data(
#                   ~status,    ~path,      ~change,
#                   "staged",   "staged",   "deleted",
#                   "unstaged", "unstaged", "deleted"
#                 ))
# })

# test_that("status reports modified files", {
#   path <- init_tmp_repo()
#   files <- c("staged", "unstaged", "both")
#   write_file(files, dir = path)
#   git_commit(files, message = "init", repo = path)
#   lapply(files,
#          function(x) write("another line", file.path(path, x), append = TRUE))
#   git_add(c("staged", "both"), repo = path)
#   write("yet another line", file.path(path, "both"), append = TRUE)
#   expect_status(git_status_check(repo = path),
#                 tibble::frame_data(
#                   ~status,    ~path,      ~change,
#                   "staged",   "both",     "modified",
#                   "staged",   "staged",   "modified",
#                   "unstaged", "both",     "modified",
#                   "unstaged", "unstaged", "modified"
#                ))
# })

# test_that("status reports renamed files", {
#   path <- init_tmp_repo()
#   write_file("from", dir = path)
#   git_commit("from", message = "init", repo = path)
#   file.rename(file.path(path, "from"), file.path(path, "to"))
#   git_add(c("from", "to"), repo = path)
#   expect_status(git_status_check(repo = path),
#                 tibble::frame_data(
#                   ~status, ~ path,  ~change,        ~i,
#                   "staged", "from", "renamed_from", 1L,
#                   "staged", "to",   "renamed_to",   1L
#                 ))
# })

# test_that("status reports tracked unchanged + ignored files when all = TRUE", {
#   path <- init_tmp_repo()
#   write_file(c("tracked", "ignored"), dir = path)
#   write("ignored", file.path(path, ".gitignore"))
#   git_commit(c(".gitignore", "tracked"), message = "init", repo = path)
#   expect_status(git_status_check(repo = path, ls = TRUE),
#                 tibble::frame_data(
#                   ~status,   ~path,     ~change,
#                   "ignored", "ignored", "new",
#                   "tracked", "tracked", "none"
#                 ))
# })

# test_that("status when git2r::status returns nothing but all = TRUE", {
#   path <- init_tmp_repo()
#   write_file("a_file", dir = path)
#   git_commit("a_file", message = "init", repo = path)
#   expect_status(git_status_check(repo = path, ls = TRUE),
#                 tibble::frame_data(
#                   ~status,   ~path,    ~change,
#                   "tracked", "a_file", "none"
#                 ))
# })
