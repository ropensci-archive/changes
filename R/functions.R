# helpers
some <- function (x) {
  length(x) > 0
}

none <- function (x) {
  !some(x)
}

one <- function (x) {
  length(x) == 1
}

# nicely format the number of file changes or line additions / deletions
paste_num <- function (number, item, event, fallback = NULL) {
  
  if (number == 0) {
    text <- fallback
  } else if (number == 1) {
    text <- sprintf("%i %s %s", number, item, event)
  } else {
    text <- sprintf("%i %ss %s", number, item, event)
  }
  
  text
}

ready <- function () {
  some(cache$repo)
}

# call this at the top of all exported functions. If the repo isn't set up, try
# to find it here & error appropriately
check_ready <- function () {
  if (!ready()) {
    set_repo(verbose = FALSE)
  }
}

repo_path <- function () {
  check_ready()
  dirname(cache$repo@path)
}

# set up the user's config file
set_config <- function () {
  # look in the project directory then home directory or R_profile
  invisible(NULL)
}

# find and set the repository
set_repo <- function (path = ".", event = c("error", "warn", "message"), verbose = TRUE) {
  
  event <- match.arg(event)
  
  result <- tryCatch(git2r::repository(path, discover = TRUE),
                  error = function (e) e)
  
  if (inherits(result, "error")) {
    
    msg <- paste("could not find a git repository in",
                 normalizePath(path),
                 "\nuse setwd() to move to a directory with a git repository")
    
    switch (event,
            error = stop(msg, call. = FALSE),
            warn = warning(msg, call. = FALSE),
            message = message(msg))
    
  } else {
    
    cache$repo <- result
    
    if (verbose) {
      cat("using git repository at", repo_path())
    }
    
    
  }
  
  invisible(NULL)
  
}

# format the line changes for each modified file
format_change <- function (change) {
  both <- change$add > 0 & change$del > 0
  paste0("  ",
         paste_num(change$add, "line", "added"),
         ifelse(both, ",  ", ""),
         paste_num(change$del, "line", "deleted"))
}

# format all of the line changes
format_changes <- function (changed, file_names = TRUE) {
  
  line_changes <- format_change(changed)
  staged <- ifelse(changed$staged, "   (staged)", "")
  
  cols <- data.frame(line_changes, staged)
  
  if (file_names) {
    cols <- data.frame(paste0(changed$file, ":"), cols)
  }
  
  names(cols) <- NULL
  table <- capture.output(print(cols, row.names = FALSE, right = FALSE))
  paste(table[-1], collapse = "\n")
  
}

# format a diff as a dataframe
diff_df <- function (staged = FALSE) {
  
  diff <- diff(cache$repo, index = staged)
  diff_list <- git2r:::lines_per_file(diff)
  
  df_list <- lapply(diff_list,
                    as.data.frame,
                    stringsAsFactors = FALSE)
  df <- do.call(rbind, df_list)
  
  # if it was empty, return an empty dataframe with the right columns
  if (none(df)) {
    df <- data.frame(file = "", add = 0, del = 0)[0, ]
  }
  
  df
}

quotes <- function (x) {
  paste0('"', x, '"')
}

quote_list <- function (x) {
  paste(quotes(x), collapse = ", ")
}

# nicer summary of what has changed, somewhere between status and diff
changes <- function (files = NULL) {
  
  check_ready()
  
  # numbers of line changes for each changed file
  # find out whether the changes have been staged to commit
  unstaged <- diff_df(staged = FALSE)
  staged <- diff_df(staged = TRUE)
  changed <- rbind(unstaged, staged)
  changed$staged <- changed$file %in% staged$file
  
  # restrict changes to specific files and omit the headline
  if (some(files)) {
    
    # standardise paths
    files <- normalizePath(files, mustWork = FALSE)
    files_exist <- vapply(files, file.exists, FUN.VALUE = TRUE)
    
    if (!all(files_exist)) {
      stop ("cannot find the following files: ",
            quote_list(files[!files_exist]),
            call. = FALSE)
    }

    files <- gsub(file.path(repo_path(), ""),
                  "", files)
    
    changed <- changed[changed$file %in% files, ]
    
  }
  
  headline <- paste_num(nrow(changed),
                        "file",
                        "changed since the last commit:\n\n",
                        fallback = "no changes since the last commit")
  
  if (nrow(changed) > 0) {
    
    # if the user asked for only one file, and it changed, omit the headline and
    # the file name
    line_changes <- format_changes(changed,
                                   file_names = !one(files))  
    
    if (one(files)) {
      headline <- NULL
    }
    
  } else {
    
    line_changes <- NULL
    
  }
  
  cat(headline, line_changes)
  
}

check_message <- function (message) {
  
  if (none(message)) {
    message("commiting with no message, ",
            "you can use amend_message() to add a message")
    message <- "-"
  }
  
  message
  
}

# make these friendlier!
stage <- function (files) {
  check_ready()
  git2r::add(cache$repo, files)
}

commit <- function (message = NULL) {
  check_ready()
  git2r::commit(cache$repo, message = check_message(message))
}

commit_all <- function (message = NULL) {
  check_ready()
  git2r::commit(cache$repo, message = message, all = TRUE)
}

print.commit_list <- function (x, ...) {
  display <- capture.output(. <- lapply(x, show))
  cat(display, sep = "\n")
}

head.commit_list <- function (x, ...) {
  x <- utils:::head.default(x, ...)
  class(x) <- "commit_list"
  x
}

tail.commit_list <- function (x, ...) {
  x <- utils:::tail.default(x, ...)
  class(x) <- "commit_list"
  x
}

commits <- function () {
  commit_list <- git2r::commits(cache$repo)
  class(commit_list) <- "commit_list"
  commit_list
}

checkout_commit <- function (commit) {
  
}

print.branch_list <- function (x, ...) {
  display <- capture.output(. <- lapply(x, show))
  df <- data.frame(names(x), display,
                   stringsAsFactors = FALSE)
  names(df) <- NULL
  display <- capture.output(print(df, right = FALSE, row.names = FALSE))
  cat(display[-1], sep = "\n")
}

# want to list names and URLs, not branches
remote_repos <- function () {
  check_ready()
  names <- git2r::remotes(cache$repo)
  urls <- git2r::remote_url(cache$repo)
  names(urls) <- names
  urls
}

branches <- function (include_remote = FALSE) {
  
  check_ready()
  branch_list <- git2r::branches(cache$repo)
  
  if (!include_remote) {
    types <- vapply(branch_list, slot, "type", FUN.VALUE = 1)
    branch_list <- branch_list[types == 1]  
  }
  
  class(branch_list) <- "branch_list"
  branch_list
}

checkout_branch <- function (branch) {
  
  check_ready()
  branch_list <- branches()
  branch_names <- names(branch_list)
  
  if (!branch %in% branch_names) {
    stop (quotes(branch), " is not a valid local branch. ",
          "Valid branches are: ", quote_list(branch_names),
           call. = FALSE)
  }
  target <- branch_list[[branch]]
  git2r::checkout(cache$repo, branch)
  
}

set_reminder <- function(minutes) {
  # convert minutes to seconds of reminder delay in seconds in cache
  cache[["reminder_delay"]] <- minutes * 60
}

# This needs to be called at the tope of every stow function,
# as well as in the .onLoad of the package
schedule_reminder <- function() {
  # get the reminder delay from cache
  delay <- cache[["reminder_delay"]]
  later::later(function() { print( changes())}, delay=delay)
}

