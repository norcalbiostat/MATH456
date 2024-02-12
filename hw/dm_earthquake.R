# data management for the Earthquake data
# last updated: 2024-02-11

library(tidyverse)

raw <- read.delim(here::here("data/Earthq.txt"))

eq <- raw %>% janitor::clean_names()

# rent/own (V449) is numeric, with 9's for refuse to answer. so is a lot of other variables. 
# `newethn` and `rage` have . for missing... so probably a character not numeric. 
# EVERYTHING IS NUMERIC, when sex, eth should be categorical. 
# they coded 1=yes and 5=no. (WHO DOES THAT??)


eq$rage[eq$rage=="."] <- NA
eq$age <- as.numeric(eq$rage)
eq$newethn[eq$newethn=="."] <- NA
eq$newethn <- as.numeric(as.character(eq$newethn))
eq$newethn[eq$newethn==6] <-3
eq$eth <- factor(eq$newethn, labels=c("White", "Hispanic", "AmInd/Oth", "Asian/PI", "Black"))
eq$v449[eq$v449>5] <- NA
eq$own <- ifelse(eq$v449==1, 1, 0)
eq$w238[eq$w238>5] <- NA
eq$emo.inj <- ifelse(eq$w238==1, 1, 0)
eq$female <- ifelse(eq$rsex==5, 1,0)
eq$v127[eq$v127>5] <- NA
eq$house.dmg <- ifelse(eq$v127==1, 1,0)
eq$w220[eq$w220>5] <- NA
eq$phys.inj <- ifelse(eq$w220==1, 1, 0)
eq$v461[eq$v461>30] <- NA
eq$yrs.edu <- eq$v461
eq$v455[eq$v455>6] <-NA
eq$marital <- factor(eq$v455, labels=c("Never Married", "Married", "Cohabitate", "Divorced", 
                                       "Separated", "Widowed"))
eq$v173[eq$v173>5] <- NA
eq$evac <- ifelse(eq$v173==1, 1,0)

# Save 

save(eq, file = here::here("data/eq_clean.Rdata"))
