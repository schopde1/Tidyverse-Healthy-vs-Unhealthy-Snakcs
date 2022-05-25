# Tidyverse-Healthy-vs-Unhealthy-Snakcs

### **Background:**
This data source was taken from the USDA website. There are two datasets that have been used here. One is related to impact on food calories when Unhealthy snacks are substituted with Healthy snacks. The other is related to impact on cost when Unhealthy snacks are substituted with Healthy snacks.  

### **Data Sources:**
[Calorie Impact Sheet](https://www.ers.usda.gov/webdocs/DataFiles/51035/caloricimpacts.xls?v=0)  
[Cost Impact Sheet](https://www.ers.usda.gov/webdocs/DataFiles/51035/costimpacts.xls?v=0)  

### **Variable Description:**
*Calorie Impact Sheet:*  
* The first column contains a list of Unhealthy Snacks.  
* Rest of the columns have different Healthy Snack as headers and the values in each cell are the calorie impact.  

*Cost Impact Sheet:*  
* The first column contains a list of Unhealthy Snacks.  
* Rest of the columns have different Healthy Snack as headers and the values in each cell are the cost impact.  

Loading the required Libraries. Reading the two excel caloricimpacts.xls and costimpacts.xls and storing it as Data frames.  

### **Clean up Data Set:**  

As we observed in above data frames, the data set is extremely untidy and very difficult to read. All Healthy snacks are spread across multiple columns and have separate columns names and calories value are spread across multiple rows as values. Unhealthy snacks are present without a significant column name.  
We need to gather all healthy snack under one column and all calorie value under one column. We also need to drop certain columns and rows which have incomplete data and rename a few columns.  


##### **Tidy Dataset**  

The above data set is tidy where each variable has its own columns, each observation has its own row and each value has its own cell. Now variable 'Healthy_Alternatives' has all health alternative snacks under its column and 'Calories' and 'Cost' has Calories and cost values respectively under that column name which was spread across the worksheet earlier.  

##### **Variable Description:**  
*Calorie Impact Data frame:*   
* Unhealthy_Snack - Range of different unhealthy snacks.  
* Healthy_Alternative - Range of different healthy fruits and vegetables.  
* Calories - Calories impact when switched from unhealthy to healthy alternative.  

*Cost Impact Data frame:*  
* Unhealthy_Snack - Range of different unhealthy snacks.  
* Healthy_Alternative - Range of different healthy fruits and vegetables.  
* Cost - Cost impact when switched from unhealthy to healthy alternative.  

*Merged Snack Data frame:*  
* Unhealthy_Snack - Range of different unhealthy snacks.  
* Healthy_Alternative - Range of different healthy fruits and vegetables.  
* Calories - Calories impact when switched from unhealthy to healthy alternative.  
* Cost - Cost impact when switched from unhealthy to healthy alternative.

#### **CONCLUSION**

* From the range of vegetables Celery, Broccoli and Carrots one of the most Calorie contributing healthy snack alternatives and more affordable than unhealthy snacks.
* Tomatoes are good when it comes to calorie impact but are more expensive that the unhealthy snack option.
* From the range of fruits Plums, Oranges, Applesauce, Grapes are one of the most Calorie contributing healthy snack alternatives and more affordable than unhealthy snacks.
* Strawberries, Cantaloupes and Apples are good when it comes to calorie impact but are more expensive that the unhealthy snack option.
