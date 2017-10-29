#' View Changes in Files under Version Control.
#'
#' TODO Describe this better.
#'
#' @param files an optional character vector of files for which you want to see
#'   the changes
#' @param silent if TRUE does not issue a message
#'
#' @return number of changes
#' @export
changes <- function (files = NULL, silent = FALSE) { 
  
  repo <- get_repo()
  
  # numbers of line changes for each changed file
  # find out whether the changes have been staged to commit
  unstaged <- diff_df(repo, staged = FALSE)
  staged <- diff_df(repo, staged = TRUE)
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
    
    repo_path <- repo@path
    files <- gsub(file.path(repo_path, ""),
                  "", files)
    
    changed <- changed[changed$file %in% files, ]
    
  }
  
  headline <- paste_num(nrow(changed),
                        "file",
                        "changed since the last record\n\n",
                        fallback = "no changes since the last record")
  
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
  
  if (!silent) {
    cat (headline, line_changes)
    return (invisible(NULL))
  } else {
    return (nrow(changed))
  }
}

# format the line changes for each modified file
format_change <- function (change) {
  both <- change$add > 0 & change$del > 0
  paste0("  ",
         paste_num(change$add, "line", "added"),
         ifelse(both, ",  ", ""),
         paste_num(change$del, "line", "deleted"))
}

#' @noRd
#' @importFrom utils capture.output
format_changes <- function (changed, file_names = TRUE) {
  
  # can't apply here?
  line_changes <- c()
  for (i in seq_len(nrow(changed))) {
    line_changes <- c(line_changes, format_change(changed[i, ]))
  }
  
  cols <- data.frame(line_changes)
  
  if (file_names) {
    cols <- data.frame(paste0(changed$file, ":"), cols)
  }
  
  names(cols) <- NULL
  table <- capture.output(print(cols, row.names = FALSE, right = FALSE))
  paste(table[-1], collapse = "\n")
  
}

# format a diff as a dataframe
diff_df <- function (repo, staged = FALSE) {
  
  diff <- git2r::diff(repo, index = staged)
  file_changes <- lapply(diff@files, file_line_changes)
  df <- do.call(rbind, file_changes)
  
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


file_line_changes <- function (file) {
  
  # collapse all lines in the file
  lines <- unlist(lapply(file@hunks, slot, "lines"))
  
  # find out whether each has changed
  origins <- vapply(lines, slot, "origin", FUN.VALUE = 1)
  
  # count the number of additions/deletions per line
  additions <- vapply(lines[origins == 43],
                      slot, "num_lines",
                      FUN.VALUE = 1)
  
  deletions <- vapply(lines[origins == 45],
                      slot, "num_lines",
                      FUN.VALUE = 1)
  
  data.frame(file = file@new_file,
             add = sum(additions),
             del = sum(deletions))
  
}
