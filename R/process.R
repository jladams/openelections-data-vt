# Load required libraries and functions
source("./R/prep.R")

# Get names of all files in election_scripts directory (one file per election)
parsers <- list.files(path = "./R/election_scripts/", pattern = "*.R", full.names = TRUE)

# Run each of those
sapply(parsers, source)

