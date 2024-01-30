install.packages('broom')
install.packages('modelsummary')
install.packages('tideyverse')

library(modelsummary)
library(broom)
library(tidyverse)

# lm(Data_Iceland_compiled$`Agriculture (US Dollars)`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity, data = Data_Iceland_compiled)
# ID<-Data_Iceland_compiled%>%
#   rename(Treatment_Group=`Treatment Group DV`, Post_Treatment_Group=`POST DV`)
# Data_Iceland_compiled

# lm(ID$`Agriculture (US Dollars)`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity+Treatment_Group+Post_Treatment_Group, data = ID)

# model1<-lm(`Agriculture (US Dollars)`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity+Treatment_Group+Post_Treatment_Group, data = ID)

# model2<-lm(ID$`Energy US Dollars`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity+Treatment_Group+Post_Treatment_Group, data = ID)

# model3<-lm(ID$`Manufacture US Dollars`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity+Treatment_Group+Post_Treatment_Group, data = ID)

# model4<-lm(ID$`Construction US Dollars`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity+Treatment_Group+Post_Treatment_Group, data = ID)

# model5<-lm(ID$`Distributive trade, repairs; transport; accommod., food serv. US dollars`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity+Treatment_Group+Post_Treatment_Group, data = ID)

# model6<-lm(ID$`Information and communication US Dollars`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity+Treatment_Group+Post_Treatment_Group, data = ID)

# model7<-lm(ID$`Financial and insurance activities US Dollars`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity+Treatment_Group+Post_Treatment_Group, data = ID)
# model8<-lm(ID$`Real estate activities US Dollars`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity+Treatment_Group+Post_Treatment_Group, data = ID)
# model9<-lm(ID$`Prof., scientific, techn.; admin., support serv. activities US Dollars`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity+Treatment_Group+Post_Treatment_Group, data = ID)
# model10<-lm(ID$`Public admin.; compulsory s.s.; education; human health US Dollars`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity+Treatment_Group+Post_Treatment_Group, data = ID)
# model11<-lm(ID$`Other service activities US DOllars`~ Adult_Educ+Hours_Worked+Working_age_population+Labor_productivity+Treatment_Group+Post_Treatment_Group, data = ID)

# model12<-lm(ID$Labor_productivity~ Adult_Educ+Hours_Worked+Working_age_population+Treatment_Group+Post_Treatment_Group+Treatment_Group*Post_Treatment_Group, data = ID)

# summary(model1)

# modelsummary(list(model1,model2,model3,model4,model5,model6,model7,model8,model9,model10,model11,model12))

# summodel<-modelsummary(list(model1,model2,model3,model4,model5,model6,model7,model8,model9,model10,model11,model12))

# Emissions_Model<-lm(ID$Emission~GDP_per_capita+Labor_productivity+Freight_transport+Treatment_Group+Post_Treatment_Group, data=ID)
# summary(Emissions_Model)

# lm(Compiled$Emission~GDP_per_capita+Labor_productivity+Passenger_transport_ROAD+Passenger_Transport_RAIL+Freight_transport+Treatment_Groups+Post_Treatment_Group, data=Compiled)
# summary(Emissions_Model)
# tidy(Emissions_Model)

# summodel

# summary(model12)

# ggplot(aes(y=Hours_Worked,x=Year, color=Country),data = Compiled2)+geom_line()

# Compiled1<-Compiled%>%
#  filter(Country!= "UK", Country!="Ireland")
# Model12_1<-lm(Labor_productivity~ Adult_Educ+Hours_Worked+Working_age_population+Treatment_Groups+Post_Treatment_Group+Treatment_Groups*Post_Treatment_Group+Year, data = Compiled1)
# summary(Model12_1) 

# Compiled2<-Compiled1%>%
#   rename(AGUS=`Agriculture (US Dollars)`, EUS=`Energy US Dollars`, MUS=`Manufacture US Dollars`, CUS=`Construction US Dollars`, DUS=`Distributive trade, repairs; transport; accommod., food serv. US dollars`, ICUS=`Information and communication US Dollars`, FIUS=`Financial and insurance activities US Dollars`, REUS=`Real estate activities US Dollars`, PUS=`Prof., scientific, techn.; admin., support serv. activities US Dollars`, PUAUS=`Public admin.; compulsory s.s.; education; human health US Dollars`, OUS=`Other service activities US DOllars`)

# Compiled1

# True_Data<-Stupid%>%
#  filter(Country!= "UK", Country!="Ireland")

Plot_Data<-True_Data%>%
  filter(Country!='UK')
 

LM1<-lm(AGS~ Adult_Educ+Hours_Worked+Working_age_population+Treatment_Groups+Post_Treatment_Group+Treatment_Groups*Post_Treatment_Group+Year, data = Plot_Data)
tidy(LM1)
summary(LM1)
LM2<-lm(EUS~ Adult_Educ+Hours_Worked+Working_age_population+Treatment_Groups+Post_Treatment_Group+Treatment_Groups*Post_Treatment_Group+Year, data = Plot_Data)
tidy(LM2)
summary(LM2)
LM3<-lm(MUS~ Adult_Educ+Hours_Worked+Working_age_population+Treatment_Groups+Post_Treatment_Group+Treatment_Groups*Post_Treatment_Group+Year, data = Plot_Data)
tidy(LM3)
summary(LM3)
LM4<-lm(CUS~ Adult_Educ+Hours_Worked+Working_age_population+Treatment_Groups+Post_Treatment_Group+Treatment_Groups*Post_Treatment_Group+Year, data = Plot_Data)
modelsummary(LM4)
summary(LM4)
LM7<-lm(FIUS~ Adult_Educ+Hours_Worked+Working_age_population+Treatment_Groups+Post_Treatment_Group+Treatment_Groups*Post_Treatment_Group+Year, data = Plot_Data)
modelsummary(LM7)
summary(LM7)
LM8<-lm(REUS~ Adult_Educ+Hours_Worked+Working_age_population+Treatment_Groups+Post_Treatment_Group+Treatment_Groups*Post_Treatment_Group+Year, data = Plot_Data)
modelsummary(LM8)
summary(LM8)

LM13<-lm(data=Plot_Data, Emission~GDP_per_capita+Freight_transport+Material_Consumption+Treatment_Groups+Post_Treatment_Group+Treatment_Groups*Post_Treatment_Group+Year)
modelsummary(LM13)
summary(LM13)
LM14<-lm(Labor_productivity~ Adult_Educ+Hours_Worked+Working_age_population+Treatment_Groups+Post_Treatment_Group+Treatment_Groups*Post_Treatment_Group+Year, data = Plot_Data)
modelsummary(LM14)
summary(LM14)
modelsummary(list(LM1,LM2,LM3,LM4,LM7,LM8,LM13,LM14))

MW<-Data_MW%>%
  filter(Country!= "UK", Country!= "Ireland")

NN<-MW%>%
  rename(M_W='Municipal Waste')

Primary<-Data_Again%>%
  filter(Country!="UK", Country!="Ireland")

True_Data1.0<-True_Data%>%
  mutate(Agriculture_USD=Agriculture/10)

