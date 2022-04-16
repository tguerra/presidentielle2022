library(readxl) # read excel files
library(stringr) # manipulate string of characters
library(LireMinInterieur) # transform electoral files
library(tidyverse) # the tidyverse...

pres_2022_R1_circonscriptions <- read_excel("./data-raw/2022/resultats-par-niveau-cirlg-t1-france-entiere.xlsx", 
                                            guess_max = 600, sheet = 1) %>%
                                mutate(Inscrits = as.numeric(Inscrits))

pres_2022_R1_circonscriptions_cleaned <- lire(pres_2022_R1_circonscriptions, 
                                              keep = c(1, 2, 3, 4, 6, 7, 11, 14, 17),
                                              #keep.names = c("Code du département", "Libellé du département", "Code de la circonscription", "Libellé de la circonscription", 
                                              #         "Inscrits", "Abstentions", "Exprimés", "Blancs", "Nuls"), 
                                              col = c(seq(22, 99, 7)), gap = 2)

pres_2022_R1_circonscriptions_cleaned <- pres_2022_R1_circonscriptions_cleaned %>% 
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
  mutate(across(c(Inscrits, Abstentions, Votants, Blancs, Nuls, Exprimés, `ARTHAUD`:`DUPONT-AIGNAN`), as.integer)) %>% 
  select(CodeCirco, Département = `Libellé du département`, NumeroCirco, Circonscription = `Libellé de la circonscription`, 
         Inscrits, Abstentions, Abstentions_ins, Votants, Votants_ins, Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, Exprimés, Exprimés_ins, Exprimés_vot, 
         `ARTHAUD`:`DUPONT-AIGNAN`, `ARTHAUD.ins`:`DUPONT-AIGNAN.exp`) %>% 
  as_tibble()

readr::write_excel_csv(pres_2022_R1_circonscriptions_cleaned, path = "./data/P2022_Resultats_Circonscriptions_T1.csv")
rio::export(pres_2022_R1_circonscriptions_cleaned, file = "./data/P2022_Resultats_Circonscriptions_T1.xlsx")
