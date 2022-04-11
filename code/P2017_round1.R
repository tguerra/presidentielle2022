#### code by Joel gombin
#### source : https://github.com/datactivist/presidentielle2017

library(readxl) # read excel files
library(stringr) # manipulate string of characters
library(LireMinInterieur) # transform electoral files
library(tidyverse) # the tidyverse...


#### Régions ####

pres_2017_R1_regions <- read_excel("./data-raw/Presidentielle_2017_Resultats_Tour_1.xls", skip = 3, guess_max = 25, sheet = "Régions Tour 1")

pres_2017_R1_regions_cleaned <- lire(pres_2017_R1_regions, 
                                     keep = c("Code de la région", "Libellé de la région", "Inscrits", "Abstentions", "Exprimés", "Blancs", "Nuls"), 
                                     col = seq(18, 78, 6), gap = 2)

pres_2017_R1_regions_cleaned <- pres_2017_R1_regions_cleaned %>% 
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
  mutate_at(vars(Inscrits, Abstentions, Votants, Blancs, Nuls, Exprimés, `LE PEN`:CHEMINADE), as.integer) %>% 
  # reorder
  select(CodeRégion = `Code de la région`, Région = `Libellé de la région`, Inscrits, Abstentions, Abstentions_ins, Votants, Votants_ins, 
         Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, Exprimés, Exprimés_ins, Exprimés_vot, `LE PEN`:CHEMINADE, `LE PEN.ins`:CHEMINADE.exp) %>% 
  # nicer, more modern dataframe class
  as_tibble()

#### Départements ####

pres_2017_R1_departements <- read_excel("./data-raw/Presidentielle_2017_Resultats_Tour_1.xls", skip = 3, guess_max = 25, sheet = "Départements Tour 1")

pres_2017_R1_departements_cleaned <- lire(pres_2017_R1_departements, keep = c("Code du département", "Libellé du département", "Inscrits", "Abstentions", 
                                                                              "Exprimés", "Blancs", "Nuls"), col = seq(18, 78, 6), gap = 2)

pres_2017_R1_departements_cleaned <- pres_2017_R1_departements_cleaned %>% 
  # put geographical codes in the right format
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
  # specify integers %>% 
  mutate_at(vars(Inscrits, Abstentions, Votants, Blancs, Nuls, Exprimés, `LE PEN`:CHEMINADE), as.integer) %>% 
  # reorder
  select(CodeDépartement, Département = `Libellé du département`, Inscrits, Abstentions, Abstentions_ins, Votants, Votants_ins, Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, 
         Exprimés, Exprimés_ins, Exprimés_vot, `LE PEN`:CHEMINADE, `LE PEN.ins`:CHEMINADE.exp) %>% 
  # nicer, more modern dataframe class
  as_tibble()

#### Cantons ####

pres_2017_R1_cantons <- read_excel("./data-raw/Presidentielle_2017_Resultats_Tour_1.xls", skip = 3, guess_max = 2100, sheet = "Canton Tour 1")

pres_2017_R1_cantons_cleaned <- lire(pres_2017_R1_cantons, keep = c("Code du département", "Libellé du département", "Code du canton", "Libellé du canton", 
                                                                    "Inscrits", "Abstentions", "Exprimés", "Blancs", "Nuls"), col = seq(21, 91, 7), gap = 2)

pres_2017_R1_cantons_cleaned <- pres_2017_R1_cantons_cleaned %>% 
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
  mutate_at(vars(Inscrits, Abstentions, Votants, Blancs, Nuls, Exprimés, `LE PEN`:CHEMINADE), as.integer) %>% 
  # reorder
  select(CodeCanton, CodeDépartement, Département = `Libellé du département`, NumeroCanton, Canton = `Libellé du canton`, Inscrits, 
         Abstentions, Abstentions_ins, Votants, Votants_ins, Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, Exprimés, Exprimés_ins, Exprimés_vot, 
         `LE PEN`:CHEMINADE, `LE PEN.ins`:CHEMINADE.exp) %>% 
  # nicer, more modern dataframe class
  as_tibble()

write_excel_csv(pres_2017_R1_cantons_cleaned, file = "./data/P2017_Resultats_Cantons_T1.csv")

####  First round - circonscriptions ####


