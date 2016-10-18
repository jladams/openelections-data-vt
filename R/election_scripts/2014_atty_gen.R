# Load required packages and functions
# source("./R/prep.R")

# Process raw primary data per party
prime_rep <- process_primary("./data/results_raw/2014/atty_gen/VT Elections Database__2014_Attorney_General_Republican_Primary_including_precincts.csv", "Attorney General", "Republican")
prime_dem <- process_primary("./data/results_raw/2014/atty_gen/VT Elections Database__2014_Attorney_General_Democratic_Primary_including_precincts.csv", "Attorney General", "Democratic")
prime_libu <- process_primary("./data/results_raw/2014/atty_gen/VT Elections Database__2014_Attorney_General_Liberty_Union_Primary_including_precincts.csv","Attorney General", "Liberty Union")

# Combine processed primary data
primary <- rbind(prime_dem,prime_libu,prime_rep)

# Process general election data
general <- process_general("./data/results_raw/2014/atty_gen/VT Elections Database__2014_Attorney_General_General_Election_including_precincts.csv", "Attorney General")

# Write primary data
write_csv(primary, "./2014/20140826__vt__primary__attorney_general__precincts")

# Write general data
write_csv(general, "./2014/20141104__vt__general__attorney_general__precincts")