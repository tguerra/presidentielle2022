library(readxl) # read excel files
library(stringr) # manipulate string of characters
library(LireMinInterieur) # transform electoral files
library(tidyverse) # the tidyverse...

### Régions ####

pres_2017_R2_regions <- read_excel("./data-raw/2017/Presidentielle_2017_Resultats_Tour_2_c.xls", skip = 4, guess_max = 25, sheet = "Régions Tour 2")

pres_2017_R1_regions_cleaned <- lire(pres_2017_R2_regions, 
                                     keep = c("Code de la région", "Libellé de la région", "Inscrits", "Abstentions", "Exprimés", "Blancs", "Nuls"), 
                                     col = c(18, 24), 
                                     gap = 2)

pres_2017_R1_regions_cleaned <- pres_2017_R1_regions_cleaned %>% 
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


#### Départements ####

pres_2017_R2_departements <- read_excel("./data-raw/2017/Presidentielle_2017_Resultats_Tour_2_c.xls", 
                                        guess_max = 103, sheet = "Départements Tour 2", skip = 3)

pres_2017_R2_departements_cleaned <- lire(pres_2017_R2_departements, 
                                          #keep = c(1, 2, 4, 5, 9, 12, 15),
                                          keep = c("Code du département", "Libellé du département", "Inscrits", "Abstentions", "Blancs", "Nuls", "Exprimés"), 
                                          col = c(18, 24), 
                                          gap = 2)

pres_2017_R2_departements_cleaned <- pres_2017_R2_departements_cleaned %>% 
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

### Circonscriptions législatives

pres_2017_R2_circonscriptions <- read_excel("./data-raw/2017/Presidentielle_2017_Resultats_Tour_2_c.xls", 
                                            guess_max = 600, sheet = "Circo. Leg. Tour 2", skip = 3)

pres_2017_R2_circonscriptions_cleaned <- lire(pres_2017_R2_circonscriptions, 
                                              #keep = c(1, 2, 3, 4, 6, 7, 11, 14, 17),
                                              keep = c("Code du département", "Libellé du département", "Code de la circonscription", "Libellé de la circonscription", 
                                                       "Inscrits", "Abstentions", "Exprimés", "Blancs", "Nuls"), 
                                              col = c(21, 28), 
                                              gap = 2)

pres_2017_R2_circonscriptions_cleaned <- pres_2017_R2_circonscriptions_cleaned %>% 
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
  mutate(across(c(Inscrits, Abstentions, Votants, Blancs, Nuls, Exprimés, `MACRON`:`LE PEN`), as.integer)) %>% 
  select(CodeCirco, Département = `Libellé du département`, NumeroCirco, Circonscription = `Libellé de la circonscription`, 
         Inscrits, Abstentions, Abstentions_ins, Votants, Votants_ins, Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, Exprimés, Exprimés_ins, Exprimés_vot, 
         `MACRON`:`LE PEN`, `MACRON.ins`:`LE PEN.exp`) %>% 
  as_tibble()


#### Communes #####


pres_2017_R2_communes <- read_excel("./data-raw/2017/Presidentielle_2017_Resultats_Communes_Tour_2_c.xls", guess_max = 36000, skip = 3)

pres_2017_R2_communes_cleaned <- lire(pres_2017_R2_communes, 
                                    keep = c("Code du département", "Code de la commune", "Libellé de la commune", 
                                             "Inscrits", "Abstentions", "Exprimés", "Blancs", "Nuls"), 
                                    col = c(21, 28), 
                                    gap = 2)


pres_2017_R2_communes_cleaned <- pres_2017_R2_communes_cleaned %>% 
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

## write files

write_excel_csv(pres_2017_R1_regions_cleaned, path = "./data/P2017_Resultats_Regions_T2.csv")
write_excel_csv(pres_2017_R2_departements_cleaned, path = "./data/P2017_Resultats_Departements_T2.csv")
write_excel_csv(pres_2017_R2_circonscriptions_cleaned, path = "./data/P2017_Resultats_Circonscriptions_T2.csv")
write_excel_csv(pres_2017_R2_communes_cleaned, path = "./data/P2017_Resultats_Communes_T2.csv")

rio::export(pres_2017_R1_regions_cleaned, file = "./data/P2017_Resultats_Regions_T2.xlsx")
rio::export(pres_2017_R2_departements_cleaned, file = "./data/P2017_Resultats_Departements_T2.xlsx")
rio::export(pres_2017_R2_circonscriptions_cleaned, file = "./data/P2017_Resultats_Circonscriptions_T2.xlsx")
rio::export(pres_2017_R2_communes_cleaned, file = "./data/P2017_Resultats_Communes_T2.xlsx")


