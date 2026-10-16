CMEEcoursework repository for learning version control, bash scripting, python and R.

## clean_silwood_trees.py documentation and plan
Cleans tree data and outputs valid rows, list of removed rows with reasons and tallies for number of each Quercus species.

INPUT: a csv file, following exact colnames of 'silwood_trees_metadata.md'

Read CSV into list of dictionaries format where each row corresponds to 1 dict
validate_record() runs through each dict mapping in a row and rejects the row if the mapping does not match the canonical possibilities. Variables housed outside function: TAXON_PAIR_DICT, ACCEPTED_SPECIES, ACCEPTED_GENUS, ACCEPTED_LOCATION and ACCEPTED_STRING can be modified to remove or add canonical row entries. 

process_records() iterates through the validate_records() command and outputs a tuple containing a list of valid dictionary entries (for each row) and a list of error messages for rows that did not pass validate_record().

summarise_oaks counts the number of trees per oak species.


OUTPUT: One csv file with cleaned data ready for data analysis, a 2nd with list of error messages for rows which did not pass cleaning and a 3rd with counts for each quercus species


