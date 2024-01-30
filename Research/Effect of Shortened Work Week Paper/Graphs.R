install.packages("ggplot2")
library(ggplot2)
ggplot(data = Compiled, aes(x=Adult_Educ, y=Labor_productivity))+geom_point()
ggplot(data = Compiled, aes(x=Hours_Worked, y=Labor_productivity))+geom_point()
ggplot(data = Compiled, aes(x=Working_age_population, y=Hours_Worked))+geom_point()

install.packages("broom")
install.packages("tidyverse")
library(broom)
library(tidyverse)






#Below are the correct lines of code for the plots



Plot_Data<-True_Data%>%
  filter(Country!='UK' & Country!='Ireland')

Plot_Data%>%
  group_by(Country) %>%
  mutate(AGS = AGS / sum(AGS)) %>%
  ggplot(aes(y=AGS, x=Year,color=Country))+geom_line()+
  labs(title="Agriculture (%) Time Series",
       x="Year",
       y="Agriculture (%)")+
  facet_wrap(~Country)


Plot_Data%>%
  group_by(Country) %>%
  mutate(EUS = EUS / sum(EUS)) %>%
  ggplot(aes(y=EUS, x=Year,color=Country))+geom_line()+
  labs(title="Energy (%) Time Series",
       x="Year",
       y="Energy (%)")+
  facet_wrap(~Country)

Plot_Data%>%
  group_by(Country) %>%
  mutate(MUS = (MUS / sum(MUS))) %>%
  ggplot(aes(y=MUS, x=Year,color=Country))+geom_line()+
  labs(title="Manufacturing (%) Time Series",
       x="Year",
       y="Manufacturing (%)")+
  facet_wrap(~Country)

Plot_Data%>%
  group_by(Country) %>%
  mutate(CUS = CUS / sum(CUS)) %>%
  ggplot(aes(y=CUS, x=Year,color=Country))+geom_line()+
  labs(title="Construction (%) Time Series",
       x="Year",
       y="Construction (%)")+
  facet_wrap(~Country)

Plot_Data%>%
  group_by(Country) %>%
  mutate(FIUS = FIUS / sum(FIUS)) %>%
  ggplot(aes(y=FIUS, x=Year,color=Country))+geom_line()+
  labs(title="Financial & Insurance (%) Time Series",
       x="Year",
       y="Financial & Insurance (%)")+
  facet_wrap(~Country)

Plot_Data%>%
  group_by(Country) %>%
  mutate(REUS = REUS / sum(REUS)) %>%
  ggplot(aes(y=REUS, x=Year,color=Country))+geom_line()+
  labs(title="Real Estate (%) Time Series",
       x="Year",
       y="Real Estate (%)")+
  facet_wrap(~Country)

Emission_Plot_Data_<-Emission_Plot_Data%>%
  filter(Country!='UK')

Emission_Plot_Data_%>%
  group_by(Country) %>%
  mutate(Emission = Emission / sum(Emission)) %>%
  ggplot(aes(y=Emission, x=Year+1,color=Country))+geom_line()+
  labs(title="Emission (%) Time Series",
       x="Year",
       y="Emissioin (%)")+
  facet_wrap(~Country)

Plot_Data%>%
  ggplot(aes(y=Labor_productivity, x=Year,color=Country))+geom_line()+
  labs(title="Labor Productivity (%) Time Series",
       x="Year",
       y="Labor Productivity (%)")+
  facet_wrap(~Country)



# The New Plots

For_Plots%>%
  ggplot(aes(y=AGS_Per, x=Year,color=Country)) + geom_line() + geom_point() +
  labs(title="Agriculture (%) Time Series",
       x="Year",
       y="Agriculture (%)")+ geom_vline(xintercept = 2017)

For_Plots %>%
  ggplot(aes(y=EUS_Per, x=Year,color=Country)) + geom_line() + geom_point() +
  labs(title="Energy (%) Time Series",
       x="Year",
       y="Energy (%)") + geom_vline(xintercept = 2017)

For_Plots %>%
  ggplot(aes(y=MUS_Per, x=Year,color=Country)) + geom_line() + geom_point() +
  labs(title="Manufacturing (%) Time Series",
       x="Year",
       y="Manufacturing (%)")+ geom_vline(xintercept = 2017)

For_Plots %>%
  ggplot(aes(y=CUS_Per, x=Year,color=Country)) + geom_line() + geom_point() +
  labs(title="Construction (%) Time Series",
       x="Year",
       y="Construction (%)")+ geom_vline(xintercept = 2017)

For_Plots %>%
  ggplot(aes(y=FIUS_Per, x=Year,color=Country)) + geom_line() + geom_point() +
  labs(title="Financial & Insurance (%) Time Series",
       x="Year",
       y="Financial & Insurance (%)")+ geom_vline(xintercept = 2017)

For_Plots %>%
  ggplot(aes(y=REUS_Per, x=Year,color=Country)) + geom_line() + geom_point() +
  labs(title="Real Estate (%) Time Series",
       x="Year",
       y="Real Estate (%)")+ geom_vline(xintercept = 2017)

For_Plots %>%
  ggplot(aes(y=Emission, x=Year,color=Country)) + geom_line() + geom_point() +
  labs(title="Emission (MtCO2) Time Series",
       x="Year",
       y="Emission (MtCO2)")+ geom_vline(xintercept = 2017)

For_Plots %>%
  ggplot(aes(y=Labor_productivity, x=Year,color=Country)) + geom_line() + geom_point() +
  labs(title="Labor Productivity (%) Time Series",
       x="Year",
       y="Labor Productivity (%)")+ geom_vline(xintercept = 2017)
  

  