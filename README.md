
stow: simpler version control from R
====================================

[![build status](https://travis-ci.org/ropenscilabs/ozrepro.svg?branch=master)](https://travis-ci.org/ropenscilabs/ozrepro)

What does stow do?
------------------

Stow allows beginners with minimal programming experience to use version control. Version control is a framework that saves previous versions of your work as you develop your projects (Like 'Track changes' in MS Word). You can then easily look at previous versions, merge changes, and collaborate with others, but without the headache!

Stow uses git under the hood. Git is a popular version control system used by projects such as Android and ggplot2. Don't worry, you don't need to know any git to use stow!

How do I use it?
----------------

Here's a quick demo of how to use stow:

First, we need to create a new project (we only need to do this the first time we work with the project).

``` {.r}
library(stow)
create_repo("~/Desktop/myproject")
```

       started version control project at ~/Desktop/myproject

       reminders set for 60 minutes

We can tell the repository if there are files (e.g. large data output files) we don't want to keep records of

``` {.r}
ignore("output/results.csv")
```

and we can always change our minds later.

``` {.r}
unignore("output/results.csv")
```

With the project set up, we can work on our project as normal.

``` {.r}
# write some words to a file
cat("this is fun!\n", file = "README.md", append = TRUE)
```

We can then see which files have changed and make a record of the project, with a message to say what we did

``` {.r}
changes()
```

       1 file changed since the last record
       
         README.md:   1 line added

``` {.r}
record("added stuff to readme")
```

Now we can keep working on and adding files in this folder, and recording our changes regularly with `record()`.

It's easy to forget to record, so stow will automatically remind us if we have unrecorded changes and it's been some time since we last used stow. By default we'll be reminded after 60 minutes, but we can change that:

``` {.r}
remind_me(after = 30)
```

       reminders set for 30 minutes

If we make a change we don't want to keep or record, we can undo it and go back to our last record

``` {.r}
cat("I could do this all day.\n", file = "README.md", append = TRUE)
changes()
```

       1 file changed since the last record
       
         README.md:   1 line added

``` {.r}
scrub()
changes()
```

       no changes since the last record

We can look at all the records we've made so far

``` {.r}
timeline()
```

          (1) initial commit
           |  2017-10-31 21:17
           |
          (2) set up project structure
           |  2017-10-31 21:17
           |
          (3) added stuff to readme
              2017-10-31 21:17
       

and go back in time to recover the project at any one of those records - all of the files will be changed back to how they were at the time of that record

``` {.r}
go_to(2)
timeline()
```

          (1) initial commit
           |  2017-10-31 21:17
           |
          (2) set up project structure
              2017-10-31 21:17
            
          ...plus 1 future records (3 in total)

but don't worry, we can always go back to the future to recover our subsequent work.

``` {.r}
go_to(3)
```

If we want to start again from a previous record, we can bring that record to the end of our timeline. stow will change all of the files to how they were at the time of the record, but all the work we recorded since then will still be stored, just in case we need it later.

``` {.r}
retrieve(2)
timeline()
```

          (1) initial commit
           |  2017-10-31 21:17
           |
          (2) set up project structure
           |  2017-10-31 21:17
           |
          (3) added stuff to readme
           |  2017-10-31 21:17
           |
          (4) retrieving previous state from record 2
              2017-10-31 21:17
       

Installation
============

stow isn't on CRAN yet, but it can be installed from github

``` {.r}
# install.packages("remotes")
remotes::install_github("ropenscilabs/ozrepro")
```
