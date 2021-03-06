
##ilc contains the data for tenur
path_ilc_0<-"data/ilc_lvho02.tsv"
ilc_1<-read.table(path_ilc_0 ,sep ='\t', header=TRUE)


path_ilc_1<-"data/ilc_1.csv"
write.table(ilc_1, file=path_ilc_1, sep=",",quote=FALSE, row.names = FALSE)



path_lfsa_0<-"data/lfsa_urgan.tsv"
lfsa_1<-read.table(path_lfsa_0,sep ='\t',header=TRUE)


path_lfsa_1<-"data/lfsa_1.csv"
write.table(lfsa_1, file=path_lfsa_1, sep=",",quote=FALSE,row.names=FALSE)



#load dataset now with separated 
ilc_2<-read.table(
  path_ilc_1,
  sep=",", header=FALSE, skip=1, 
  col.names = c(c("incgrp","hhtype","tenure","geo"),2020:2003),
  na.strings = ": "
)
lfsa_2<-read.table(path_lfsa_1,
                sep=",", header=FALSE, skip=1,
                col.names= c(c("unit","sex","age","citizen","geo"),2019:1995),
                na.strings = ": "
)


## For our analysis we ar not intrested in the householdtyp (hhtyp)
## nor the income group (incgr), therefor we only look at
## the overall values (TOTAL) of these variables

ilc_3<-ilc_2[ilc_2$incgr== "TOTAL" &
               ilc_2$hhtype == "TOTAL"
               ,-(c(1,2))]
ilc_3$tenure<-as.factor(ilc_3$tenure)


## For the analysis we are only intrested in the country
## unemploymentrat of the primary working age (Y25-54), therefor we will only look at the overall values 
## of sex and citizenship (T for sex and TOTAL for citizenship ).
## unit is PC for all entries therfore we leave it out aswell

lfsa_3<-lfsa_2[lfsa_2$sex == "T" &
               lfsa_2$age == "Y25-54" &
               lfsa_2$citizen == "TOTAL",-c(1,2,3,4)] 






## lfsa has less values in geo than ilc
## EU15 in lfsa but not in ilc. 
## We only want to match on country level for our analisies
## therfore we will leave out EA19,  

geocodes<-lfsa_3$geo[-c(9,13,14,15)]
############################################ hier noch stabiler machen für änderungen

## just the geo areas we need

ilc_4<-ilc_3[ilc_3$geo %in% geocodes,]




lfsa_4<-lfsa_3[lfsa_3$geo %in% geocodes,] 



dataFlags<-function(X,pattern){length(grep(pattern=pattern,x=X))}



sapply(X=ilc_4[,3:20], dataFlags, pattern="b")
sapply(X=ilc_4[,3:20], dataFlags, pattern="c")
sapply(X=ilc_4[,3:20], dataFlags, pattern="d")
sapply(X=ilc_4[,3:20], dataFlags, pattern="e")
sapply(X=ilc_4[,3:20], dataFlags, pattern="f")
sapply(X=ilc_4[,3:20], dataFlags, pattern="n")
sapply(X=ilc_4[,3:20], dataFlags, pattern="p")
sapply(X=ilc_4[,3:20], dataFlags, pattern="r")
sapply(X=ilc_4[,3:20], dataFlags, pattern="s")
sapply(X=ilc_4[,3:20], dataFlags, pattern="u")
sapply(X=ilc_4[,3:20], dataFlags, pattern="z")
sapply(X=ilc_4[,3:20], dataFlags, pattern=":")

#b (time series break)(a lot), n (n = not significant)(one in 2019),
#p (p = provisional)(7 in 2020 und 7 in 2015), : (in almost every year, only inbetween 2018-2013 are non)






sapply(X=lfsa_4[,2:26], dataFlags, pattern="b")
sapply(X=lfsa_4[,2:26], dataFlags, pattern="c")
sapply(X=lfsa_4[,2:26], dataFlags, pattern="d")
sapply(X=lfsa_4[,2:26], dataFlags, pattern="e")
sapply(X=lfsa_4[,2:26], dataFlags, pattern="f")
sapply(X=lfsa_4[,2:26], dataFlags, pattern="n")
sapply(X=lfsa_4[,2:26], dataFlags, pattern="p")
sapply(X=lfsa_4[,2:26], dataFlags, pattern="r")
sapply(X=lfsa_4[,2:26], dataFlags, pattern="s")
sapply(X=lfsa_4[,2:26], dataFlags, pattern="u")
sapply(X=lfsa_4[,2:26], dataFlags, pattern="z")


