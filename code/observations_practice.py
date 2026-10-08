import csv
import doctest


def load_observations(path):
    with open(path, newline="", encoding="utf-8") as stream:
        return list(csv.DictReader(stream))


def parse_count(count_text):
    print("code running...")
    if count_text == "":
        return None
    if isinstance(count_text, int):
        raise ValueError("Count must be a string")
    try: 
        count = int(count_text)
    except (ValueError, TypeError):
        raise ValueError("Count must be an integer")
    if count < 0:
        raise ValueError("Count must be non-negative")
    return count




if __name__ == "__main__":
    rows = load_observations("data/bootcamp_observations.csv")
    print(rows[0])
    print(rows[2])

