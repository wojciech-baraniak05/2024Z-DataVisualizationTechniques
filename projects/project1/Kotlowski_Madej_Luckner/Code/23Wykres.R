
library(dplyr)
library(ggplot2)
library(extrafont)

alco02<-read.csv("Csv-ki/Alco02-04.csv")
alco04<-read.csv("Csv-ki/Alco04-06.csv")
alco06<-read.csv("Csv-ki/Alco06-08.csv")
alco08<-read.csv("Csv-ki/Alco08-10.csv")
alco10<-read.csv("Csv-ki/Alco10-12.csv")
alco12<-read.csv("Csv-ki/Alco12-14.csv")
alco14<-read.csv("Csv-ki/Alco14-16.csv")
alco16<-read.csv("Csv-ki/Alco16-18.csv")


Marij02 <- read.csv("Csv-ki/Marij02-04.csv")
Marij04 <- read.csv("Csv-ki/Marij04-06.csv")
Marij06 <- read.csv("Csv-ki/Marij06-08.csv")
Marij08 <- read.csv("Csv-ki/Marij08-10.csv")
Marij10 <- read.csv("Csv-ki//Marij10-12.csv")
Marij12 <- read.csv("Csv-ki/Marij12-14.csv")
Marij14 <- read.csv("Csv-ki/Marij14-16.csv")
Marij16 <- read.csv("Csv-ki/Marij16-18.csv")


Cocaine02 <- read.csv("Csv-ki/Cocaine02-04.csv")
Cocaine04 <- read.csv("Csv-ki/Cocaine04-06.csv")
Cocaine06 <- read.csv("Csv-ki/Cocaine06-08.csv")
Cocaine08 <- read.csv("Csv-ki/Cocaine08-10.csv")
Cocaine10 <- read.csv("Csv-ki/Cocaine10-12.csv")
Cocaine12 <- read.csv("Csv-ki/Cocaine12-14.csv")
Cocaine14 <- read.csv("Csv-ki/Cocaine14-16.csv")
Cocaine16 <- read.csv("Csv-ki/Cocaine16-18.csv")


library(tidyr)


Marij_combined <- do.call(rbind, list(Marij02, Marij04, Marij06, Marij08, Marij10, Marij12, Marij14, Marij16))
Alcocombined <- do.call(rbind, list(alco02, alco04, alco06, alco08, alco10, alco12, alco14, alco16))
Cocaine_combined <- do.call(rbind, list(Cocaine02, Cocaine04, Cocaine06, Cocaine08, Cocaine10, Cocaine12, Cocaine14, Cocaine16))


CocaineCleared<-Cocaine_combined%>%
  filter(age_group!="18 or Older" | age_group!="25 or Older")%>%
  group_by(years)%>%
  summarise(Cocaine=mean(as.numeric(estimate),na.rm=TRUE))

MarijCleared<-Marij_combined%>%
  filter(age_group!="18 or Older" | age_group!="25 or Older")%>%
  group_by(years)%>%
  summarise(Marijuana=mean(as.numeric(estimate),na.rm=TRUE))

AlcoCleared<-Alcocombined%>%
  filter(age_group!="18 or Older" | age_group!="25 or Older")%>%
  group_by(years)%>%
  summarise(Alcohol=mean(as.numeric(estimate),na.rm=TRUE))

Result<-CocaineCleared%>%
  inner_join(AlcoCleared,by="years")%>%
  inner_join(MarijCleared,by="years")%>%
  pivot_longer(col=c("Alcohol","Cocaine","Marijuana"), names_to = "Type", values_to = "AVG")


