#!/usr/bin/env python3
"""Validate and clean the synthetic Silwood tree survey."""

from __future__ import annotations

import csv
from pathlib import Path
from typing import Iterable
from collections import Counter
import re


PROJECT_ROOT = Path(__file__).resolve().parents[1]
INPUT_PATH = PROJECT_ROOT / "data" / "silwood_trees_raw.csv"
RESULTS_DIR = PROJECT_ROOT / "results"

INPUT_FIELDS = [
    "record_id",
    "location",
    "genus",
    "species",
    "distance_m",
    "angle_degrees",
]
ISSUE_FIELDS = ["source_row", "record_id", "reasons"]
OAK_COUNT_FIELDS = ["species", "count"]

ACCEPTED_STRING = '^ST\d{3}$'
ACCEPTED_LOCATION = [
    "Silwood Bottom",
    "Nash's Field",
    "Manor House",
    "Reactor Wood"
]
LOCATION_LOWER_DICT = {loc.lower(): loc for loc in ACCEPTED_LOCATION}

ACCEPTED_GENUS = [
    "Quercus",
    "Acer",
    "Betula",
    "Fagus",
    "Fraxinus"
]

GENUS_LOWER_DICT = {genus.lower(): genus for genus in ACCEPTED_GENUS}

ACCEPTED_SPECIES = [
    "robur",
    "petraea",
    "pseudoplatanus",
    "pendula",
    "sylvatica",
    "excelsior"
]

TAXON_PAIR_DICT = {
    "robur" : "Quercus",
    "petraea" : "Quercus",
    "pseudoplatanus" : "Acer",
    "pendula" : "Betula",
    "sylvatica" : "Fagus",
    "excelsior" : "Fraxinus"
}

#redundant as dict entries all lower anyway; relic of copy-paste function from genus and loc
SPECIES_LOWER_DICT = {species.lower(): species for species in ACCEPTED_SPECIES}

#creates a list of dictionaries; each dict maps a colname to a value
def load_records(path: Path = INPUT_PATH) -> list[dict[str, str]]:
    """Read the survey and check its column names."""
    with path.open(newline="", encoding="utf-8") as source:
        reader = csv.DictReader(source)
        if reader.fieldnames != INPUT_FIELDS:
            raise ValueError(
                f"Expected columns {INPUT_FIELDS}, found {reader.fieldnames}"
            )
        return list(reader)

#validates a row. Input is a dictionary for the row, output is either a a tuple of dictionary entries for the row OR 'None' with a list['message explaining what went wrong']
def validate_record(
    row: dict[str, str],
    source_row: int,
    accepted_ids: set[str],
) -> tuple[dict[str, str] | None, list[str]]:

    
    """Clean one record, or return the reasons it cannot be used."""

    #Make empty dictionary and error list
    new_dict = {}
    error_messages = []

    #extract dictionary entries from row
    record_id  = row['record_id']
    location = row['location']
    genus = row['genus']
    species = row['species']
    distance_m = row['distance_m']
    angle_degrees = row['angle_degrees']

    #RECORD_ID: stripped, then checked against input 'accepted_ids'. 

    record_id = record_id.strip()

    if record_id == "":
            error_messages.append("missing record_id")
    elif re.fullmatch(accepted_ids, record_id):
        new_dict["record_id"] = record_id
    else:
        error_messages.append("invalid record_id")

    #LOCATION: stripped then checked against 4 canonical location options, stored outside function
    # everything floored to avoid case mismatch 

    location = location.strip()
    #get() function returns None if no corresponding dict entry
    canonical_loc = LOCATION_LOWER_DICT.get(location.lower())

    if location == "":
        error_messages.append("missing location")
    elif canonical_loc == None:
        error_messages.append("invalid location")
    else:
         new_dict["location"] = canonical_loc

    #GENUS: same workflow as location

    genus = genus.strip()
    canonical_gen = GENUS_LOWER_DICT.get(genus.lower())

    if genus == "":
        error_messages.append("missing genus")
    elif canonical_gen == None:
        error_messages.append("invalid genus")
    else:
        new_dict["genus"] = canonical_gen

    #SPECIES: same workflow as location

    species = species.strip()
    canonical_sp = SPECIES_LOWER_DICT.get(species.lower())

    if species == "":
        error_messages.append("missing species")
    elif canonical_sp == None:
        error_messages.append("invalid species")
    else:
        new_dict["species"] = canonical_sp

    #PERMITTED TAXON PAIRS: if canonical_sp and canonical_gen from above loops do not match dictionary stored outside function, adds error message to list

    # first if line removes those with invalid genus and species, as obviously would not match canonical dict in first place
    if canonical_sp is not None and canonical_gen is not None:
        if TAXON_PAIR_DICT.get(canonical_sp) != canonical_gen:
            error_messages.append("invalid genus/species combination")

    #DISTANCE: convert the distance to float, if conversion doesn't work, invalid distance. Then see if distance within accepted range
    
    if distance_m == "":
        error_messages.append("missing distance_m")
    else:
        try:
            distance_m = float(distance_m)
            if distance_m < 100 and distance_m >= 0:
                new_dict["distance_m"] = distance_m
            else:
                error_messages.append("distance_m out of range")

        except ValueError:
            error_messages.append("invalid distance_m")

    #ANGLE: same workflow as distance
        
        if angle_degrees == "":
            error_messages.append("missing angle_degrees")
        else:
            try:
                angle_degrees = float(angle_degrees)
                if angle_degrees < 90 and angle_degrees >= 0:
                    new_dict["angle_degrees"] = angle_degrees
                else:
                    error_messages.append("angle_degrees out of range")
    
            except ValueError:
                error_messages.append("invalid angle_degrees")
    
    #FINAL RETURN FORK
    if error_messages:
        return None, error_messages
    return new_dict, []


