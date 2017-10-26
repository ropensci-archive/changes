# simpler version control from R

## What does stow do?

Stow allows beginners with minimal programming experience to use version control. Version control is a framework that saves previous versions of your work as you develop your projects (Like 'Track changes' in MS Word). You can then easily look at previous versions, merge changes, and collaborate with others, but without the headache! 

Stow uses git under the hood. Git is a popular version control system used by projects such as Android and ggplot2. Don't worry, you don't need to know any git to use stow!


## Get started!

Three steps to success!

1. Start a new repository (or download an existing one). 
What is a repository, you ask? A repository is a folder in which you store your project. The folder saves previous versions of your project and allows you to easily access them. 
  For example:
  [insert picture/code here]
  
2. Make some changes: work on your project as normal. Don't forget to save your changes. 
  [insert picture/code here]

3. Use stow to review and visualise the changes you have made to your project.
  [insert picture/code here]

4. Once you are happy with your changes, record them in your repository. Your repository records a snapshot of your current project, adding it to the list of previous versions.   
  [insert picture/code here]


## More stuff! (Fixing stuff, moving back, saving stuff)

5.  Fixing stuff!
   - go back to previous versions
6. Saving stuff online (non-local!!)
   - Must define local vs remote environments 
   - Push/Sync functions

# Installation

This package depends on the [githug](https://github.com/jennybc/githug) package. ou can install githug from github with:

```
# install.packages("devtools")
devtools::install_github("jennybc/githug")
```

