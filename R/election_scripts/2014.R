# Load required packages and functions
# source("./R/prep.R")

process_election("./data/results_raw/2014/atty_gen", 
                 office = "Attorney General", 
                 primary_file = "./2014/20140826__vt__primary__attorney_general__precincts.csv", 
                 general_file = "./2014/20141104__vt__general__attorney_general__precincts.csv"
                 )

process_election("./data/results_raw/2014/sec_state", 
                 office = "Secretary of State", 
                 primary_file = "./2014/20140826__vt__primary__secretary_of_state__precincts.csv", 
                 general_file = "./2014/20141104__vt__general__secretary_of_state__precincts.csv"
                 )

process_election("./data/results_raw/2014/gov", 
                 office = "Governor", 
                 primary_file = "./2014/20140826__vt__primary__governor__precincts.csv", 
                 general_file = "./2014/20141104__vt__general__governor__precincts.csv"
                 )

process_election("./data/results_raw/2014/house", 
                 office = "U.S. House", 
                 primary_file = "./2014/20140826__vt__primary__house__precincts.csv", 
                 general_file = "./2014/20141104__vt__general__house__precincts.csv"
                 )
