# In this script is used an alternative way to calculate
# the weighted arithmetic mean without using weighted.mean{stats} function
# Consider to delete environmental variables before running the script.

# Import data from the local csv file of passed exams.
passed_exams_data_frame <- read.csv("passed_exams.csv")

# Number of passed exams
number_of_passed_exams <- length(passed_exams_data_frame$Score)
number_of_passed_exams

# Initialization of the vector with the weighted scores
weighted_scores_vector <-c()

# Iteration of the dataframe for every passed exame
for (row_index in 1:number_of_passed_exams) {
  # Retrive exame score from the data frame
  score <- passed_exams_data_frame[row_index,2]
  # Retrive exame cfu from the data frame
  cfu <- passed_exams_data_frame[row_index,3]
  # Calculate the weighted score
  weighted_score <- score * cfu
  # Initializzation of the Index used to add item in the weighted score vector
  new_weighted_score_index <- row_index
  # Insertion of the weighted score inside the vector for future use
  weighted_scores_vector[new_weighted_score_index] <- weighted_score
}

# Caclulate weighted arithmetic mean apllying the formula
Weighted_arithmetic_mean <-
  sum(weighted_scores_vector)/sum(passed_exams_data_frame$CFU)

# Create Weighted mean string to show in console
weighted_mean_string <-
  paste(
    "Your weighted mean is: ",
    round(
      Weighted_arithmetic_mean,
      digits = 2
    ),
  sep = ""
  )

# Calculate base graduation score
base_graduation_score = (Weighted_arithmetic_mean * 110)/30

# Create base graduation score string to show in console 
base_graduation_score_string <-
  paste(
    "Your base graduation score is: ",
    round(base_graduation_score, digits = 2),
    sep = ""
  )

# Show results in console
message(weighted_mean_string,"\n",base_graduation_score_string)