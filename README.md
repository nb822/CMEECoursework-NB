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

# get_TreeHeight.R

Generalisable script that calculates tree height from the angle and distance from a tree, using height = distance * tan(angle in radians)

## Run

From the repo root:

```
Rscript code/get_TreeHeight.R <data/any_tree.csv>
```

## Paths

- Input: `<data/any_tree.csv>` File with columns: "Species", "Distance.m" and "Angle.degrees"
- Output: `results/<any_tree>_treeheights.csv` generated

## Check

- Input with no supplied data file: Please supply exactly one argument
- Input with >1 supplied arguemnt: Please supply exactly one argument
- Input with csv file with incorrect colnames: Invalid column names
- Script over-writes results file when called twice. 

# pound_hill_analysis.R

Pivots pound hill data to a long format, saves a mean plot species richness table and figure. Missing values coded as zeros. 

## Run

From the repo root:

```
Rscript code/pound_hill_analysis.R
```

## Paths

- Input: `data/pound_hill_data.csv` (unchanged downloaded file)
- Output: `results/pound_hill_plot_richness.csv` and `results/pound_hill_plot_richness.pdf`

