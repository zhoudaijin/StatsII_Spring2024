
# Dataverse code for replication purposes
# for Ellinas & Lamprianou (2023) APSR paper

rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
gc() #free up memory and report the memory usage.

# Load libraries
library(tidyverse); packageVersion("tidyverse") # Library used for data handling and house keeping
library(lme4); packageVersion("lme4") # Library used for mixed effects models
library(sjPlot); packageVersion("sjPlot") # Library used to display results of lmer library
library(readxl); packageVersion("readxl") # Library necessary to read MS Excel files used for coding reliability
library(AER); packageVersion("AER") # Library necessary to the ivreg function for the 2-step regression (for instrument variable)


#----------------
# VERY IMPORTANT NOTE
# SET YOUR PATH TO YOUR DATA FOLDER HERE e.g. "C:/Users/Penny/Dropbox/RESEARCH" 
setwd("/Users/daisy/Desktop/Replication/dataverse_files_Movement versus Party") # Set working directory, depending on YOUR folder structure
#----------------


load("raw.Rda") # Loads data per event (N=4745 records)
# Explain variable names
# "Municipality" The code representing Municipalities (unique id) [Administrative data were obtained from ELSTAT; see note below]
# "code_perif" Second-level administrative region; each has a number of Municipalities
# "isGDevent"  Dichotomous, if TRUE then this record was coded as a Golden Dawn event
# "isAntifaevent" Dichotomous, if TRUE then this record was coded as an Antifa event
# "isAntifaeventViolence"  Dichotomous, if TRUE then Antifa used violence
#  "Proper_Date_n"  Arbitrary numeric value to split time into intervals - no specific meaning
#  "year"  Numeric, year of event



load("Municipality_Level.Rda") # Loads data per event (N=325 records representing 325 Greek Municipalities)
# Explain variable names
# "Municipality" The code representing Municipalities (unique id) [Administrative data were obtained from ELSTAT; see note below]
# "code_perif" Second-level administrative region; each has a number of Municipalities 
# "avg_age"  Average age of people living in a Municipality                      
# "log_population" The logarithm of the population per Municipality
# "prop_ksenoi" The proportion of non-greek citizens living in a Municipality 
# "Foitites"  The number of University students admitted through Pan-Hellenic exams per Department. This is used as a proxy of the number of students per Department. The data were manually collated per Municipality using as a source the examination results released by the Ministry of Education annually. For the purposes of this study, we used as a proxy the Examination results of 2020.  
# "logFoitites" The logarithm of the number of students where  dta$logFoitites <- log(dta$Foitites + 1)
# "pop_div_by1000" The population size per municipality divided by 1000 to make the variable more usable in regression models (avoid computational issues)
# "GD_BRANCHES_13_6_2012"   Dichotomous variable indicating whether the GD had a branch in a specific municipality in June 2012
# "apoxi_prc_May_2012"  Percentage of registered voters who did not vote in May 2012 elections             
# "apoxi_prc_2009"     Percentage of registered voters who did not vote in 2009 elections
# "prop_unempl"     Unemployment rate per municipality
# "ekloges_PERCENTAGE_2009_GD"    Electoral results of GD in the 2009 elections 
# "ekloges_PERCENTAGE_May_2012_GD" Electoral results of GD in  May 2012 elections    
# "ekloges_PERCENTAGE_Jun_2012_GD" Electoral results of GD in June 2009 elections    
# "ekloges_PERCENTAGE_Jan_2015_GD"   Electoral results of GD in January 2015 elections    
# "ekloges_PERCENTAGE_Sep_2015_GD"  Electoral results of GD in Sept 2015 elections    
# "ekloges_PERCENTAGE_Jul_2019_GD" Electoral results of GD in July 2019 elections    
# "ekloges_percentage_2009_SYRIZA"  Electoral results of Syriza in the 2009 elections  
# "ekloges_percentage_2009_KKE" Electoral results of KKE in the 2009 elections
# "ekloges_percentage_2009_ANTARSYA" Electoral results of Antarsya in the 2009 elections
# "N_AntifaEvent_BeforeOc09" Number of Antifa events per Municipality before October 2009 elections         
# "N_AntifaEvent_Oc09_May12" Number of Antifa events per Municipality between October 2009 and May 2012 elections
# "N_AntifaEvent_Oc09_Ju12" Number of Antifa events per Municipality between October 2009 and June 2012 elections 
# "N_AntifaEvent_May12_Ju12" Number of Antifa events per Municipality between May 2012 and June 2012 elections
# "N_AntifaEvent_Ju12_Ja15"   Number of Antifa events per Municipality between June 2012 and January 2015 elections         
# "N_AntifaEvent_Ja15_Sp15"  Number of Antifa events per Municipality between January 2015 and September 2015 elections
# "N_AntifaEvent_Sp15_Ju19" Number of Antifa events per Municipality between September 2015 and 2019 elections
# "N_AntifaEvent_notzero2_Oc09_May12" ORDINAL Number of Antifa events per Municipality between October 2009 and May 2012 elections
# "N_AntifaEvent_notzero2_Oc09_Ju12" ORDINAL Number of Antifa events per Municipality between October 2009 and June 2012 elections
# "N_AntifaEvent_notzero2_Ju12_Ja15" ORDINAL Number of Antifa events per Municipality between June 2012 and January 2015 elections
# "N_AntifaEvent_notzero2_Ja15_Sp15"  ORDINAL Number of Antifa events per Municipality between January 2015 and September 2015 elections  
# "N_AntifaEvent_notzero2_Sp15_Ju19"  ORDINAL Number of Antifa events per Municipality between September 2015 and 2019 elections
# "N_AntifaEvent_Oc09_May12_Tango01" DICHOTOMOUS Antifa TANGO events per Municipality between October 2009 and May 2012 elections
# "N_AntifaEvent_Ju12_Ja15_Tango01"  DICHOTOMOUS Antifa TANGO events per Municipality between June 2012 and January 2015 elections
# "N_AntifaEvent_Sp15_Ju19_Tango01" DICHOTOMOUS Antifa TANGO events per Municipality between September 2015 and 2019 elections
# "N_AntifaEvent_Oc09_May12_AB" PROXIMATE VS Number of Antifa events per Municipality between October 2009 and May 2012 elections; for more details see code for Appendix III table C 
# "N_AntifaEvent_Ju12_Ja15_AB"  PROXIMATE VS DISTANT Number of Antifa events per Municipality between June 2012 and January 2015 elections     
# "N_AntifaEvent_Sp15_Ju19_AB"  PROXIMATE VS DISTANT Number of Antifa events per Municipality between September 2015 and 2019 elections 
# "N_AntifaEvent_Oc09_May12_A"  PROXIMATE Number of Antifa events per Municipality between October 2009 and May 2012 elections
# "N_AntifaEvent_Oc09_May12_A01"  PROXIMATE DICHOTOMOUS  Antifa events per Municipality between October 2009 and May 2012 elections
# "N_AntifaEvent_Oc09_May12_B"   DISTANT Number of Antifa events per Municipality between October 2009 and May 2012 elections
# "N_AntifaEvent_Oc09_May12_B01" DISTANT DICHOTOMOUS Number of Antifa events per Municipality between October 2009 and May 2012 elections
# "N_AntifaEvent_Ju12_Ja15_A" PROXIMATE Number of Antifa events per Municipality between June 2012 and January 2015 elections       
# "N_AntifaEvent_Ju12_Ja15_A01"  PROXIMATE Number of Antifa events per Municipality between June 2012 and January 2015 elections
# "N_AntifaEvent_Ju12_Ja15_B" DISTANT Number of Antifa events per Municipality between June 2012 and January 2015 elections
# "N_AntifaEvent_Ju12_Ja15_B01" DISTANT DICHOTOMOUS Number of Antifa events per Municipality between June 2012 and January 2015 elections     
# "N_AntifaEvent_Sp15_Ju19_A"  PROXIMATE Number of Antifa events per Municipality between September 2015 and 2019 elections
# "N_AntifaEvent_Sp15_Ju19_A01" PROXIMATE DICHOTOMOUS Number of Antifa events per Municipality between September 2015 and 2019 elections
# "N_AntifaEvent_Sp15_Ju19_B"  DISTANT Number of Antifa events per Municipality between September 2015 and 2019 elections      
# "N_AntifaEvent_Sp15_Ju19_B01" DISTANT DICHOTOMOUS Number of Antifa events per Municipality between September 2015 and 2019 elections
# "N_AntViolEv_Ju12_Ja1501"  DICHOTOMOUS Antifa event per Municipality between June 2012 and January 2015
# "N_AntViolEv_Oc09_Ju1201" DICHOTOMOUS Antifa event per Municipality between October 2009 and June 2012

