library(readxl) # read excel files
library(stringr) # manipulate string of characters
library(LireMinInterieur) # transform electoral files
library(tidyverse) # the tidyverse...

pres_2022_R1_cantons <- read_excel("./data-raw/.xls", skip = 3, guess_max = 2100, sheet = "Canton Tour 1")

pres_2022_R1_cantons_cleaned <- lire(pres_2022_R1_cantons, keep = c("Code du département", "Libellé du département", "Code du canton", "Libellé du canton", "Inscrits", "Abstentions", "Exprimés", "Blancs", "Nuls"), col = seq(21, 91, 7), gap = 2)

pres_2022_R1_cantons_cleaned <- pres_2022_R1_cantons_cleaned %>% 
  # put geographical codes in the right format
  mutate(CodeDépartement = str_pad(`Code du département`, 2, "left", "0")) %>% 
  mutate(NumeroCanton = str_pad(`Code du canton`, 2, "left", "0")) %>%
  mutate(CodeCanton = paste0(CodeDépartement, NumeroCanton)) %>% 
  mutate(Votants = Inscrits - Abstentions) %>% 
  mutate(Votants_ins = Votants / Inscrits * 100) %>% 
  mutate(Abstentions_ins = Abstentions / Inscrits * 100) %>% 
  mutate(Blancs_ins = Blancs/ Inscrits * 100) %>% 
  mutate(Blancs_vot = Blancs / Votants * 100) %>% 
  mutate(Nuls_ins = Nuls / Inscrits * 100) %>% 
  mutate(Nuls_vot = Nuls / Votants * 100) %>% 
  mutate(Exprimés_ins = Exprimés / Inscrits * 100) %>% 
  mutate (Exprimés_vot = Exprimés / Votants * 100) %>% 
  # specify integers %>% 
  mutate(across(c(Inscrits, Abstentions, Votants, Blancs, Nuls, Exprimés, `LE PEN`:CHEMINADE), as.integer)) %>% 
  # reorder
  select(CodeCanton, CodeDépartement, Département = `Libellé du département`, NumeroCanton, Canton = `Libellé du canton`, Inscrits, Abstentions, Abstentions_ins, Votants, Votants_ins, Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, Exprimés, Exprimés_ins, Exprimés_vot, `LE PEN`:CHEMINADE, `LE PEN_ins`:CHEMINADE_exp) %>% 
  # nicer, more modern dataframe class
  as_tibble()

write_excel_csv(pres_2022_R1_cantons_cleaned, path = "./P2022_Resultats_Cantons_T1.csv")