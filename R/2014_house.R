# Load required packages and functions
source("./R/prep.R")

# Process raw primary data per party
prime_rep <- process_primary("./data/results_raw/2014/house/VT Elections Database__2014_U_S_House_Republican_Primary_including_precincts.csv", "U.S. House", "Republican")
prime_dem <- process_primary("./data/results_raw/2014/house/VT Elections Database__2014_U_S_House_Democratic_Primary_including_precincts.csv", "U.S. House", "Democratic")
prime_libu <- process_primary("./data/results_raw/2014/house/VT Elections Database__2014_U_S_House_Liberty_Union_Primary_including_precincts.csv","U.S. House", "Liberty Union")
prime_pro <- process_primary("./data/results_raw/2014/house/VT Elections Database__2014_U_S_House_Progressive_Primary_including_precincts.csv", "U.S. House", "Progressive")

# Combine processed primary data
primary <- rbind(prime_dem,prime_libu,prime_pro,prime_rep)

# Process general election data
general <- process_general("./data/results_raw/2014/house/VT Elections Database__2014_U_S_House_General_Election_including_precincts.csv", "U.S. House")

# Write primary data
write_csv(primary, "./2014/20140826__vt__primary__house__precincts")

# Write general data
write_csv(general, "./2014/20141104__vt__general__house__precincts")