# Note: all administrative data (e.g. unemployment, age etc) were obtained by publicly available data repositories maintained by the Hellenic Statistical Authority, reached at https://www.statistics.gr/en/data-collection


head(dta)

sum(dta$N_AntifaEvent_BeforeOc09) # 266 protest events against the Greek far right organized before the elections of 4 October 2009


dta$N_AntifaEvent_BeforeOc09_dich <- as.factor(dta$N_AntifaEvent_BeforeOc09 > 0) # Recoding: Antifa events before October 2009 dichotomized (it is used in a model later)


# Table I: Basic linear models explaining electoral results of the GD (Regions as random effects; DV is the electoral results)
lmer12oMay <- lmer(ekloges_PERCENTAGE_May_2012_GD ~   ekloges_PERCENTAGE_2009_GD + N_AntifaEvent_notzero2_Oc09_May12 + avg_age + log_population  + prop_ksenoi  + (1|code_perif), data=dta)
lmer12o <- lmer(ekloges_PERCENTAGE_Jun_2012_GD ~      ekloges_PERCENTAGE_2009_GD +  N_AntifaEvent_notzero2_Oc09_Ju12   +   avg_age + log_population  +  prop_ksenoi + (1|code_perif), data=dta)
lmer15o <- lmer(ekloges_PERCENTAGE_Jan_2015_GD ~  ekloges_PERCENTAGE_Jun_2012_GD +   N_AntifaEvent_notzero2_Ju12_Ja15 +   avg_age + log_population  + prop_ksenoi  + (1|code_perif), data=dta)
lmer_15So <- lmer(ekloges_PERCENTAGE_Sep_2015_GD ~  ekloges_PERCENTAGE_Jan_2015_GD + N_AntifaEvent_notzero2_Ja15_Sp15 +  avg_age + log_population + prop_ksenoi + (1|code_perif), data=dta)
lmer19o <- lmer(ekloges_PERCENTAGE_Jul_2019_GD ~  ekloges_PERCENTAGE_Sep_2015_GD +   N_AntifaEvent_notzero2_Sp15_Ju19 +   avg_age + log_population  + prop_ksenoi  + (1|code_perif), data=dta)
tab_model(lmer12oMay, lmer12o, lmer15o, lmer_15So, lmer19o)
lmer12oMay <- NULL; lmer12o <- NULL; lmer15o <- NULL; lmer_15So <- NULL; lmer19o <- NULL # housekeeping


