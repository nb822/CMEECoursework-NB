#!/usr/bin/env python3
"""Tests for clean_silwood_trees.py"""

from clean_silwood_trees import validate_record, process_records, summarise_oaks


def valid_record(**changes):
    
    """A valid record"""
    
    row = {
        "record_id": "ST001", "location": "Manor House", "genus": "Quercus",
        "species": "robur", "distance_m": "12.5", "angle_degrees": "45",
    }
    row.update(changes)
    return row


def test_valid_record():
    cleaned, reasons = validate_record(valid_record(), 2, set())
    assert reasons == []
    assert cleaned["location"] == "Manor House"


def test_distance_and_angle():
    cleaned, reasons = validate_record(
        valid_record(distance_m="", angle_degrees=""), 2, set())
    assert cleaned is None
    assert reasons == ["missing distance_m", "missing angle_degrees"]


def test_issue_one_string():
    accepted, issues = process_records([valid_record(location="", distance_m="")])
    assert accepted == []
    # separator and wording from the metadata
    assert issues[0]["reasons"] == "missing location; missing distance_m"


def test_oak_counts():
    clean = [
        {"genus": "Quercus", "species": "robur"},
        {"genus": "Quercus", "species": "petraea"},
        {"genus": "Quercus", "species": "robur"},
        {"genus": "Acer", "species": "pseudoplatanus"},
    ]
    result = summarise_oaks(clean)
    # order and labels from the metadata
    assert summarise_oaks(clean) == [
        {"species": "petraea", "count": 1},
        {"species": "robur", "count": 2},
    ] , result


if __name__ == "__main__":
    test_valid_record()
    test_distance_and_angle()
    test_issue_one_string()
    test_oak_counts()
    print("All tests passed")