### only flags in the dataset lfsa are "b" and "Na", 

### Important question: what to do with the error code...
### für flags ":" einfach mit NA ersetzen, für n und p einzelfälle bewerten und potenziell eine 
### boolain var für die 3 spallten. Problem mit fehlercode b

### We make a simplified experiment where we only look at the data of Ownership vs Renting, 
### no subtypes of renting or owning. Therefor w only need the variable Owning as we want
### the percentage of owners. We also take out 2020 as the data is collected oly for a few countries

ilc_5<-ilc_4[ilc_4$tenure == "OWN",-3]


### Because we have break in time series in 2005 for the lfsa data 
### we will cut off there effectively starting the time series at 2006

lfsa_5<-lfsa_4[,1:15]


sapply(X=ilc_5[,3:19], dataFlags, pattern="b")
sapply(X=ilc_5[,3:19], dataFlags, pattern="n")
sapply(X=ilc_5[,3:19], dataFlags, pattern="p")

sapply(X=lfsa_5[,2:15], dataFlags, pattern="b")


### we now make the data in the set numeric by making adding extra columns for the flag information
### We also name the columns accordingly

ilc_5_flag_b<-data.frame(apply(X=ilc_5[,c(3,5,6,8,10,11,12,13,14)],MARGIN = 2,FUN=grepl,pattern="b"))
ilc_flag_p_2015<-as.vector(grepl(ilc_5[,7],pattern="p"))

colnames(ilc_5_flag_b)<-paste(rep("ilc_flag_b_",9),c(2019,2017,2016,2014,2012,2011,2010,2009,2008),sep="")


lfsa_5_flag_b<-data.frame(apply(X=lfsa_5[,c(3,4,5,6,7,10,11,12,13,14,15)],MARGIN = 2,FUN= grepl,pattern="b"))

colnames(lfsa_5_flag_b)<-paste(rep("lfsa_flag_b_",11),c(2018,2017,2016,2015,2014,2011,2010,2009,2008,2007,2006),sep="")



### next we remove the flags from the data itself to prepare it for conversion to numeric data.
### 
ilc_6tmp<- apply(X= ilc_5[,3:19],MARGIN=2,gsub,pattern=" ",replacement="")
ilc_6tmp<- apply(X= ilc_6tmp[,],MARGIN=2,gsub,pattern="b",replacement="")
ilc_6tmp<- apply(X= ilc_6tmp[,],MARGIN=2,gsub,pattern="p",replacement="")
ilc_6tmp<- data.frame(apply(X= ilc_6tmp[,],MARGIN=2, as.numeric))
ilc_6<-cbind(ilc_5[,2],ilc_6tmp)
colnames(ilc_6)[1]<-"geo"
  
lfsa_6tmp<- apply(X= lfsa_5[,2:15],MARGIN=2,gsub,pattern=" ",replacement="")
lfsa_6tmp<- apply(X= lfsa_6tmp[,],MARGIN=2,gsub,pattern="b",replacement="")
lfsa_6tmp<- data.frame(apply(X= lfsa_6tmp[,],MARGIN=2, as.numeric))
lfsa_6<-cbind(lfsa_5[,1],lfsa_6tmp)
colnames(lfsa_6)[1]<-"geo"


### dataflags
ilc_6_flags<-cbind(ilc_5_flag_b,ilc_flag_p_2015)


### We will now save the data that we produced in a csv files. One file for the data itself and one for its flags for each ownership rate and unemplymentrate


path_ilc_6<-"data/ownership_rate.csv"
write.csv(ilc_6[,-1], file=path_ilc_6,row.names = ilc_6[,1])

path_ilc_6_flags<-"data/ownership_rate_flags.csv"
write.csv(ilc_6_flags, file=path_ilc_6_flags,row.names = ilc_6[,1])



path_lfsa_6<-"data/unemployment_rate.csv"
write.csv(lfsa_6[,-1], file=path_lfsa_6, row.names =  lfsa_6[,1])

path_lfsa_6_flags<-"data/unemployment_rate_flags.csv"
write.csv(lfsa_5_flag_b, file=path_lfsa_6_flags,row.names =  lfsa_6[,1])