### Extension of daijin zhou ###
# Install and load required packages
install.packages("broom")
install.packages("sjPlot")
install.packages("stargazer")
library(broom)
library(sjPlot)
library(stargazer)

# Fit linear regression model instead of mixed effects models
lm12oMay <- lm(ekloges_PERCENTAGE_May_2012_GD ~   ekloges_PERCENTAGE_2009_GD + N_AntifaEvent_notzero2_Oc09_May12 + avg_age + log_population  + prop_ksenoi, data=dta)
lm12o <- lm(ekloges_PERCENTAGE_Jun_2012_GD ~      ekloges_PERCENTAGE_2009_GD +  N_AntifaEvent_notzero2_Oc09_Ju12   +   avg_age + log_population  +  prop_ksenoi, data=dta)
lm15o <- lm(ekloges_PERCENTAGE_Jan_2015_GD ~  ekloges_PERCENTAGE_Jun_2012_GD +   N_AntifaEvent_notzero2_Ju12_Ja15 +   avg_age + log_population  + prop_ksenoi , data=dta)
lm_15So <- lm(ekloges_PERCENTAGE_Sep_2015_GD ~  ekloges_PERCENTAGE_Jan_2015_GD + N_AntifaEvent_notzero2_Ja15_Sp15 +  avg_age + log_population + prop_ksenoi , data=dta)
lm19o <- lm(ekloges_PERCENTAGE_Jul_2019_GD ~  ekloges_PERCENTAGE_Sep_2015_GD +   N_AntifaEvent_notzero2_Sp15_Ju19 +   avg_age + log_population  + prop_ksenoi , data=dta)

# Generate LaTeX table
stargazer(lm12oMay, lm12o, lm15o, lm_15So, lm19o, 
          title="Extension forLinear Regression Models", 
          align=TRUE, 
          type="latex",
          out="lm_results_1.tex",
          font.size="small"
)

######


# Table II: Tango linear models explaining electoral gains of the GD (Regions as random effects; DV is the electoral results; Tango effects as a dichotomous variable)
lmer12MT01 <- lmer(ekloges_PERCENTAGE_May_2012_GD ~   ekloges_PERCENTAGE_2009_GD + N_AntifaEvent_Oc09_May12_Tango01 + avg_age + log_population + prop_ksenoi   + (1|code_perif), data=dta)
lmer15T01 <- lmer(ekloges_PERCENTAGE_Jan_2015_GD ~  ekloges_PERCENTAGE_Jun_2012_GD +  N_AntifaEvent_Ju12_Ja15_Tango01 +   avg_age + log_population + prop_ksenoi + (1|code_perif), data=dta)
lmer19T01 <- lmer(ekloges_PERCENTAGE_Jul_2019_GD ~  ekloges_PERCENTAGE_Sep_2015_GD + N_AntifaEvent_Sp15_Ju19_Tango01 +   avg_age + log_population + prop_ksenoi  + (1|code_perif), data=dta)
tab_model(lmer12MT01, lmer15T01, lmer19T01)
lmer12MT01 <- NULL;  lmer15T01 <- NULL; lmer19T01 <- NULL # housekeeping

### Extension of daijin zhou ###

# Fit linear regression model instead of mixed effects models
lm12MT01 <- lm(ekloges_PERCENTAGE_May_2012_GD ~   ekloges_PERCENTAGE_2009_GD + N_AntifaEvent_Oc09_May12_Tango01 + avg_age + log_population + prop_ksenoi, data=dta)
lm15T01 <- lm(ekloges_PERCENTAGE_Jan_2015_GD ~  ekloges_PERCENTAGE_Jun_2012_GD +  N_AntifaEvent_Ju12_Ja15_Tango01 +   avg_age + log_population + prop_ksenoi, data=dta)
lm19T01 <- lm(ekloges_PERCENTAGE_Jul_2019_GD ~  ekloges_PERCENTAGE_Sep_2015_GD + N_AntifaEvent_Sp15_Ju19_Tango01 +   avg_age + log_population + prop_ksenoi, data=dta)

# Generate LaTeX table
stargazer(lm12MT01, lm15T01, lm19T01, 
          title="Extension for Linear Regression Models ", 
          align=TRUE, 
          type="latex",
          out="lm_results_2.tex",
          font.size="small"
)

######


