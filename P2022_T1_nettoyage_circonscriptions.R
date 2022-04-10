library(readxl) # read excel files
library(stringr) # manipulate string of characters
library(LireMinInterieur) # transform electoral files
library(tidyverse) # the tidyverse...

pres_2022_R1_circonscriptions <- read_excel("./data-raw/XXX.xls", skip = 3, guess_max = 600, sheet = "Circo. Leg. Tour 1")

pres_2022_R1_circonscriptions_cleaned <- lire(pres_2022_R1_circonscriptions, keep = c("Code du département", "Libellé du département", "Code de la circonscription", "Libellé de la circonscription", "Inscrits", "Abstentions", "Exprimés", "Blancs", "Nuls"), col = seq(21, 91, 7), gap = 2)

pres_2017_R1_circonscriptions_cleaned <- pres_2022_R1_circonscriptions_cleaned %>% 
  # put geographical codes in the right format
  mutate(CodeDépartement = str_pad(`Code du département`, 2, "left", "0")) %>% 
  mutate(NumeroCirco = str_pad(`Code de la circonscription`, 2, "left", "0")) %>%
  mutate(CodeCirco = paste0(CodeDépartement, NumeroCirco)) %>% 
  mutate(Votants = Inscrits - Abstentions) %>% 
  mutate(Votants_ins = Votants / Inscrits * 100) %>% 
  mutate(Abstentions_ins = Abstentions / Inscrits * 100) %>% 
  mutate(Blancs_ins = Blancs/ Inscrits * 100) %>% 
  mutate(Blancs_vot = Blancs / Votants * 100) %>% 
  mutate(Nuls_ins = Nuls / Inscrits * 100) %>% 
  mutate(Nuls_vot = Nuls / Votants * 100) %>% 
  mutate(Exprimés_ins = Exprimés / Inscrits * 100) %>% 
  mutate(Exprimés_vot = Exprimés / Votants * 100) %>% 
  # specify integers %>% 
  mutate(across(c(Inscrits, Abstentions, Votants, Blancs, Nuls, Exprimés, `LE PEN`:CHEMINADE), as.integer)) %>% 
  # reorder
  select(CodeCirco, Département = `Libellé du département`, NumeroCirco, Circonscription = `Libellé de la circonscription`, Inscrits, Abstentions, Abstentions_ins, Votants, Votants_ins, Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, Exprimés, Exprimés_ins, Exprimés_vot, `LE PEN`:CHEMINADE, `LE PEN_ins`:CHEMINADE_exp) %>% 
  # nicer, more modern dataframe class
  as_tibble()

write_excel_csv(pres_2017_R1_circonscriptions_cleaned, path = "./data/P2022_Resultats_Circonscription_T1.csv")