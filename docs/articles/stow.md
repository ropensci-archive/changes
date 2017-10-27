---
title: "Get Started!"
author: "Damjan and Anikó"
date: "`r Sys.Date()`"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Vignette Title}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---

##Four easy steps to success!

1. Start a new repository (or download an existing one). 
What is a repository, you ask? A repository is a folder in which you store your project. The folder saves previous versions of your project and allows you to easily access them. 
  For example:

``` {r}
#Create a brand new repository in a new or existing local project. Defaults to your current working directory
create_repo("~/Desktop/myproject")

#Download an existing repository from online
download_repo("url")
```
  ![](README_files/Repo_cartoon.png)
  
2. Make some changes: work on your project as normal. Don't forget to save your changes. 
  [insert picture/code here]


3. Review and visualise the changes you have made to your project.
  [insert picture here]

``` 
changes()
```

4. Once you are happy with your changes, record them in your repository. Your repository records a snapshot of your current project, adding it to the list of previous versions.   
  [insert picture here]

```{r}
# automatically performs all of the steps to record your changes in your repository
record()

# two-step version of the same process that gives you a bit more control
stage()
commit()

```


## Fixing stuff, moving back, recording stuff

5. Look at your history of records

```{r}
# print a history of your past records in your console:
print(gethistory())

# ...or depict it in an [interactive?] plot!
plot(gethistory())

```


6.  Fixing stuff!

```{r}   
# Made a mistake? Return your project to your last record:
scrub()

# ...or to another previous record of your choice:
retrieve(recordid)

# take a peek into any older record 
go_to(recordid)

```

7. Saving stuff online
When you work on your computer, you are usually working in what is called the 'local' environment. The local environment encompasses anything housed on your computer's hard drive. If you want to collaborate or make your work available to others, it's a good idea to put it 'in the cloud,' in other words, in a 'remote' repository. These are housed on a server somewhere else in the world, and can be accessed online. This can also provide additional safety in case you lose your work in your local environment. 
 
```{r}
# Synchronize your work with a new or existing remote repository
sync("url")
```
   


# An example workflow

```{r}
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
record()

# continue to work on you project as normal 

# review and record your changes
changes("myscript.R")
record()

# Remove the changes you have made since your last commit 
scrub()


```

-----

Vignettes are long form documentation commonly included in packages. Because they are part of the distribution of the package, they need to be as compact as possible. The `html_vignette` output type provides a custom style sheet (and tweaks some options) to ensure that the resulting html is as small as possible. The `html_vignette` format:

- Never uses retina figures
- Has a smaller default figure size
- Uses a custom CSS stylesheet instead of the default Twitter Bootstrap style

## Vignette Info

Note the various macros within the `vignette` section of the metadata block above. These are required in order to instruct R how to build the vignette. Note that you should change the `title` field and the `\VignetteIndexEntry` to match the title of your vignette.

## Styles

The `html_vignette` template includes a basic CSS theme. To override this theme you can specify your own CSS in the document metadata as follows:

    output: 
      rmarkdown::html_vignette:
        css: mystyles.css

## Figures

The figure sizes have been customised so that you can easily put two images side-by-side. 

```{r, fig.show='hold'}
plot(1:10)
plot(10:1)
```

You can enable figure captions by `fig_caption: yes` in YAML:

    output:
      rmarkdown::html_vignette:
        fig_caption: yes

Then you can use the chunk option `fig.cap = "Your figure caption."` in **knitr**.

## More Examples

You can write math expressions, e.g. $Y = X\beta + \epsilon$, footnotes^[A footnote here.], and tables, e.g. using `knitr::kable()`.

```{r, echo=FALSE, results='asis'}
knitr::kable(head(mtcars, 10))
```

Also a quote using `>`:

> "He who gives up [code] safety for [code] speed deserves neither."
([via](https://twitter.com/hadleywickham/status/504368538874703872))