# Table III: Timing linear models explaining electoral gains of the GD (Regions as random ef-fects; DV is the electoral results; Timing effects as a categorical variable with four categories)
lmer12MΑΒ <- lmer(ekloges_PERCENTAGE_May_2012_GD ~   ekloges_PERCENTAGE_2009_GD + N_AntifaEvent_Oc09_May12_AB + avg_age + log_population  + prop_ksenoi+ (1|code_perif), data=dta)
lmer15ΑΒ <- lmer(ekloges_PERCENTAGE_Jan_2015_GD ~  ekloges_PERCENTAGE_Jun_2012_GD +   N_AntifaEvent_Ju12_Ja15_AB +   avg_age + log_population+ prop_ksenoi+ (1|code_perif), data=dta)
lmer19ΑΒ <- lmer(ekloges_PERCENTAGE_Jul_2019_GD ~  ekloges_PERCENTAGE_Sep_2015_GD +   N_AntifaEvent_Sp15_Ju19_AB +   avg_age + log_population + prop_ksenoi  + (1|code_perif), data=dta)
tab_model(lmer12MΑΒ, lmer15ΑΒ, lmer19ΑΒ)
lmer12MΑΒ <- NULL; lmer15ΑΒ <- NULL; lmer19ΑΒ <- NULL # housekeeping

### Extension of daijin zhou ###

# Fit linear regression model instead of mixed effects models
lm12MΑΒ <- lm(ekloges_PERCENTAGE_May_2012_GD ~   ekloges_PERCENTAGE_2009_GD + N_AntifaEvent_Oc09_May12_AB + avg_age + log_population  + prop_ksenoi, data=dta)
lm15ΑΒ <- lm(ekloges_PERCENTAGE_Jan_2015_GD ~  ekloges_PERCENTAGE_Jun_2012_GD +   N_AntifaEvent_Ju12_Ja15_AB +   avg_age + log_population+ prop_ksenoi, data=dta)
lm19ΑΒ <- lm(ekloges_PERCENTAGE_Jul_2019_GD ~  ekloges_PERCENTAGE_Sep_2015_GD +   N_AntifaEvent_Sp15_Ju19_AB +   avg_age + log_population + prop_ksenoi, data=dta)

# Generate LaTeX table
stargazer(lm12MΑΒ, lm15ΑΒ, lm19ΑΒ, 
          title="Extension for Linear Regression Models", 
          align=TRUE, 
          type="latex",
          out="lm_results_3.tex",
          font.size="small"
)

######


