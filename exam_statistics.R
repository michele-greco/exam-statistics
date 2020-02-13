# Consider to delete environmental variables before running the script.

# Library Used for 3D Pie Chart
library(plotrix)

# Import data from the local csv file of the passed exams
# named passed_exams.csv
passed_exams_data_frame <- read.csv("passed_exams.csv")

# Display the passed exams data frame in a spreadsheet-like fashion 
View(passed_exams_data_frame)

# Calculate the number of past exams
number_of_passed_exams <- length(passed_exams_data_frame$Score)

# Calculate weighted arithmetic mean with the R function of the stats package
# For info about the function type the following code in terminal: ?weighted.mean
Weighted_arithmetic_mean <- weighted.mean(
  passed_exams_data_frame$Score,
  passed_exams_data_frame$CFU
)

# Group and count Scores
counted_scores <- table(passed_exams_data_frame$Score)
# Calculate most frequent score occurrency
most_frequent_score_occurrency <- max(counted_scores)

# Initialize score percentage vector
score_percentage_vector <- c()
score_percentage_vector_index <- 1

# Calculate scores percentage
for (count in counted_scores) {
  # Score percentage insertion in the dedicated vector
  score_percentage_vector[score_percentage_vector_index] <-
    count/number_of_passed_exams*100
  # Index Increment for the percentage insertion
  score_percentage_vector_index <- score_percentage_vector_index + 1
}

# Format decimal numbers for graphical representation
score_percentage_vector <- format(
  as.list(score_percentage_vector),
  digits=2,
  nsmall=2
)

# Create labels with percentage for scores frequency pie charts
score_percentage_pie_chart_labels <- 
  paste(
    sort(unique(passed_exams_data_frame$Score)),
    " = ",
    score_percentage_vector,
    "%",
    sep=""
  )

# Create color vector for 2D Pie Chart
two_dimensional_pie_chart_colors_vector <- c(
  "gray8",
  "gray39",
  "firebrick2",
  "darkorange1",
  "goldenrod1",
  "deeppink2",
  "purple2",
  "royalblue2",
  "steelblue2",
  "turquoise2",
  "springgreen2",
  "seagreen1",
  "chartreuse1"
)

# Show 2D score frequency pie chart 
pie(
  sort(unique(passed_exams_data_frame$Score)),
  labels = score_percentage_pie_chart_labels,
  main = "2D Score Frequency Pie Chart",
  col = two_dimensional_pie_chart_colors_vector
)

# Show 3D score frequency pie chart 
pie3D(
  sort(unique(passed_exams_data_frame$Score)),
  labels = score_percentage_pie_chart_labels,
  explode = 0.05,
  main = "3D Score Frequency Pie Chart",
  labelcex = 0.9,
  radius = 0.9
)

# Create score frequency histogram based on maximum score occurrency function
show_responsive_passed_exams_histogram <- function(most_frequent_score_occurrency) {
  hist(
    main = "Score Frequency Histogram",
    passed_exams_data_frame$Score,
    breaks = 24,
    xaxt = "n",
    yaxt = "n",
    xlim = c(18, 32),
    ylim = c(0, most_frequent_score_occurrency + 3),
    xlab="Scores",
    col = "lightblue",
    border = "white"
  )
  
  # Add custom x axis to the histogram 
  axis(
    side = 1, 
    at = seq(18,32,1), 
    labels = seq(18,32,1),
    tck=-.05,
    tcl = -.40
  )
  
  # Add custom y axis to the histogram
  axis(
    side = 2, 
    at = seq(0, most_frequent_score_occurrency + 3, 1), 
    labels = seq(0, most_frequent_score_occurrency + 3, 1),
    tck = -.05,
    tcl = -.40,
    cex.axis = 0.7
  )
}

# Show the responsive score frequency histogram
show_responsive_passed_exams_histogram(most_frequent_score_occurrency)

# Add horizontal lines for references to histogram
horizontal_lines_coordinates_vector <- seq(0, 100, 1)
for (horizontal_line_index in horizontal_lines_coordinates_vector) {
  abline(
    h = horizontal_line_index,
    col = "lightgrey"
  )
}

# Add the Vertical line to the histogram representing weighted arithmetic mean
abline(
  v = Weighted_arithmetic_mean,
  col = "coral"
)

# Add legend to the histogram
legend(
  "topleft",
  legend = paste(
    "Weighted Arithmetic Mean = ",
    format(
      Weighted_arithmetic_mean,
      digits=2,
      nsmall=2
    ),
    sep = " "
  ),
  col = c("red"),
  lty = 1,
  cex=0.8
)

# Calculate 5NS values minimum and maximum score extraction
five_number_summary <- summary(passed_exams_data_frame$Score)
# Creation of the output minimum and maximum score
output_minimum_and_maximum <- paste(
  "Minimum Score: ",
  five_number_summary[1],
  "\n",
  "Maximum Score: ",
  five_number_summary[6],
  sep = ""
)

# Create the output string for the weighted mean
output_weighted_mean <- paste(
  "Your weighted mean is: ",
  round(Weighted_arithmetic_mean, digits = 2),
  sep = ""
)

# Calculate base graduation score
base_graduation_score = (Weighted_arithmetic_mean * 110)/30 

# Creation of the output string for the base_graduation_score
output_base_graduation_score <- paste(
  "Your base graduation score is: ",
  round(base_graduation_score, digits = 2),
  sep = ""
)

# Create the output string for grouped and counted value

# Initialize names vector of the grouped and organized scores
grouped_scores_names_vector <- names(counted_scores)
# Initialize output grouped and counted scored vector
output_grouped_scores_vector <- c()
# Initialize index used to get data from output_grouped_scores_vector
grouped_score_names_index <- 1
# Iterate to fill output_grouped_scores_vector vector
for (counted_score in counted_scores) {
  # Check for the need to use the word "time" or "times
  # based on the occurrency number of the score.
  if(counted_scores[grouped_score_names_index] > 1){
    output_grouped_scores_vector[grouped_score_names_index] <-
      paste(
        "The score ",
        grouped_scores_names_vector[grouped_score_names_index],
        " was obtained ",
        counted_scores[grouped_score_names_index],
        " times"
      )
  } else {
    output_grouped_scores_vector[grouped_score_names_index] <-
      paste(
        "The score ",
        grouped_scores_names_vector[grouped_score_names_index],
        " was obtained ",
        counted_scores[grouped_score_names_index],
        " time"
      )
  }
  # Increment index used to get data from output_grouped_score_names_vector
  grouped_score_names_index <- grouped_score_names_index + 1
}

# Write result in exam_statistics_output_file.txt
output_data_file <- file("exam_statistics_output_file.txt")
writeLines(
  c(
    "[Weighted Mean and base graduation score]",
    output_weighted_mean,
    output_base_graduation_score,
    "",
    "[Minimum and Maximum score]",
    output_minimum_and_maximum,
    "",
    "[Scores count]",
    output_grouped_scores_vector
  ),
  output_data_file
)
close(output_data_file)