# ============================================================
# WEEK 2: DATA VISUALIZATION AND INSIGHT COMMUNICATION USING R
# Project: Titanic Passenger Dataset
# Internship: Virtual R Data Analyst Internship - Yuva Learn
# ============================================================

# Run this script from the Week2_R_Data_Visualization project root.
# Required packages:
# install.packages(c("ggplot2", "dplyr", "tidyr", "scales", "corrplot"))

library(ggplot2)
library(dplyr)
library(tidyr)
library(scales)
library(corrplot)

dir.create("Graphs", showWarnings = FALSE)
dir.create("Outputs", showWarnings = FALSE)

# 1. Load the cleaned dataset from Week 1 ----------------------------
data_file <- "Dataset/Cleaned_Dataset.csv"
if (!file.exists(data_file)) {
  stop("Cleaned_Dataset.csv not found. Place the Week 1 cleaned dataset in Dataset/.")
}
titanic <- read.csv(data_file, stringsAsFactors = FALSE)
titanic$Survived <- factor(titanic$Survived, levels = c("No", "Yes"))
titanic$Pclass <- factor(titanic$Pclass, levels = c("First", "Second", "Third"))
titanic$Sex <- factor(titanic$Sex)
titanic$Embarked <- factor(titanic$Embarked)

# Create age groups for chart 10
titanic <- titanic %>%
  mutate(Age_Group = cut(Age,
    breaks = c(0, 12, 18, 30, 45, 60, Inf),
    labels = c("0-12", "13-18", "19-30", "31-45", "46-60", "61+"),
    include.lowest = TRUE
  ))

# 2. Summary statistics ------------------------------------------------
summary_stats <- titanic %>%
  summarise(
    Passenger_Records = n(),
    Survivors = sum(Survived == "Yes"),
    Non_Survivors = sum(Survived == "No"),
    Overall_Survival_Rate = mean(Survived == "Yes")
  )
write.csv(summary_stats, "Outputs/Visualization_Summary_Statistics.csv", row.names = FALSE)

survival_by_sex <- titanic %>%
  group_by(Sex) %>%
  summarise(Passengers = n(), Survival_Rate = mean(Survived == "Yes"), .groups = "drop")
write.csv(survival_by_sex, "Outputs/Survival_By_Sex.csv", row.names = FALSE)

survival_by_class <- titanic %>%
  group_by(Pclass) %>%
  summarise(Passengers = n(), Survival_Rate = mean(Survived == "Yes"), .groups = "drop")
write.csv(survival_by_class, "Outputs/Survival_By_Class.csv", row.names = FALSE)

# Common plot theme
theme_set(theme_minimal(base_size = 12))

# 3. Chart 1: Survival distribution ------------------------------------
p1 <- ggplot(titanic, aes(x = Survived, fill = Survived)) +
  geom_bar(show.legend = FALSE) +
  geom_text(stat = "count", aes(label = after_stat(count)), vjust = -0.4) +
  labs(title = "Passenger Survival Distribution",
       x = "Survival status", y = "Number of passengers")
ggsave("Graphs/01_Survival_Distribution.png", p1, width = 8, height = 5, dpi = 300)

# 4. Chart 2: Age histogram ---------------------------------------------
p2 <- ggplot(titanic, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "steelblue", color = "white") +
  labs(title = "Passenger Age Distribution", x = "Age (years)", y = "Frequency")
ggsave("Graphs/02_Age_Histogram.png", p2, width = 8, height = 5, dpi = 300)

# 5. Chart 3: Survival proportion by sex --------------------------------
p3 <- ggplot(titanic, aes(x = Sex, fill = Survived)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = percent) +
  labs(title = "Survival Proportion by Sex", x = "Sex", y = "Proportion",
       fill = "Survived")
ggsave("Graphs/03_Survival_By_Gender.png", p3, width = 8, height = 5, dpi = 300)

# 6. Chart 4: Fare by passenger class -----------------------------------
p4 <- ggplot(titanic, aes(x = Pclass, y = Fare, fill = Pclass)) +
  geom_boxplot(show.legend = FALSE, outlier.alpha = 0.35) +
  labs(title = "Fare Distribution by Passenger Class",
       x = "Passenger class", y = "Fare")