# Figure I. The distribution of protest events per year 
t <- raw %>% filter(isGDevent==TRUE & isAntifaevent==TRUE  ) %>% group_by(isGDevent, isAntifaevent, year) %>% count(); t <- as.data.frame(t)
tt <- raw %>% filter( !(isGDevent==TRUE & isAntifaevent==TRUE )    & isAntifaevent==TRUE ) %>% group_by( year) %>% count(); tt <- as.data.frame(tt)
mydata <- data.frame(t$year, tt$n, t$n); names(mydata) <- c("Year", "Solo_Events", "Tango_Events"); mydata <- mydata[!is.na(mydata$Year),]
x <- c("06&07", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019")
ggplot() + 
  geom_bar(mapping = aes(x =  as.character(mydata$Year) , y = mydata$Solo_Events), stat = "identity", fill = "white") +
  scale_y_continuous(name = "Number of ALL events") + scale_x_discrete(labels = x) +
  theme(    axis.title.y = element_text(color = "black" ),
            axis.title.y.right = element_text(color = "black")) + xlab("Time (year)") 
ggsave("FigureI.tiff", units="in", width=8, height=5, dpi=450, compression = 'lzw')
t <- NULL; tt <- NULL; mydata <- NULL # housekeeping


# Figure II. The six parliamentary elections contested by the Golden Dawn, define five intermediate periods of different intensity of protest. The figure was produced using information from Appendix III. Then, the data were appended in MS Excel to produce charts (e.g. pie charts) and everything was compiled in a standard drawing software to produce the arrangement shown in the figure.


raw %>% filter(isAntifaeventViolence==TRUE  & isAntifaevent==TRUE   & Proper_Date_n <= 2554 )  %>% count() # There were 285 events with violence, organized by Antifa, after the elections of 2009 but before the elections of 2019


# Figure III. The distribution of Tango protest events per year 
t <- raw %>% filter(isGDevent==TRUE & isAntifaevent==TRUE  ) %>% group_by(isGDevent, isAntifaevent, year) %>% count(); t <- as.data.frame(t)
tt <- raw %>% filter( !(isGDevent==TRUE & isAntifaevent==TRUE )   & isAntifaevent==TRUE ) %>% group_by( year) %>% count(); tt <- as.data.frame(tt)
mydata <- data.frame(t$year, tt$n, t$n); names(mydata) <- c("Year", "Solo_Events", "Tango_Events"); mydata <- mydata[!is.na(mydata$Year),]
mydata <- mydata[!is.na(mydata$Year),]
x <- c("06&07", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019")
ggplot(mydata, aes(x = factor(x))) +
  geom_col(aes(y = Solo_Events), fill = "white") +
  geom_line(aes(y = Tango_Events*7, group = 1), size = 2, color = "red") +
  scale_y_continuous(name = "Count of ALL events",
                     sec.axis = sec_axis(~./7, name = "Count of Tango events",
                                         labels = function(b) paste0(round(b), ""))) +  labs(x = "Time (Year)") +
  theme(axis.title.y = element_text(color = "black"),
        axis.title.y.right = element_text(color = "black"))
ggsave("FigureIII.tiff", units="in", width=8, height=5, dpi=450, compression = 'lzw')
t <- NULL; tt <- NULL; mydata <- NULL # housekeeping


# Figure IV was produced by extracting frequencies of events per period based on Appendix III. Then, the frequencies were used in MS Excel to produce bar charts which were combined in a standard drawing software to produce the final figure. 



# Code for Appendix I
DtaD <- read_excel("DtaD.xlsx") # Load dataset of first coder
DtaE <- read_excel("DtaE.xlsx") # Load dataset of second coder
# Explain variable names
# random: a unique number for each of the record (so that we can link DtaD to DtaE)
# Municipality: The code representing Municipalities (unique id) 
length(unique(DtaD$random2)); length(unique(DtaE$random2)) # Count of events identified by each coder
dcount <- DtaD %>% group_by(random2) %>% count() # Number of distinct events by first coder
ecount <- DtaE %>% group_by(random2) %>% count() # Number of distinct events by second coder
ed <- cbind(dcount, ecount); ed$same <- ed$random2...1 == ed$random2...3 # prepare data to run tests
nrow(DtaE) / nrow(DtaD) #1st Test
sunflowerplot(ed$n...2, ed$n...4, xlab="Coder1", ylab="Coder2"); cor.test(ed$n...2, ed$n...4) # 2nd test
dcount <- DtaD %>% group_by(Municipality) %>% count() # Number of events per Municipality by first coder
ecount <- DtaE %>% group_by(Municipality) %>% count() # Number of events per Municipality by second coder
ed <- merge(dcount, ecount, by="Municipality", all=TRUE); ed[is.na(ed$n.x), ]$n.x <- 0; ed[is.na(ed$n.y), ]$n.y <- 0 # merge datasets for tests
sunflowerplot(ed$n.x, ed$n.y, xlab="Coder1", ylab="Coder2"); cor.test(ed$n.x, ed$n.y) # 3rd test



# Code for Appendix II
tiff("Appendix_II.tiff", height = 5, width = 7, units = 'in', res=450)
par(mfrow=c(2,3))
hist(log(dta$N_AntifaEvent_Oc09_May12 +1), breaks=30, main="Protest events, Oct09 - May12", xlab="Logarithm of (Count of Events+1)")
hist(log(dta$N_AntifaEvent_May12_Ju12 +1), breaks=30, main="Protest events, May12 - June12", xlab="Logarithm of (Count of Events+1)") 
hist(log(dta$N_AntifaEvent_Ju12_Ja15+1), breaks=30, main="Protest events, June12 - Jan15",xlab="Logarithm of (Count of Events+1)") 
hist(log(dta$N_AntifaEvent_Ja15_Sp15+1), breaks=30, main="Protest events, Jan15 - Spt15",xlab="Logarithm of (Count of Events+1)")
hist(log(dta$N_AntifaEvent_Sp15_Ju19+1), breaks=30, main="Protest events, Spt15 - July19",xlab="Logarithm of (Count of Events+1)")
par(mfrow=c(1,1))
dev.off()


# Code for Appendix III
# Table A
sum(dta$N_AntifaEvent_Oc09_May12); table(dta$N_AntifaEvent_notzero2_Oc09_May12) # October 09 – May 12: the first line of the table; then the last three lines
sum(dta$N_AntifaEvent_May12_Ju12); table(dta$N_AntifaEvent_notzero2_May12_Ju12) # May 12 – June 12: lines same as above
sum(dta$N_AntifaEvent_Ju12_Ja15); table(dta$N_AntifaEvent_notzero2_Ju12_Ja15) # June 12 – January 15: lines same as above
sum(dta$N_AntifaEvent_Ja15_Sp15); table(dta$N_AntifaEvent_notzero2_Ja15_Sp15 )  #January 15 – September 15: lines same as above CORRECTION 277
sum(dta$N_AntifaEvent_Sp15_Ju19); table(dta$N_AntifaEvent_notzero2_Sp15_Ju19) # September 2015 – July 2019: lines same as above
# This confirms the total in Table A of Appendix III
sum(dta$N_AntifaEvent_Oc09_May12) + sum(dta$N_AntifaEvent_May12_Ju12) + sum(dta$N_AntifaEvent_Ju12_Ja15) + sum(dta$N_AntifaEvent_Ja15_Sp15) + sum(dta$N_AntifaEvent_Sp15_Ju19)  

# Table B
sum(dta$N_AntifaEvent_Oc09_May12_Tango); table(dta$N_AntifaEvent_Oc09_May12_Tango) # October 09 – May 12: first row; for the last row the sum of frequencies with non-zero values
sum(dta$N_AntifaEvent_May12_Ju12_Tango); table(dta$N_AntifaEvent_May12_Ju12_Tango) # May 12 – June 12: rows same as above
sum(dta$N_AntifaEvent_Ju12_Ja15_Tango ); table(dta$N_AntifaEvent_Ju12_Ja15_Tango) # June 12 – January 15: rows same as above
sum(dta$N_AntifaEvent_Ja15_Sp15_Tango ); table(dta$N_AntifaEvent_Ja15_Sp15_Tango) # January 15 – September 15: rows same as above
sum(dta$N_AntifaEvent_Sp15_Ju19_Tango ); table(dta$N_AntifaEvent_Sp15_Ju19_Tango) # September 2015 – July 2019; rows same as above

# Table C
# Upper part of Table (first two rows)
sum(dta$N_AntifaEvent_Oc09_May12_A); table(dta$N_AntifaEvent_Oc09_May12_A01);sum(dta$N_AntifaEvent_Oc09_May12_B); table(dta$N_AntifaEvent_Oc09_May12_B01) # for the period October 09 – May 12: Count of protest events of Proximate period (N of municipalities) and N of protest events and Distant period (N of municipalities)
sum(dta$N_AntifaEvent_Ju12_Ja15_A); table(dta$N_AntifaEvent_Ju12_Ja15_A01);sum(dta$N_AntifaEvent_Ju12_Ja15_B); table(dta$N_AntifaEvent_Ju12_Ja15_B01) # for the period June 12 – January 15: rows as above
sum(dta$N_AntifaEvent_Sp15_Ju19_A); table(dta$N_AntifaEvent_Sp15_Ju19_A01);sum(dta$N_AntifaEvent_Sp15_Ju19_B); table(dta$N_AntifaEvent_Sp15_Ju19_B01) # for the period September 2015 – July 2019: rows as above
# lower part of table under the heading 'N of municipalities: Event patterns for Distant and Proximate periods relative to elections'
# code '0-0' represents No distant – No recent protest events
# code '0-1' represents Only distant protest events
# code '1-0' represents  Only proximate protest events
# code '1-1' represents Both distant and proximate protest events
table(dta$N_AntifaEvent_Oc09_May12_AB) # for the period October 09 – May 12
table(dta$N_AntifaEvent_Ju12_Ja15_AB) # for the period June 12 – January 15
table(dta$N_AntifaEvent_Sp15_Ju19_AB) # for the period  September 2015 – July 2019


# Code for Appendix IV: The distribution of DV for each of the six Parliamentary Elections, including the baseline measure of October 2009
tiff("Appendix_IV.tiff", height = 5, width = 6, units = 'in', res=450)
par(mfrow=c(3,2))
hist(dta$ekloges_PERCENTAGE_2009_GD, breaks=20, main="October 2009 (baseline)", xlab="% of votes")
hist(dta$ekloges_PERCENTAGE_May_2012_GD, breaks=20, main="May 2012", xlab="% of votes")
hist(dta$ekloges_PERCENTAGE_Jun_2012_GD, breaks=20, main="July 2012", xlab="% of votes")
hist(dta$ekloges_PERCENTAGE_Jan_2015_GD, breaks=20, main="January 2015", xlab="% of votes")
hist(dta$ekloges_PERCENTAGE_Sep_2015_GD, breaks=20, main="September 2015", xlab="% of votes")
hist(dta$ekloges_PERCENTAGE_Jul_2019_GD, breaks=20, main="July 2019", xlab="% of votes")
par(mfrow=c(1,1))
dev.off()

# Code for Appendix V: The Pearson correlations between the electoral results of the GD for the six parliamentary elections. 
d <- dta[,c("ekloges_PERCENTAGE_2009_GD", "ekloges_PERCENTAGE_May_2012_GD", "ekloges_PERCENTAGE_Jun_2012_GD", "ekloges_PERCENTAGE_Jan_2015_GD", "ekloges_PERCENTAGE_Sep_2015_GD",  "ekloges_PERCENTAGE_Jul_2019_GD")]
names(d) <- c("E2009", "E2012M", "E2012J", "E2015Jan", "E2015Sept",  "E2019")
#sjp.corr(dta[,c("ekloges_PERCENTAGE_2009_GD", "ekloges_PERCENTAGE_Jun_2012_GD", "ekloges_PERCENTAGE_Jan_2015_GD", "ekloges_PERCENTAGE_Sep_2015_GD",  "ekloges_PERCENTAGE_Jul_2019_GD")])
tiff("Appendix_V.tiff", height = 5, width = 6, units = 'in', res=300)
sjp.corr(d, show.p = TRUE, sort.corr=TRUE)
dev.off()

# Code for Appendix VI: A summary of the main variables for each of the Models used in the study 
# No coded needed


# Code for Appendix VII: Testing for more control variables (protest events before 2009, unemployment, GD branches and abstention)
names(dta)[9] <- "apoxi_prc_May_2012" # Rename variable (more readable)
names(dta)[10] <- "apoxi_prc_2009" # Rename variable (more readable)
summary(lmer12oMay <- lmer(ekloges_PERCENTAGE_May_2012_GD ~   ekloges_PERCENTAGE_2009_GD + N_AntifaEvent_notzero2_Oc09_May12 + avg_age + log_population  + prop_ksenoi  + GD_BRANCHES_13_6_2012 + N_AntifaEvent_BeforeOc09_dich + prop_unempl+ apoxi_prc_May_2012 + (1|code_perif), data=dta)) 
tab_model(lmer12oMay )


# Code for Appendix VIII: Testing for more control variables (left-wing strongholds) 
lmer_12oPROP_SYR <- lmer(ekloges_PERCENTAGE_May_2012_GD ~   ekloges_PERCENTAGE_2009_GD +avg_age + log_population + prop_ksenoi + N_AntifaEvent_notzero2_Oc09_May12 +       ekloges_percentage_2009_SYRIZA    + (1|code_perif), data=dta)
lmer_12oPROP_KKE <- lmer(ekloges_PERCENTAGE_May_2012_GD ~   ekloges_PERCENTAGE_2009_GD +avg_age + log_population + prop_ksenoi + N_AntifaEvent_notzero2_Oc09_May12 +       ekloges_percentage_2009_KKE    + (1|code_perif), data=dta)
lmer_12oPROP_ANTAR <- lmer(ekloges_PERCENTAGE_May_2012_GD ~   ekloges_PERCENTAGE_2009_GD +avg_age + log_population + prop_ksenoi + N_AntifaEvent_notzero2_Oc09_May12 +       ekloges_percentage_2009_ANTARSYA    + (1|code_perif), data=dta)
tab_model(lmer_12oPROP_ANTAR, lmer_12oPROP_KKE, lmer_12oPROP_SYR )


# Code for Appendix IX: Testing for more control variables (Violence) 
summary(lmer12oVIOL <- lmer(ekloges_PERCENTAGE_Jun_2012_GD ~      ekloges_PERCENTAGE_2009_GD +  N_AntifaEvent_notzero2_Oc09_Ju12   +   avg_age + log_population  +  prop_ksenoi + N_AntViolEv_Oc09_Ju1201 + (1|code_perif), data=dta))
summary(lmer15oVIOL <- lmer(ekloges_PERCENTAGE_Jan_2015_GD ~  ekloges_PERCENTAGE_Jun_2012_GD +   N_AntifaEvent_notzero2_Ju12_Ja15 +   avg_age + log_population  + prop_ksenoi  + N_AntViolEv_Ju12_Ja1501 + (1|code_perif), data=dta))
tab_model(  lmer12oVIOL, lmer15oVIOL)


# Code for Appendix X: Assumptions of models
tiff("Appendix_Xa.tiff", height = 5, width = 8, units = 'in', res=300)
plot_model(lmer12oMay, type="diag")[[1]]
dev.off()
tiff("Appendix_Xb.tiff", height = 5, width = 8, units = 'in', res=300)
plot_model(lmer12oMay, type="diag")[[2]]
dev.off()
tiff("Appendix_Xc.tiff", height = 5, width = 8, units = 'in', res=300)
plot_model(lmer12oMay, type="diag")[[3]]
dev.off()


# Code Appendix XI: We used the official release of the results of the Pan-Hellenic University entrance examinations 
tiff("Appendix_XI.tiff", height = 5, width = 8, units = 'in', res=300)
hist(dta$logFoitites, main="", xlab="log(N of students)")
dev.off()


# Code for Appendix XII: The instrumental variable 
cor.test(dta$Foitites  , dta$N_AntifaEvent_Sp15_Ju19)
cor.test(dta$Foitites  , dta$N_AntifaEvent_Ju12_Ja15)
cor.test(dta$Foitites  , dta$N_AntifaEvent_Oc09_Ju12); cor.test(dta$Foitites  , dta$N_AntifaEvent_Oc09_Ju12, method="spearman"  ) #CORRECTION 0.61
d <- dta[dta$N_AntifaEvent_Sp15_Ju19 < 400 & dta$Foitites<7000,]; cor.test(d$Foitites  , d$N_AntifaEvent_Oc09_Ju12) 
# ivreg
summary(reg_12mN <- ivreg(ekloges_PERCENTAGE_May_2012_GD ~ ekloges_PERCENTAGE_2009_GD + log_population  + avg_age + N_AntifaEvent_Oc09_May12  |  ekloges_PERCENTAGE_2009_GD + log_population  + avg_age + Foitites , data = dta), diagnostics=TRUE); tab_model(reg_12mN)
summary(reg_12jN <- ivreg(ekloges_PERCENTAGE_Jun_2012_GD ~ ekloges_PERCENTAGE_2009_GD + log_population + avg_age + N_AntifaEvent_Oc09_Ju12 |  ekloges_PERCENTAGE_2009_GD + log_population + avg_age + Foitites , data = dta), diagnostics=TRUE); tab_model(reg_12jN)
summary(reg_J15N <- ivreg(ekloges_PERCENTAGE_Jan_2015_GD ~ ekloges_PERCENTAGE_Jun_2012_GD + log_population + avg_age + N_AntifaEvent_Ju12_Ja15  |  ekloges_PERCENTAGE_Jun_2012_GD + log_population + avg_age + Foitites , data = dta), diagnostics=TRUE); tab_model(reg_J15N)


                     
# Code for Appendix XIII:additional robustness checks
dta$zE12 <- scale(dta$ekloges_PERCENTAGE_May_2012_GD); dta$zEJ15 <- scale(dta$ekloges_PERCENTAGE_Jan_2015_GD); dta$zES15 <- scale(dta$ekloges_PERCENTAGE_Sep_2015_GD); dta$zEJ19 <- scale(dta$ekloges_PERCENTAGE_Jul_2019_GD) # This is to scale the variables

dta2 <- dta %>% select(Municipality, zE12, zEJ15, zES15, zEJ19); names(dta2) <- c("Municipality", "E12", "EJ15", "ES15", "EWJ19") #Collect the interesting variables in a single simpler dataset
zElPrc_long <- reshape2::melt(data = dta2,   id.vars = c("Municipality"),  variable.name = "Elections", value.name = "zElPrc"); dta2 <- NULL #Create 'long' version of the dataset

dta2 <- dta %>% select(Municipality, ekloges_PERCENTAGE_May_2012_GD, ekloges_PERCENTAGE_Jan_2015_GD, ekloges_PERCENTAGE_Sep_2015_GD, ekloges_PERCENTAGE_Jul_2019_GD); names(dta2) <- c("Municipality", "E12", "EJ15", "ES15", "EWJ19")
ElPrc_long <- reshape2::melt(data = dta2,   id.vars = c("Municipality"),  variable.name = "Elections", value.name = "ElPrc"); dta2 <- NULL; 

dta2 <- dta %>% select(Municipality, N_AntifaEvent_notzero2_Oc09_May12, N_AntifaEvent_notzero2_Ju12_Ja15, N_AntifaEvent_notzero2_Ja15_Sp15, N_AntifaEvent_notzero2_Sp15_Ju19); names(dta2) <- c("Municipality", "E12", "EJ15",  "ES15", "EWJ19")
Act_o_long <- reshape2::melt(data = dta2,   id.vars = c("Municipality"),  variable.name = "Elections", value.name = "Act_o"); dta2 <- NULL; 

dta2 <- merge(ElPrc_long, zElPrc_long, by=c("Municipality", "Elections")) 
dta2 <- merge(dta2, Act_o_long, by=c("Municipality", "Elections"))

dta2d <- dta %>% select(Municipality,  code_perif, log_population, avg_age,  ekloges_PERCENTAGE_2009_GD,ekloges_PERCENTAGE_Jun_2012_GD, ekloges_PERCENTAGE_Jan_2015_GD, ekloges_PERCENTAGE_Sep_2015_GD, ekloges_PERCENTAGE_Jul_2019_GD,  prop_ksenoi) # Add some background variables to use in the models later

dta2 <- merge(dta2, dta2d, by="Municipality"); dta2d <- NULL; #View(dta2)
dta2$PrevEl <- 1; dta2[dta2$Elections=="EWJ19",]$PrevEl <- dta2[dta2$Elections=="EWJ19",]$ekloges_PERCENTAGE_Sep_2015_GD; dta2[dta2$Elections=="ES15",]$PrevEl <- dta2[dta2$Elections=="ES15",]$ekloges_PERCENTAGE_Jan_2015_GD; dta2[dta2$Elections=="EJ15",]$PrevEl <- dta2[dta2$Elections=="EJ15",]$ekloges_PERCENTAGE_Jun_2012_GD; 
dta2[dta2$Elections=="E12",]$PrevEl <- dta2[dta2$Elections=="E12",]$ekloges_PERCENTAGE_2009_GD

dta2 <- dta2 %>% filter(!is.na(avg_age)) # removing missing records for age
dta2 <- dta2 %>% group_by(Elections) %>% mutate(zPre = scale(PrevEl), zElPrc=scale(ElPrc)) # Scale electoral results of previous elections

# This is the scaled model (standardized variables) 
summary(tt1z <- lmer(zElPrc ~   zPre + Elections + Act_o + avg_age + log_population  + prop_ksenoi + (1|code_perif), data=dta2))
summary(tt2z <- lmer(zElPrc ~   zPre + Elections * Act_o + avg_age + log_population + prop_ksenoi + (1|code_perif), data=dta2)); tab_model(tt2z)
anova(tt1z, tt2z) # compare the two models; is the interaction effect necessary?


# Section on Data Linkage
# ----------------------------------------------------

# Important note for data linkage: You do NOT need to follow the following instructions for data replication purposes. This section is useful ONLY in the case you wish to search and download demographic or administrative databases of the Greek government, to enrich the data we have made available in Dataverse.

# Here, we explain, how to link our data to the official demographic and administrative data
# released by the Ministry of Interior (Ypoyrgeio Esoterikon) and ELSTAT (Hellenic Statistial Authority)
# For example, visit the following URL to find more information on Greek geodata, municipality geographic boundaries
# https://geodata.gov.gr/en/dataset/oria-demon-kapodistriakoi/resource/85e99e0e-1503-4dbe-835b-3c42c3d95235
# For the electoral results, please visit
# https://ekloges.ypes.gr/en
# ELSTAT (https://www.statistics.gr/) 

# First you need to load the file "elstat_ypes.Rda"
# load("elstat_ypes.Rda")

# Explain variable names of elstat_ypes.Rda

# "Municipality" The code representing Municipalities (unique id) [Administrative data were obtained from ELSTAT; see note below]. If you want to link the file "elstat_ypes.Rda" to the file "Municipality_Level.Rda", you need to use this variable. 
# "KWD_YPES" An arbitrary code used by ELSTAT/YPES in pertinent files
# "kall_DimosELSTATCode" An arbitrary code used by ELSTAT/YPES in pertinent files
# "kall_Dimos" The name of Kallikraticos municipality
# "kall_DimosCode" Another code often used by ELSTAT/YPES in pertinent files - you may find this useful as well in some databases released by the Greek government
# "code_perif" Second-level administrative region; each has a number of Municipalities 


