# Load required packages and functions
source("./R/prep.R")

# Process raw primary data per party
prime_dem <- process_primary("./data/results_raw/2014/sec_state/VT Elections Database__2014_Secretary_of_State_Democratic_Primary_including_precincts.csv", "Secretary of State", "Democratic")
prime_libu <- process_primary("./data/results_raw/2014/sec_state/VT Elections Database__2014_Secretary_of_State_Liberty_Union_Primary_including_precincts.csv","Secretary of State", "Liberty Union")
prime_pro <- process_primary("./data/results_raw/2014/sec_state/VT Elections Database__2014_Secretary_of_State_Progressive_Primary_including_precincts.csv", "Secretary of State", "Progressive")

# Combine processed primary data
primary <- rbind(prime_dem,prime_libu,prime_pro)

# Process general election data
general <- process_general("./data/results_raw/2014/sec_state/VT Elections Database__2014_Secretary_of_State_General_Election_including_precincts.csv", "Secretary of State")

# Write primary data
write_csv(primary, "./2014/20140826__vt__primary__sec_state__precincts")

# Write general data
write_csv(general, "./2014/20141104__vt__general__sec_state__precincts")