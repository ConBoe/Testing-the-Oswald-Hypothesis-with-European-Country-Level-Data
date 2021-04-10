### Paths from the data prepairation

path_ilc_6<-"data/ownership_rate.csv"
path_ilc_6_flags<-"data/ownership_rate_flags.csv"

path_lfsa_6<-"data/unemployment_rate.csv"
path_lfsa_6_flags<-"data/unemployment_rate_flags.csv"



### We choose to ignore the timeseries breaks for now (errorflag b)
### we might consider them in a later analysis




homeownership<-read.csv(file=path_ilc_6,row.names = 1)
unemployment<-read.csv(file=path_lfsa_6,row.names = 1)


plot(2019:2006,homeownership["AT",-c(15,16,17)], type="l",ylim= c(40,99))


for(i in 2:35){
  lines(2019:2006,homeownership[i,-c(15,16,17)], type="l")
}


mytestyear<-c("X2006","X2013","X2019")
### We make the same test as Oswald did at three different times. 2006, 2013 and 2019.

### produce the plots
for(i in 1:3){

png(file = paste("graphics/plot_",i,".png", sep = ""),width=500,height=300)

plot(homeownership[,mytestyear[i]],unemployment[,mytestyear[1]],
     main= paste("Homeownership Rate vs Unemployment in ",mytestyear[i]),
     xlab = "Homeownership Rate in %",
     ylab = "Unemployment Rate in %",
     xlim=c(40,100))

mylm<-lm(unemployment[,mytestyear[1]]~homeownership[,mytestyear[i]])
abline(mylm,col=2)

legend("topleft",
       legend= c("Datapoints", "LS-Regression Line"),
       col=c(1,2),
       lty = c(0,1),
       pch = c(1,0))

dev.off()
}
