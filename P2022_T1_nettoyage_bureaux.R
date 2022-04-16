

pres_2022_R1_communes <- read_excel("./data-raw/2022/resultats-par-niveau-subcom-t1-france-entiere.xlsx", guess_max = 36000) %>% 
  mutate(Inscrits = as.numeric(Inscrits))
