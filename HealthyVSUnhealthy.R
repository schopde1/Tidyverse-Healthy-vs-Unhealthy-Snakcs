#install.packages("tidyverse")
install.packages("kableExtra", dependencies = TRUE)
library(tidyverse)
library(ggthemes)
library("readxl") 

rm(list = ls())

#Reading 
url <- "https://www.ers.usda.gov/webdocs/DataFiles/51035/caloricimpacts.xls?v=0"
Calorie_df <- read_excel("Data/caloricimpacts.csv", col_names = TRUE, col_types = NULL, na="",skip = 1 )
Calorie_df

url <- "https://www.ers.usda.gov/webdocs/DataFiles/51035/caloricimpacts.xls?v=0"
Calorie_df <- read.delim("Data/caloricimpacts.csv",header = TRUE, stringsAsFactors = FALSE, sep = ",",skip = 1)
Calorie_df

## Clean up the unnecessary rows based on BALNK 1st column (Unhealthy Snacks)
Calorie_df <- Calorie_df %>% filter(X != "" & X.1 != "")

## Remove unnecessary columns
Calorie_df <- Calorie_df %>% select(-X.1, -X.2)
Calorie_df <- Calorie_df %>% select(-contains("Average"))

names(Calorie_df)[1] <- "Unhealthy_Snack"


Calorie_df = Calorie_df %>% pivot_longer(names_to = "Healthy_Alternative", values_to = "Calories", -c("Unhealthy_Snack"))


#Clean up 'Unhealthy_Snack' column
Calorie_df$Unhealthy_Snack <-
  str_trim(
    ifelse(is.na(str_locate(Calorie_df$Unhealthy_Snack,"\\(")[,"start"]), Calorie_df$Unhealthy_Snack,str_sub(Calorie_df$Unhealthy_Snack, 1, str_locate(Calorie_df$Unhealthy_Snack,"\\(")[,"start"] - 1)
    )
  )

#Clean up 'Healthy_Alternative' column    
Calorie_df$Healthy_Alternative <-
  str_trim(
      ifelse(is.na(str_locate(Calorie_df$Healthy_Alternative,"\\(,")[,"start"]), Calorie_df$Healthy_Alternative,str_sub(Calorie_df$Healthy_Alternative, 1, str_locate(Calorie_df$Healthy_Alternative,"\\(,")[,"start"] - 1)
      )
    )

Calorie_df$Healthy_Alternative  <-
  str_trim(
    str_replace(
      ifelse(is.na(str_locate(Calorie_df$Healthy_Alternative ,"\\.\\.")[,"start"]), Calorie_df$Healthy_Alternative ,{str_sub(Calorie_df$Healthy_Alternative , 1, str_locate(Calorie_df$Healthy_Alternative ,"\\.\\.")[,"start"] - 1)}),"\\."," ")
  )



#Cleaning up cost CSV

#Reading 
url_cost <- "https://www.ers.usda.gov/webdocs/DataFiles/51035/costimpacts.xls?v=0"
Cost_df <- read.delim("Data/costimpacts.csv",header = TRUE, stringsAsFactors = FALSE, sep = ",",skip = 1)
Cost_df

## Clean up the unnecessary rows based on BALNK 1st column (Unhealthy Snacks)
Cost_df <- Cost_df %>% filter(X != "" & X.1 != "")

## Remove unnecessary columns
Cost_df <- Cost_df %>% select(-contains("X."))
Cost_df <- Cost_df %>% select(-contains("Total"))

names(Cost_df)[1] <- "Unhealthy_Snack"


Cost_df = Cost_df %>% pivot_longer(names_to = "Healthy_Alternative", values_to = "Cost", -c("Unhealthy_Snack"))


#Clean up 'Unhealthy_Snack' column
Cost_df$Unhealthy_Snack <-
  str_trim(
    ifelse(is.na(str_locate(Cost_df$Unhealthy_Snack,"\\(")[,"start"]), Cost_df$Unhealthy_Snack,str_sub(Cost_df$Unhealthy_Snack, 1, str_locate(Cost_df$Unhealthy_Snack,"\\(")[,"start"] - 1)
    )
  )

#Clean up 'Healthy_Alternative' column    
Cost_df$Healthy_Alternative <-
  str_trim(
    ifelse(is.na(str_locate(Cost_df$Healthy_Alternative,"\\(,")[,"start"]), Cost_df$Healthy_Alternative,str_sub(Cost_df$Healthy_Alternative, 1, str_locate(Cost_df$Healthy_Alternative,"\\(,")[,"start"] - 1)
    )
  )

Cost_df$Healthy_Alternative<-
  str_trim(
    str_replace(
      ifelse(is.na(str_locate(Cost_df$Healthy_Alternative,"\\.\\.")[,"start"]),
             Cost_df$Healthy_Alternative,{str_sub(Cost_df$Healthy_Alternative, 1, str_locate(Cost_df$Healthy_Alternative,"\\.\\.")[,"start"] - 1)}),"\\."," ")
  )

snackDataframe <- inner_join(Calorie_df,Cost_df)


#Healthy Snack Average Caloire impact

healthy_snack_DF <- snackDataframe %>% group_by(Healthy_Alternative) %>% summarise(Avg_Cal_Impact = mean(Calories),Total_Cost_impact = sum(Cost)) 

ggplot(healthy_snack_DF, aes(x = reorder(Healthy_Alternative,Avg_Cal_Impact), y = Avg_Cal_Impact)) + 
  geom_bar(stat = "identity", position = "dodge", fill = "steelblue") + 
  geom_text(aes(label=round(Avg_Cal_Impact,1)), hjust=-0.5, color="black", position = position_dodge(0.9), size=3.5) +
  scale_fill_brewer(palette="Paired") + 
  theme(axis.text.x=element_text(angle = 0, vjust = 0.5)) +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggtitle("Top Healthy Snack based on Average Calorie Impact") +
  xlab("Healthy Snack Alternative") +  ylab ("Average Calorie Impact") +
  coord_flip()

# Derive a Cost Impact indicator variable
healthy_snack_DF$Cost = ifelse(healthy_snack_DF$Total_Cost_impact >= 0, "above", "below")

ggplot(healthy_snack_DF, aes(x = reorder(Healthy_Alternative,Total_Cost_impact), y = Total_Cost_impact)) +
  geom_bar(stat = "identity", position = "dodge",aes(fill = Cost)) +
  scale_fill_manual(name="Cost Impact", 
                    labels = c("Less Expensive Substitue", "More Expensive Substitute"), 
                    values = c("above"="#00ba38", "below"="#f8766d")) + 
  ggtitle("Healthy Snack Alternatives based on Cost Impact") +
  theme(plot.title = element_text(hjust = 0.5),legend.position = "bottom") +
  xlab("Healthy Snack Alternative") +  ylab ("Total Cost Impact") +
  coord_flip()