pres_2017_R1_circonscriptions <- read_excel("./data-raw/Presidentielle_2017_Resultats_Tour_1.xls", skip = 3, guess_max = 600, sheet = "Circo. Leg. Tour 1")

pres_2017_R1_circonscriptions_cleaned <- lire(pres_2017_R1_circonscriptions, 
                                              keep = c("Code du département", "Libellé du département", "Code de la circonscription", "Libellé de la circonscription", 
                                                       "Inscrits", "Abstentions", "Exprimés", "Blancs", "Nuls"), col = seq(21, 91, 7), gap = 2)

pres_2017_R1_circonscriptions_cleaned <- pres_2017_R1_circonscriptions_cleaned %>% 
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
  mutate_at(vars(Inscrits, Abstentions, Votants, Blancs, Nuls, Exprimés, `LE PEN`:CHEMINADE), as.integer) %>% 
  # reorder
  select(CodeCirco, Département = `Libellé du département`, NumeroCirco, Circonscription = `Libellé de la circonscription`, 
         Inscrits, Abstentions, Abstentions_ins, Votants, Votants_ins, Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, 
         Exprimés, Exprimés_ins, Exprimés_vot, `LE PEN`:CHEMINADE, `LE PEN.ins`:CHEMINADE.exp) %>% 
  # nicer, more modern dataframe class
  as_tibble()

### First round - communes

pres_2017_R1_communes <- read_excel("./data-raw/Presidentielle_2017_Resultats_Communes_Tour_1.xls", skip = 3, guess_max = 36000)

pres_2017_R1_communes_cleaned <- lire(pres_2017_R1_communes, 
                                      keep = c("Code du département", "Code de la commune", "Inscrits", 
                                               "Abstentions", "Exprimés", "Blancs", "Nuls"), col = seq(21, 91, 7), gap = 2)

pres_2017_R1_communes_cleaned <- pres_2017_R1_communes_cleaned %>% 
  # put geographical codes in the right format
  mutate(CodeDepartement = str_pad(string = `Code du département`, width = 2, side = "left", pad = "0")) %>% # has to be in a format like "02"
  mutate(CodeCommune = str_pad(string = `Code de la commune`, width = 3, side = "left", pad = "0")) %>% 
  mutate(CodeInsee = paste0(CodeDepartement, CodeCommune)) %>%  # unique commune ID
  # computing missing values
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
  mutate_at(vars(Inscrits, Abstentions, Votants, Blancs, Nuls, Exprimés, `LE PEN`:CHEMINADE), as.integer) %>% 
  # reorder
  dplyr::select(CodeInsee, CodeDepartement, Inscrits, Abstentions, Abstentions_ins, Votants, Votants_ins, Blancs, Blancs_ins, Blancs_vot, Nuls, Nuls_ins, Nuls_vot, 
         Exprimés, Exprimés_ins, Exprimés_vot, `LE PEN`:CHEMINADE, `LE PEN.ins`:CHEMINADE.exp) %>% 
  as_tibble()



### Export cleaned results in csv and excel

rio::export(pres_2017_R1_regions_cleaned, file = "./data/P2017_Resultats_Regions_T1.csv")
rio::export(pres_2017_R1_regions_cleaned, file = "./data/P2017_Resultats_Regions_T1.xlsx")

rio::export(pres_2017_R1_departements_cleaned, file = "./data/P2017_Resultats_Departements_T1.csv")
rio::export(pres_2017_R1_departements_cleaned, file = "./data/P2017_Resultats_Departements_T1.xlsx")

rio::export(pres_2017_R1_cantons_cleaned, file = "./data/P2017_Resultats_Cantons_T1.csv")
rio::export(pres_2017_R1_cantons_cleaned, file = "./data/P2017_Resultats_Cantons_T1.xlsx")

rio::export(pres_2017_R1_circonscriptions_cleaned, file = "./data/P2017_Resultats_Circonscriptions_T1.csv")
rio::export(pres_2017_R1_circonscriptions_cleaned, file = "./data/P2017_Resultats_Circonscriptions_T1.xlsx")

rio::export(pres_2017_R1_communes_cleaned, file = "./data/P2017_Resultats_Communes_T1.csv")
rio::export(pres_2017_R1_communes_cleaned, file = "./data/P2017_Resultats_Communes_T1.xlsx")



