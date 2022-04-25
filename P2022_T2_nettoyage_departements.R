library(readxl) # read excel files
library(stringr) # manipulate string of characters
library(LireMinInterieur) # transform electoral files
library(tidyverse) # the tidyverse...

pres_2022_R2_departements <- read_excel("./data-raw/2022/resultats-par-niveau-dpt-t2-france-entiere.xlsx", 
                                        guess_max = 25, sheet = 1) %>% 
                                mutate(Inscrits = as.numeric(Inscrits))

pres_2022_R2_departements_cleaned <- lire(pres_2022_R2_departements, 
                                          #keep = c(1, 2, 4, 5, 9, 12, 15),
                                          keep = c("Code du département", "Libellé du département", "Inscrits", "Abstentions", "Blancs", "Nuls", "Exprimés"), 
                                          col = c(19,25), gap = 2)

pres_2022_R2_departements_cleaned <- pres_2022_R2_departements_cleaned %>% 
  mutate(CodeDépartement = str_pad(`Code du département`, 2, "left", "0")) %>% 
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
  select(CodeDépartement, Département = `Libellé du département`, Inscrits, Abstentions, Abstentions_ins, Votants, Votants_ins, 
         Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, Exprimés, Exprimés_ins, Exprimés_vot, 
         `MACRON`:`LE PEN`, `MACRON.ins`:`LE PEN.exp`) %>% 
  as_tibble()

readr::write_excel_csv(pres_2022_R2_departements_cleaned, path = "./data/P2022_Resultats_Départements_T2.csv")
rio::export(pres_2022_R2_departements_cleaned, file = "./data/P2022_Resultats_Départements_T2.xlsx")


