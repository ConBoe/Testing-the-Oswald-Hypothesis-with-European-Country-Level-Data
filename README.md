# Testing-the-Oswald-Hypothesis-with-European-Country-Level-Data

## Abstract
The Oswald Hypothesis was first introduced by A.J. Oswald in 1996 where he pointed out a correlation between homeownership rate and the unemployment rate on a state level. He used simple LS-Regression on the data of the 1960s and 1990s as well as a LS-Regression on the 20-years-changes of these two rates. In all three Regressions he found a positiv correlation. We want to recreate this experiment with european data from the 2000s and 2010s on a nation level and see if the Hypothesis holds.
We find that the evidence is weak at best before the finacial crisis but becomes more sustainable after it. 

## Structur Explained

### Data
The data downloaded from EuroStat as well as the filtered data can be found in the folder 'data'. 
The downloaded file 'ilc_lvho02.tsv' contains multiple timeseries of different nations on homeownership rate as well as additional catagories we do not use. 
The file 'lfsa_urgan.tsv' contains multiple timeseries of different nations on unemplyoment rate rate as well as additional catagories we do not use. 
The file 'ownership_rate.csv' contains the filtered data on homeownership that we use for the analysis. The file 'ownership_rate_flags.csv' contains the error flags for the data from in 'ownership_rate.csv'.
The file 'unemployment_rate.csv' contains the filtered data on unemployment that we use for the analysis. The file 'unemployment_rate_flags.csv' contains the error flags for the data from in 'unemployment_rate.csv'.


The files 'ilc_lvho02.tsv' and 'lfsa_urgan.tsv' have a simular structur. The first column contains a multible of variables (incgrp,hhtyp,tenure geo for ilc_lvho02.tsv and unit,sex,age,citizen,geo for lfsa_urgan.tsv) which combine to one factor. Each following column contains the values for one year. They also contain errorflags, which are letters indicating posisble statistical problems with the specific value (e.g. small samplesize, timeseries breaks,...).

Meanings of the variables in the first coulmn and there values can be found in the codelist.

### Codelists
The codelists can be found in the folder 'codelists'. Codelist give explainations of the factor variables and there values. The meaning of the varible itself can be found in 'dimlst.dic'. The meaning of each value of these variables can be found in the acording .dic file.

### Graphics
The three graphics produced by the code can be found in the folder 'graphics'.

### Code 
The code can be found in the rood directory of this repository. The two files are 'os_filter.R' and 'os_analysis'. For further information on them see the 'how to use' section of this README file.

### Metadata

Metadata in sdmx format can be found in the folder 'metadata' in zip files.
For information on SDMX as well as tools refere to the [EuroStat information website on SDMX](https://ec.europa.eu/eurostat/de/web/sdmx-infospace/welcome).

## How to Use
The R code is written for R version 4.0.3 (2020-10-10).

The code is seperated into two files in the root directory, 'os_filter.r' and 'os_analysis.R'. Before exicuting them one must download the files 'ilc_lvho02.tsv' and 'lfsa_urgan.tsv' manuelly. 
This is either possible:
1. from EuroStat using the code ilc_lvho02 and lfsa_urgan in the search function of the website and clicking the 'download tsv' button. This will download a .zip file that must be unpacked (use WinRa or a simular free software). 
2. from this [reposetory](https://github.com/ConBoe/Testing-the-Oswald-Hypothesis-with-European-Country-Level-Data/tree/main/data) directly.

(functionally of the code can not be garunteed for newly downloaded data from EuroStat due to possible structural changes)

Save the files in a folder that you name 'data' and use the setwd function in R to the path where this folder is stored. ( type '?setwd' in the R console for help). 

Execute the r skript 'filter.R'. This will creat multiple files in 'data', the most important being 'ownership_rate.csv', 'unemployment_rate.csv','ownership_rate_flags.csv' and 'unemployment_rate_flags.csv'. There content is explained in the subsection above.

Execute the R skript 'os_analysis.R' to create PNG plots in a folder 'graphics' in the current working directory. 
