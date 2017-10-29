# set up a cache
.cache <- new.env()
.cache$reminder_delay <- 60 # default to hourly notifications
.cache$reminder_paused <- TRUE
