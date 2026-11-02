# Titanic Data Visualization and Insight Communication Using R

**Virtual R Data Analyst Internship | Yuva Learn Platform | Week 2**

## Project overview
This project uses the cleaned Titanic passenger dataset from Week 1 to create ten visualizations and communicate patterns in survival, passenger age, fare, passenger class, sex, embarkation port and selected numerical variables.

## Dataset
- 891 passenger records
- 15 columns in the Week 1 cleaned analysis file
- Source context: Kaggle Titanic passenger survival dataset
- Dataset file: `Dataset/Cleaned_Dataset.csv`

## Tools
- R and RStudio
- ggplot2
- dplyr
- scales
- corrplot
- Base R graphics for export support

## Visualizations
1. Passenger survival distribution (bar chart)
2. Passenger age distribution (histogram)
3. Survival proportion by sex (100% stacked bar chart)
4. Fare distribution by passenger class (boxplot)
5. Passenger age vs fare (scatter plot)
6. Survival proportion by passenger class (100% stacked bar chart)
7. Age density by survival status (density plot)
8. Correlation heatmap (Age, SibSp, Parch, Fare)
9. Survival proportion by embarkation port (100% stacked bar chart)
10. Survival rate by age group (line chart)

## Run the project
1. Install R and RStudio.
2. Open this folder as the project working directory.
3. Install required packages:
   `install.packages(c("ggplot2", "dplyr", "tidyr", "scales", "corrplot"))`
4. Open `R_Code/Week2_Data_Visualization.R`.
5. Run the full script.
6. Review the generated images in `Graphs/` and CSV summaries in `Outputs/`.

## Key results from the dataset
- 891 passenger records were analyzed.
- 342 passengers survived and 549 did not.
- Overall survival proportion: approximately 38.38%.
- Female survival proportion: approximately 74.20%.
- Male survival proportion: approximately 18.89%.
- First-class survival proportion: approximately 62.96%.
- Second-class survival proportion: approximately 47.28%.
- Third-class survival proportion: approximately 24.24%.

These are descriptive associations in the training dataset and do not establish causation.

## Folder structure
- `Dataset/` - cleaned dataset used for visualization
- `R_Code/` - complete R source code
- `Graphs/` - ten high-resolution PNG charts
- `Outputs/` - summary tables and correlation outputs
- `Report/` - Word report

## Internship details
Week 2 task: Data Visualization and Insight Communication using R.
Organization: Yuva Learn Platform, Pune.

## Author
[Your Full Name]
