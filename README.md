# Résultats électoraux Présidentielle 2022

<img src="https://github.com/tguerra/presidentielle2022/blob/main/hex.png" alt="The frenchpol hexlogo" align="right" width="200" style="padding: 0 15px; float: right;"/>

Ce répertoire abrite les données nettoyées de l'élection présidentielle de 2022 (premier et second tours) à toutes les échelles géographiques (nationale, départementale, au niveau des cantons et des cirsconscriptions, des communes et des bureaux de vote).

Code and data for research on French 2022 Presidential elections.

Further credits go to Joël Gombin and François Briatte for helping in various ways.

# DONNÉES / DATA

All original data come [from the French Ministry of the Interior](https://www.data.gouv.fr/en/posts/les-donnees-des-elections/). 
All raw files of the electoral results are located in the `data-raw/` folder.

## ÉLECTIONS

### Présidentielle 2022 - Premier tour
- [Presidential election 2022 (round 1) - national, région, départements, cantons, circonscription](https://www.data.gouv.fr)
- [Presidential election 2022 (round 1) - communes](https://www.data.gouv.fr)
- [Presidential election 2022 (round 1) - bureaux de vote](https://www.data.gouv.fr)

### Présidentielle 2022 - Second tour
- [Presidential election 2022 (round 2) - national, région, départements, cantons, circonscription](https://www.data.gouv.fr)
- [Presidential election 2022 (round 2) - communes](https://www.data.gouv.fr)
- [Presidential election 2022 (round 2) - bureaux de vote](https://www.data.gouv.fr)

### Présidentielle 2017 
- [Presidential election 2017 (round 1) - bureaux de vote](https://www.data.gouv.fr/fr/datasets/election-presidentielle-des-23-avril-et-7-mai-2017-resultats-definitifs-du-1er-tour-par-bureaux-de-vote/)
- [Presidential election 2017 (round 1) - communes](https://www.data.gouv.fr/fr/datasets/election-presidentielle-des-23-avril-et-7-mai-2017-resultats-du-1er-tour-1/)
- [Presidential election 2017 (round 1) - national, région, départements, cantons, circonscriptions ](https://www.data.gouv.fr/fr/datasets/election-presidentielle-des-23-avril-et-7-mai-2017-resultats-du-1er-tour/)
- [Presidential election 2017 (round 2) - national, région, départements, cantons, circonscriptions](https://www.data.gouv.fr/fr/datasets/election-presidentielle-des-23-avril-et-7-mai-2017-resultats-du-1er-tour-1/)
- [Presidential election 2017 (round 2) - communes](https://www.data.gouv.fr/fr/datasets/election-presidentielle-des-23-avril-et-7-mai-2017-resultats-du-2eme-tour-2/)

## CONTOURS GÉOGRAPHIQUES / SHAPEFILES

Les données sont obtenues sur le site d'[Open Street Map](https://www.openstreetmap.fr/donnees/).
Dans le répertoire ```shp``` les contours pour les communes, cantons (découpage 2015), départements et régions sont disponibles au format GeoJson (.geojson) et Shapefile (.shp).


# CODE / HOWTO

The code is located in the various `nettoyage-(.*)/` R files, except for the pseudo-makefiles for each analysis and for the code that checks total vote shares to detect missing data in the original data.

The __package dependencies__ at the top of each script (mostly [tidyverse](https://www.tidyverse.org/) packages) have not been very thoroughly checked -- there might be a few omissions here and there. This, however, is almost guaranteed to get you through the code without encountering missing functions:

```r
install.packages("remotes")                          # package installer
remotes::install_cran("tidyverse", "readxl", "stringr")       # required packages available on Cran
remotes::install_github("joelgombin/LireMinInterieur") # install Joël Gombin package to parse Interior Ministry files
```

# PROBLÈMES / ISSUES

Please report issues on this repository or to `tristan.guerra \at iepg \dot fr`.
