CMEEcoursework repository for learning version control, bash scripting, python and R.

# clean_silwood_trees.py 

Validates and cleans tree survey data. Valid records are written to a clean file, rejected records to an issues file with reasons, and accepted oaks (genus *Quercus*) are counted by species.

## Run

From the repo root: 

```
Python3 code/clean_silwood_trees.py
```

## Paths

- INPUT: `data/silwood_trees_raw.csv` (unchanged downloaded file)
- OUTPUTS, written to `results/` and overwritten on every run:
    - `results/silwood_trees_clean.csv` accepted records
    - `results/silwood_trees_issues.csv` rejected records 
    - `results/oak_species_counts.csv` count of accepted *Quercus* records

## Validation rules

As described in `data/silwood_trees_metadata.md`. 

# TreeHeight.R

Calculate tree height from the angle and distance from a tree, using height = distance * tan(angle in radians)

## Run

From the repo root:

```
Rscript code/TreeHeight.R
```

## Paths

- Input: `data/trees.csv` (unchanged downloaded file)
- Output: `results/TreeHts.csv` (generated; the script recreates it)

## Check

Row 1: Species = _Populus tremula_, Distance = 31.66583m, Angle = 41.28264 degrees.

By hand: 31.66583 * tan(41.28264 * pi / 180) = 27.80212.
<br> 'results/TreeHts.csv' gives the same answer.