ggplot(data=Result,aes(x=as.factor(years),color=Type,group=1))+
  geom_line(aes(y=AVG))+
  geom_point(aes(y=AVG))+
  facet_wrap(~Type,ncol = 1,scales='free')+
  labs(title="Consumption of alcohol and drugs by minors",x="Year",
       subtitle="2002-2018",
       y="Estimated procent of youth",
       color="")+
  guides(color = "none")+
  theme(axis.title.x = element_text(size = 34,family = "open_sans"),axis.title.y=element_text(size=34,family = "open_sans"),plot.title = element_text(size=16,family = "open_sans"),
        axis.text.x = element_text(size = 34,family = "open_sans"),axis.text.y=element_text(size=34,family = "open_sans"),
        legend.text = element_text(size = 34,family = "open_sans"),legend.title = element_text(size = 34,family = "open_sans"))+
  theme(
    panel.background = element_blank(),    
    panel.grid.major = element_blank(),     
    panel.grid.minor = element_blank(),     
    axis.line = element_line(color = "white"),  
    axis.title = element_text(color = "white"), 
    axis.text = element_text(color = "white"),
    plot.background = element_rect(fill = "#221A32", color = NA),
    legend.background = element_rect(fill = "#221A32", color = NA),
    legend.text = element_text(color = "white"),
    legend.title = element_text(color = "white")
  )




LifeData<-read.csv("Csv-ki/Life.csv")
HappinessData<-read.csv("Csv-ki/Happiness.csv")
AlcoData<-read.csv("Csv-ki/AlcoCons.csv")
AlcoWorld<-read.csv("Csv-ki/drinks.csv")


AlcoDataCleared<-AlcoData%>%
  mutate(Entity=name,AlcoLiters=liters.of.pure.alcohol)%>%
  select(Entity,AlcoLiters,region)

AlcoBetter<-AlcoWorld%>%
  rename(Entity=country,AlcoLiters=total_litres_of_pure_alcohol)%>%
  select(Entity,AlcoLiters)


HappinessDataCleared<-HappinessData%>%
  filter(Year==2019)%>%
  select(Entity,Cantril.ladder.score)

LifeDataCleared<- LifeData%>%
  filter(Year==2019)%>%
  mutate(life_expectancy=Period.life.expectancy.at.birth...Sex..all...Age..0)%>%
  select(Entity,life_expectancy)

MergedData<-AlcoDataCleared%>%
  inner_join(HappinessDataCleared,by="Entity")%>%
  inner_join(LifeDataCleared,by="Entity")

Result<-MergedData%>%
  mutate(quantile_rank=ntile(MergedData$AlcoLiters,4))


Result2<-AlcoBetter%>%
  inner_join(HappinessDataCleared,by="Entity")%>%
  inner_join(LifeDataCleared,by="Entity")

#Opcja 2


ggplot(data=Result,aes(x=life_expectancy,y=Cantril.ladder.score,color=AlcoLiters))+
  geom_point(size = 3)+
  scale_color_gradient2(name="Liters \nof pure \nalcohol",
                        mid = ("yellow"),
  
                        high = ("blue"))+
  labs(title="Liters of Alcohol consumed per Capita - Worldwide",subtitle="2019",x="Life expectancy",y="Happiness Level")+
  theme(axis.title.x = element_text(size = 34,family = "open_sans"),axis.title.y=element_text(size=34,family = "open_sans"),plot.title = element_text(size=16,family = "open_sans"),
        axis.text.x = element_text(size = 34,family = "open_sans"),axis.text.y=element_text(size=34,family = "open_sans"),
        legend.text = element_text(size = 34,family = "open_sans"),legend.title = element_text(size = 34,family = "open_sans"))+
  theme_minimal()+
  theme(
    panel.background = element_blank(),    
    panel.grid.major = element_blank(),     
    panel.grid.minor = element_blank(),     
    axis.line = element_line(color = "white"),  
    axis.title = element_text(color = "white"), 
    axis.text = element_text(color = "white"),
    plot.background = element_rect(fill = "#221A32", color = NA),
    legend.background = element_rect(fill = "#221A32", color = NA),
    legend.text = element_text(color = "white"),
    legend.title = element_text(color = "white")
  )

  