ggsave("Graphs/04_Fare_By_Class_Boxplot.png", p4, width = 8, height = 5, dpi = 300)

# 7. Chart 5: Age vs fare scatter plot ----------------------------------
p5 <- ggplot(titanic, aes(x = Age, y = Fare, color = Survived)) +
  geom_point(alpha = 0.55) +
  labs(title = "Passenger Age vs Fare", x = "Age (years)", y = "Fare",
       color = "Survived")
ggsave("Graphs/05_Age_vs_Fare_Scatter.png", p5, width = 8, height = 5, dpi = 300)

# 8. Chart 6: Survival proportion by passenger class --------------------
p6 <- ggplot(titanic, aes(x = Pclass, fill = Survived)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = percent) +
  labs(title = "Survival Proportion by Passenger Class",
       x = "Passenger class", y = "Proportion", fill = "Survived")
ggsave("Graphs/06_Survival_By_Class.png", p6, width = 8, height = 5, dpi = 300)

# 9. Chart 7: Age density by survival -----------------------------------
p7 <- ggplot(titanic, aes(x = Age, color = Survived, fill = Survived)) +
  geom_density(alpha = 0.18) +
  labs(title = "Age Density by Survival Status",
       x = "Age (years)", y = "Density", color = "Survived", fill = "Survived")
ggsave("Graphs/07_Age_Density_By_Survival.png", p7, width = 8, height = 5, dpi = 300)

# 10. Chart 8: Correlation heatmap --------------------------------------
numeric_data <- titanic %>% select(Age, SibSp, Parch, Fare)
cor_matrix <- cor(numeric_data, use = "pairwise.complete.obs")
write.csv(cor_matrix, "Outputs/Correlation_Matrix.csv")
png("Graphs/08_Correlation_Heatmap.png", width = 1800, height = 1500, res = 220)
corrplot(cor_matrix, method = "color", type = "upper",
         addCoef.col = "black", tl.col = "black", tl.srt = 35,
         title = "Correlation Heatmap", mar = c(0, 0, 2, 0))
dev.off()

# 11. Chart 9: Survival by embarkation port ------------------------------
p9 <- ggplot(titanic, aes(x = Embarked, fill = Survived)) +
  geom_bar(position = "fill") +
  scale_y_continuous(labels = percent) +
  labs(title = "Survival Proportion by Embarkation Port",
       x = "Embarkation port", y = "Proportion", fill = "Survived")
ggsave("Graphs/09_Survival_By_Embarked.png", p9, width = 8, height = 5, dpi = 300)

# 12. Chart 10: Survival rate by age group -------------------------------
age_survival <- titanic %>%
  group_by(Age_Group) %>%
  summarise(Passengers = n(),
            Survival_Rate = mean(Survived == "Yes"),
            .groups = "drop")
write.csv(age_survival, "Outputs/Survival_By_Age_Group.csv", row.names = FALSE)

p10 <- ggplot(age_survival, aes(x = Age_Group, y = Survival_Rate, group = 1)) +
  geom_line(color = "steelblue", linewidth = 1) +
  geom_point(size = 2.5) +
  scale_y_continuous(labels = percent, limits = c(0, 1)) +
  labs(title = "Survival Rate by Age Group",
       x = "Age group (years)", y = "Survival rate")
ggsave("Graphs/10_Survival_Rate_By_Age_Group.png", p10, width = 8, height = 5, dpi = 300)

# 13. Export grouped survival results ----------------------------------
survival_by_embarked <- titanic %>%
  group_by(Embarked) %>%
  summarise(Passengers = n(), Survival_Rate = mean(Survived == "Yes"),
            .groups = "drop")
write.csv(survival_by_embarked, "Outputs/Survival_By_Embarked.csv", row.names = FALSE)

cat("Week 2 visualization project completed.\n")
cat("Review Graphs/ and Outputs/ for generated files.\n")
