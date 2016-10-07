# Load required packages and functions
source("./R/prep.R")

# Process raw primary data per party
prime_rep <- process_primary("./data/results_raw/2014/gov/VT Elections Database__2014_Governor_Republican_Primary_including_precincts.csv", "Governor", "Republican")
prime_dem <- process_primary("./data/results_raw/2014/gov/VT Elections Database__2014_Governor_Democratic_Primary_including_precincts.csv", "Governor", "Democratic")
prime_libu <- process_primary("./data/results_raw/2014/gov/VT Elections Database__2014_Governor_Liberty_Union_Primary_including_precincts.csv","Governor", "Liberty Union")
prime_pro <- process_primary("./data/results_raw/2014/gov/VT Elections Database__2014_Governor_Progressive_Primary_including_precincts.csv", "Governor", "Progressive")

# Combine processed primary data
primary_2014 <- rbind(prime_dem,prime_libu,prime_pro,prime_rep)

# Process general election data
general_2014 <- process_general("./data/results_raw/2014/gov/VT Elections Database__2014_Governor_General_Election_including_precincts.csv", "Governor")
