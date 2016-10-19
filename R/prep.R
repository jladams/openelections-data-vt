# Check for and install tidyverse
if(!("tidyverse" %in% installed.packages()))  install.packages("tidyverse")

# Load required packages
library(tidyverse)
library(stringr)

# Load Town/County Crosswalk
county_key <- read_csv("./data/town_county_key.csv")


# Get cleaned primary results from raw data
# file = Path to raw data
# prime_office = The office being sought
# prime_party = The party holding the primary
process_primary <- function(file, prime_office, prime_party) {
  
  # Read raw file from path, filter blank rows, remove unused "Ward" column and totals column, rename columns
  primary <- read_csv(file) %>%
    filter(!is.na(`City/Town`) & (`City/Town` != "TOTALS")) %>%
    select(-Ward, -`Total Votes Cast`) %>%
    rename(town = `City/Town`, precinct = Pct)

  # Reshape data to OpenElections format, add county, office, party, district, reorder columns
  primary <- primary %>%
    gather(candidate, votes, 3:ncol(primary)) %>%
    left_join(county_key, by = "town") %>%
    mutate(office = prime_office, party = prime_party, district = NA) %>%
    select(county, town, precinct, office, district, party, candidate, votes)
  
  primary$votes <- gsub("-", NA, primary$votes)
  
  return(primary)
}

# Get cleaned general election results from raw data
# file = path to raw file
# gen_office = office being sought
process_general <- function(file, gen_office){
  
  # Read in raw file
  general <- read_csv(file)
  
  # Create a table of parties based on columns that have party data in the second row
  gen_party <- general[1,] %>%
    t() %>%
    na.omit() %>%
    as.data.frame() %>%
    rownames_to_column() %>%
    select(candidate = rowname, party = V1)

  # Filter blank rows, remove unused columns
  general <- general %>%
    filter(!is.na(`City/Town`) & (`City/Town` != "TOTALS")) %>%
    select(-Ward, -`Total Votes Cast`) %>%
    rename(town = `City/Town`, precinct = Pct)

  general <- general %>%
    gather(candidate, votes, 3:ncol(general)) %>%
    left_join(county_key, by = "town") %>%
    left_join(gen_party, by = "candidate") %>%
    mutate(office = gen_office, district = NA) %>%
    select(county, town, precinct, office, district, party, candidate, votes)
  
  return(general)
}

# Process an entire directory for a statewide election at once
# dir = path to election directory, do not include trailing "/"
# office = Office being sought
# primary_file = output location of primary election data as csv
# general_file = output location of general election data as csv
#
# example:
# process_election("./data/results_raw/2014/sec_state", "Secretary of State", "./2014/20140826__vt__primary__secretary_of_state__precincts.csv", "./2014/2014/11/04__vt__general__secretary_of_state__precincts.csv")
process_election <- function(dir, office, primary_file, general_file) {
  
  # Get list of csv files in directory
  files <- list.files(path = dir, pattern = ".csv", full.names = TRUE)
  
  # Create empty list for primaries
  primaries <- list()
  
  # If any filenames contain party name (indicative of a primary), process them with process_primary and append to primaries list
  if(any(str_detect(files, "Republican"))){
    prime_rep <- process_primary(str_subset(files, "Republican"), office, "Republican")
    primaries$rep <- prime_rep
  }
  
  if(any(str_detect(files, "Democratic"))){
    prime_dem <- process_primary(str_subset(files, "Democratic"), office, "Democratic")
    primaries$dem <- prime_dem
  }
  
  if(any(str_detect(files, "Liberty_Union"))){
    prime_libu <- process_primary(str_subset(files, "Liberty_Union"), office, "Liberty Union")
    primaries$libu <- prime_libu
  }
  
  if(any(str_detect(files, "Progressive"))){
    prime_pro <- process_primary(str_subset(files, "Progressive"), office, "Progressive")
    primaries$pro <- prime_pro
  }
  
  # Combine list of primaries into single data frame
  primary <- bind_rows(primaries)
  
  # Write out csv from primary data frame
  write_csv(primary, primary_file)
  
  # Process the general election file in the directory (there should always be one) using process_general()
  general <- process_general(str_subset(files, "General_Election"), office)
  
  # Write out csv from general election data frame
  write_csv(general, general_file)
  
}

