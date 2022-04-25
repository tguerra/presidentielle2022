library(readxl) # read excel files
library(stringr) # manipulate string of characters
library(LireMinInterieur) # transform electoral files
library(tidyverse) # the tidyverse...

pres_2022_R2_communes <- read_excel("./data-raw/2022/resultats-par-niveau-subcom-t2-france-entiere.xlsx", guess_max = 36000) %>% mutate(Inscrits = as.numeric(Inscrits))

pres_22_R2_communes_cleaned <- lire(pres_2022_R2_communes, 
                                    keep = c("Code du département", "Code de la commune", "Libellé de la commune", 
                                             "Inscrits", "Abstentions", "Exprimés", "Blancs", "Nuls"), 
                                    col = c(22, 29), 
                                    gap = 2)

pres_2022_R2_communes_cleaned <- pres_22_R2_communes_cleaned %>% 
  mutate(CodeDepartement = str_pad(string = `Code du département`, width = 2, side = "left", pad = "0")) %>% # has to be in a format like "02"
  mutate(CodeCommune = str_pad(string = `Code de la commune`, width = 3, side = "left", pad = "0")) %>% 
  mutate(CodeInsee = paste0(CodeDepartement, CodeCommune)) %>%  # unique commune ID
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
  select(CodeInsee, CodeDepartement, Commune = `Libellé de la commune`, Inscrits, Abstentions, Abstentions_ins, Votants, Votants_ins, 
         Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, Exprimés, Exprimés_ins, Exprimés_vot, 
         `MACRON`:`LE PEN`, `MACRON.ins`:`LE PEN.exp`) %>% 
  as_tibble()

readr::write_excel_csv(pres_2022_R2_communes_cleaned, path = "./data/P2022_Resultats_Communes_T2.csv")
rio::export(pres_2022_R2_communes_cleaned, file = "./data/P2022_Resultats_Communes_T2.xlsx")