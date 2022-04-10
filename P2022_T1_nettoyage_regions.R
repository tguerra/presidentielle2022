library(readxl) # read excel files
library(stringr) # manipulate string of characters
library(LireMinInterieur) # transform electoral files
library(tidyverse) # the tidyverse...

pres_2022_R1_regions <- read_excel("./data-raw/XXXXX.xls", skip = 3, guess_max = 25, sheet = "Régions Tour 1")

pres_2022_R1_regions_cleaned <- lire(pres_2022_R1_regions, keep = c("Code de la région", "Libellé de la région", "Inscrits", "Abstentions", "Exprimés", "Blancs", "Nuls"), col = seq(18, 78, 6), gap = 2)

pres_2022_R1_regions_cleaned <- pres_2022_R1_regions_cleaned %>% 
  # put geographical codes in the right format
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
  select(CodeRégion = `Code de la région`, Région = `Libellé de la région`, Inscrits, Abstentions, Abstentions_ins, Votants, Votants_ins, Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, Exprimés, Exprimés_ins, Exprimés_vot, `LE PEN`:CHEMINADE, `LE PEN_ins`:CHEMINADE_exp) %>% 
  # nicer, more modern dataframe class
  as_tibble()

write_excel_csv(pres_2022_R1_regions_cleaned, path = "./P2022_Resultats_Région_T1.csv")