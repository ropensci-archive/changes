stow: simpler version control from R
====================================

[![build status](https://travis-ci.org/ropenscilabs/ozrepro.svg?branch=master)](https://travis-ci.org/ropenscilabs/ozrepro)

What does stow do?
------------------

Stow allows beginners with minimal programming experience to use version control. Version control is a framework that saves previous versions of your work as you develop your projects (Like 'Track changes' in MS Word). You can then easily look at previous versions, merge changes, and collaborate with others, but without the headache!

Stow uses git under the hood. Git is a popular version control system used by projects such as Android and ggplot2. Don't worry, you don't need to know any git to use stow!

Demonstration
=============

Here's a quick demo of how to use stow:

``` r
# load the package
library(stow)
```

``` r
# make a new repository in your working directory
# (you only need to do this the first time you work with the project)
create_repo("~/Desktop/myproject")
```

    ## started version control project at ~/Desktop/myproject

    ## reminders set for 60 minutes

``` r
# tell the repository if there are files (e.g. large data output files) you
# don't want to keep copies of
ignore("output/results.csv")
```

``` r
# (you can always change your mind)
unignore("output/results.csv")
```

``` r
# work on your project as normal, and save your changes
cat("this is fun!\n", file = "README.md", append = TRUE)
```

``` r
# see which files have changed
changes()
```

    ## 1 file changed since the last record
    ## 
    ##   README.md:   1 line added

``` r
# record the changes you have made
record("added stuff to readme")
```

you can keep working on and adding files in this folder, and recording your changes regularly with record()

``` r
# If you make a change you don't want to keep, you can undo them and go back to
# your last record with scrub()
cat("I could do this all day.\n", file = "README.md", append = TRUE)
changes()
```

    ## 1 file changed since the last record
    ## 
    ##   README.md:   1 line added

``` r
scrub()
changes()
```

    ## no changes since the last record

``` r
# you can look at your history of records...
timeline()
```

    ##    (1) initial commit
    ##     |  2017-10-30 02:13
    ##     |
    ##    (2) set up project structure
    ##     |  2017-10-30 02:13
    ##     |
    ##    (3) added stuff to readme
    ##        2017-10-30 02:13
    ## 

``` r
# ... and go back in time to recover the project at any one of your records
go_to(2)
# all of the files will have been changed back to how they were at record 2
timeline()
```

    ##    (1) initial commit
    ##     |  2017-10-30 02:13
    ##     |
    ##    (2) set up project structure
    ##        2017-10-30 02:13
    ##      
    ##    ...plus 1 future records (3 in total)

``` r
# we can always go back to the future
go_to(3)
```

``` r
# if you want to start again from a previous record, you can do retrieve() to
# bring that record to the end of your timeline 
retrieve(2)
# all the work you recorded since then will still be stored, in case you need it
# later
```

Installation
============

stow can be installed from github:

``` r
# install.packages("remotes")
remotes::install_github("ropenscilabs/ozrepro")
```
