# Check for and install tidyverse
if(!("tidyverse" %in% installed.packages()))  install.packages("tidyverse")

# Load required packages
library(tidyverse)

# Load Town/County Crosswalk
county_key <- read_csv("./data/town_county_key.csv")


# Get cleaned primary results from raw data
# file = Path to raw data
# prime_office = The office being sought
# prime_party = The party holding the primary
process_primary <- function(file, prime_office, prime_party) {
  
  # Read raw file from path, filter blank rows, remove unused "Ward" column and totals column, rename columns
  primary <- read_csv(file) %>%
    filter(!is.na(`City/Town`)) %>%
    select(-Ward, -`Total Votes Cast`) %>%
    rename(town = `City/Town`, precinct = Pct)

  # Reshape data to OpenElections format, add county, office, party, district, reorder columns
  primary <- primary %>%
    gather(candidate, votes, 3:ncol(primary)) %>%
    left_join(county_key, by = "town") %>%
    mutate(office = prime_office, party = prime_party, district = NA) %>%
    select(county, town, precinct, office, district, party, candidate, votes)
  
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
    filter(!is.na(`City/Town`)) %>%
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