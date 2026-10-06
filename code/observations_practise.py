
import csv

#load in data function
def load_observations(path):
    with open(path, newline="", encoding="utf-8") as stream:
        return list(csv.DictReader(stream))

# loading all data
observations = load_observations("data/tree_observations/bootcamp_observations.csv")
boundary     = load_observations("data/tree_observations/bootcamp_observations_boundary.csv")
invalid      = load_observations("data/tree_observations/bootcamp_observations_invalid.csv")


def parse_count(count_text):
    if count_text == "":
        return None
    elif count_text.isdigit():
        return int(count_text)
    raise NotImplementedError("Finish conversion and invalid-count handling")
    



  

