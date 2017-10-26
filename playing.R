#############
# oxygenizing
#############
rm(list = ls())
library(roxygen2)
roxygen2::roxygenise(clean = TRUE)


# # full commit dataframe:
# as(cache$repo, "data.frame")

# plain text explanation of what has changed, and what is staged
# grit: a friendlier version control interface for R

library (git2r)

# repo <- clone("https://github.com/goldingn/default.git", "./default")
# repo <- repository("default")

# cache a cache environment in the package namespace
cache <- new.env()
cache$repo <- NULL
cache$config <- NULL

changes()
changes("default.R")

stage("default.R")
commit()

amend_message("removed whitespace")

branches()
# master [f4f841] (Local) (HEAD) master
remote_repos()
# origin https://github.com/goldingn/default.git




# have a default remote, or set of remotes?
# push()

# fetch changes from remotes
# fetch()

# provide nice messages and guidance for merge conflicts
# pull()

# fetch from all (or named) remotes, check whether a merge is possible without
# conflicts, and explain what the issue is in plain english, and push to al all
# (or named) remotes
# sync()

# checkout()