def process_records(
    rows: Iterable[dict[str, str]],
) -> tuple[list[dict[str, str]], list[dict[str, str]]]:
    """Sort records into accepted rows and issue reports."""

    ##make empty lists accepted_rows and issue_reports
    accepted_rows = []
    issue_reports = []
    #making set to see if any duplicates
    record_ids = set()

    ##loop through each row in dataframe using function validate_record()
    for i in range(0, len(rows)):
        source_row = i + 2
        cleaned, errors = validate_record(rows[i], source_row, ACCEPTED_STRING)

        if not errors and cleaned["record_id"] in record_ids:
            errors = ["duplicate record_id"]
        
        if errors:
            issue_reports.append({
                "source_row" : str(source_row),
                "record_id" : rows[i]["record_id"],
                "reasons" : errors
            })
        else:
            accepted_rows.append(cleaned)
            record_ids.add(cleaned["record_id"])

    return accepted_rows, issue_reports
    

def summarise_oaks(clean_records: Iterable[dict[str, str]]) -> list[dict[str, str]]:
    """Count accepted oak records by species."""

    oak_indivs = []

    #for loop through accepted records, creates list with each oak species name
    for i in range(0 , len(clean_records)):
        if clean_records[i]['genus'] == 'Quercus':
            oak_indivs.append(clean_records[i]['species'])

    #Create a tally dictionary where 'species_a' : number of indivs
    tally = dict(Counter(oak_indivs))

    #current format of tally: {"petraea": 4, "robur" : 4}
    #what we need: [{"species" : "petraea", "count" : 4}, {"species" : "robur", "count" : 4}]
    return_list = [{
        "species": name, "count": count}
        for name, count in tally.items()
    ]

    return return_list



def write_csv(
    path: Path,
    fieldnames: list[str],
    rows: Iterable[dict[str, str]],
) -> None:
    """Write rows to a CSV file, replacing an older copy."""
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", newline="", encoding="utf-8") as destination:
        writer = csv.DictWriter(destination, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def main() -> None:
    """Clean the survey and write the three result files."""
    clean_records, issues = process_records(load_records())
    oak_counts = summarise_oaks(clean_records)

    write_csv(
        RESULTS_DIR / "silwood_trees_clean.csv",
        INPUT_FIELDS,
        clean_records,
    )
    write_csv(
        RESULTS_DIR / "silwood_tree_issues.csv",
        ISSUE_FIELDS,
        issues,
    )
    write_csv(
        RESULTS_DIR / "oak_species_counts.csv",
        OAK_COUNT_FIELDS,
        oak_counts,
    )


if __name__ == "__main__":
    main()
