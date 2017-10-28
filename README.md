# simpler version control from R

[![build status](https://travis-ci.org/ropenscilabs/ozrepro.svg?branch=master)](https://travis-ci.org/ropenscilabs/ozrepro)

## What does stow do?

Version control is hard

![](vignettes/monkeys.jpg)

Stow allows beginners with minimal programming experience to use version control. Version control is a framework that saves previous versions of your work as you develop your projects (Like 'Track changes' in MS Word). You can then easily look at previous versions, merge changes, and collaborate with others, but without the headache! 

Stow uses git under the hood. Git is a popular version control system used by projects such as Android and ggplot2. Don't worry, you don't need to know any git to use stow!

# Installation

stow can be installed from github:

```
# install.packages("remotes")
remotes::install_github("ropenscilabs/ozrepro")
```

Go to the website for more details! [https://ropenscilabs.github.io/ozrepro/]()




##Four easy steps to success!

1. Start a new repository (or download an existing one). 
What is a repository, you ask? A repository is a folder in which you store your project. The folder saves previous versions of your project and allows you to easily access them. 
  For example:

```
#Create a brand new repository in a new or existing local project. Defaults to your current working directory
create_repo("~/Desktop/myproject")

#Download an existing repository from online
download_repo("url")
```
![](vignettes/Repo_cartoon.png)
  
2. Make some changes: work on your project as normal. Don't forget to save your changes. 
  [insert picture/code here]


3. Review and visualise the changes you have made to your project.
  [insert picture here]

```
changes()
```

4. Once you are happy with your changes, record them in your repository. Your repository records a snapshot of your current project, adding it to the list of previous versions.   
  [insert picture here]

```
# automatically performs all of the steps to record your changes in your repository
record()

```


## Fixing stuff, moving back, recording stuff

5. Look at your history of records

```
# print a history of your past records in your console:
timeline()

# ...or depict it in a plot!
plot(timeline())  # (not yet implemented)
```


6.  Fixing stuff!

```
# Made a mistake? Return your project to your last record:
scrub()  # (not yet implemented)

# ...or to another previous record of your choice:
retrieve(recordid)

# take a peek into any older record 
go_to(recordid)

```

7. Saving stuff online
When you work on your computer, you are usually working in what is called the 'local' environment. The local environment encompasses anything housed on your computer's hard drive. If you want to collaborate or make your work available to others, it's a good idea to put it 'in the cloud,' in other words, in a 'remote' repository. These are housed on a server somewhere else in the world, and can be accessed online. This can also provide additional safety in case you lose your work in your local environment. 
 
```
# Synchronize your work with a new or existing remote repository
sync("url")  # (not yet implemented)
```
   


# An example workflow

```
setwd("~/Desktop/myproject")

# make a new repository in your working directory
create_repo()

# tell the repository not to track your large data output files
ignore("*.csv")

# set reminders to record your changes every 15 minutes (this automatically defaults to 30 minutes)
reminder_delay(minutes = 15)

# work on you project as normal 

# review your changes. By default it will show all changed files, but you can specify which file to show. 
changes("myscript.R") 

# record changes, defaults to all changes.
record(message="Added a new analysis to myscript.R")

# continue to work on you project as normal 

# review and record your changes
changes("myscript.R")
record()

# Remove the changes you have made since your last commit 
scrub()

# Look at your history of commits
timeline()
```


