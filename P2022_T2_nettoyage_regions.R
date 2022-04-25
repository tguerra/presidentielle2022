library(readxl) # read excel files
library(stringr) # manipulate string of characters
library(LireMinInterieur) # transform electoral files
library(tidyverse) # the tidyverse...

pres_2022_R2_regions <- read_excel("./data-raw/2022/resultats-par-niveau-reg-t2-france-entiere.xlsx", 
                                   guess_max = 25, sheet = 1) %>%
  mutate(Inscrits = as.numeric(Inscrits))

pres_2022_R2_regions_cleaned <- lire(pres_2022_R2_regions, 
                                     keep = c("Code de la région", "Libellé de la région", "Inscrits", "Abstentions", "Exprimés", "Blancs", "Nuls"), 
                                     col = c(19, 25), 
                                     gap = 2)

pres_2022_R2_regions_cleaned <- pres_2022_R2_regions_cleaned %>% 
  mutate(Votants = Inscrits - Abstentions) %>% 
  mutate(Votants_ins = Votants / Inscrits * 100) %>% 
  mutate(Abstentions_ins = Abstentions / Inscrits * 100) %>% 
  mutate(Blancs_ins = Blancs/ Inscrits * 100) %>% 
  mutate(Blancs_vot = Blancs / Votants * 100) %>% 
  mutate(Nuls_ins = Nuls / Inscrits * 100) %>% 
  mutate(Nuls_vot = Nuls / Votants * 100) %>% 
  mutate(Exprimés_ins = Exprimés / Inscrits * 100) %>% 
  mutate (Exprimés_vot = Exprimés / Votants * 100) %>% 
  mutate(across(c(Inscrits, Abstentions, Votants, Blancs, Nuls, Exprimés, `MACRON`:`LE PEN`), as.integer)) %>% 
  select(CodeRégion = `Code de la région`, Région = `Libellé de la région`, Inscrits, Abstentions, Abstentions_ins, Votants, Votants_ins, 
         Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, Exprimés, Exprimés_ins, Exprimés_vot, 
         `MACRON`:`LE PEN`, `MACRON.ins`:`LE PEN.exp`) %>% 
  as_tibble()

readr::write_excel_csv(pres_2022_R2_regions_cleaned, path = "./data/P2022_Resultats_Régions_T2.csv")
rio::export(pres_2022_R2_regions_cleaned, file = "./data/P2022_Resultats_Régions_T2.xlsx")
