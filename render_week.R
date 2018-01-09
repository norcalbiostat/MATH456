library(readxl)
library(dplyr)
library(stringr)
library(knitr)
library(rmarkdown)
library(lubridate)

raw <- read_excel("schedule_456.xlsx")
w <- 1
d1 <- raw$Date[w]
d2 <- d1 + duration(6, 'days')

render("weekly.Rmd", params=list(w=w, d1=d1, d2=d2))
