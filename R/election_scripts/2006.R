# Load required packages and functions
# source("./R/prep.R")

process_election("./data/results_raw/2006/atty_gen", 
                 office = "Attorney General", 
                 primary_file = "./2006/20060912__vt__primary__attorney_general__precincts.csv", 
                 general_file = "./2006/20061107__vt__general__attorney_general__precincts.csv"
)

process_election("./data/results_raw/2006/sec_state", 
                 office = "Secretary of State", 
                 primary_file = "./2006/20060912__vt__primary__secretary_of_state__precincts.csv", 
                 general_file = "./2006/20061107__vt__general__secretary_of_state__precincts.csv"
)

process_election("./data/results_raw/2006/governor", 
                 office = "Governor", 
                 primary_file = "./2006/20060912__vt__primary__governor__precincts.csv", 
                 general_file = "./2006/20061107__vt__general__governor__precincts.csv"
)

process_election("./data/results_raw/2006/house", 
                 office = "U.S. House", 
                 primary_file = "./2006/20060912__vt__primary__house__precincts.csv", 
                 general_file = "./2006/20061107__vt__general__house__precincts.csv"
)

process_election("./data/results_raw/2006/senate", 
                 office = "U.S. Senate", 
                 primary_file = "./2006/20060912__vt__primary__senate__precincts.csv", 
                 general_file = "./2006/20061107__vt__general__senate__precincts.csv"
)
