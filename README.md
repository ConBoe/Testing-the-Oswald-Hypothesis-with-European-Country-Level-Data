# Testing-the-Oswald-Hypothesis-with-European-Country-Level-Data

## Abstract
The Oswald Hypothesis was first introduced by A.J. Oswald in 1996 where he pointed out a correlation between homeownership rate and the unemployment rate on a state level. He used simple LS-Regression on the data of the 1960s and 1990s as well as a LS-Regression on the 20-years-changes of these two rates. In all three Regressions he found a positiv correlation. We want to recreate this experiment with european data from the 2000s and 2010s on a nation level and see if the Hypothesis holds.
We find that the evidence is weak at best before the finacial crisis but becomes more sustainable after it. 

## Explained



## How to Use
The R code is written for R version 4.0.3 (2020-10-10).

The code is seperated into two files in the root directory, 'os_filter.r' and 'os_analysis.R'. Before exicuting them one must download the files 'ilc_lvho02.tsv' and 'lfsa_urgan.tsv' manuelly. 
This is either possible:
1. from EuroStat using the code ilc_lvho02 and lfsa_urgan in the search function of the website and clicking the 'download tsv' button. This will download a .zip file that must be unpacked (use WinRa or a simular free software). 
2. from this [reposetory](https://github.com/ConBoe/Testing-the-Oswald-Hypothesis-with-European-Country-Level-Data/tree/main/data) directly.

Save the files in a folder that you name 'data' and use the setwd function in R to the path where this folder is stored. ( type '?setwd' in the R console for help). 

Execute the r skript 'filter.R'. This will creat multiple files in 'data', the most important being 'ownership_rate.csv', 'unemployment_rate.csv','ownership_rate_flags.csv' and 'unemployment_rate_flags.csv'. There content is explained in the subsection above.

Execute the R skript 'os_analysis.R' to create PNG plots in a folder 'graphics' in the current working directory. 
