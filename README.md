CMEEcoursework repository for learning version control, bash scripting, python and R.

# Assignment 1 
## unixPrac1.txt

### Dependencies
Uses `--total=never` which is GNU-specific and won't work on MacOS. 

### Usage
Runs 5 lines of code that extract information from a .fasta file.
1. Counts number of lines in each .fasta file in data/fasta/ from repo root. 
1. Prints entire base sequence in /data/fasta/e_coli.fasta
1. Counts number of bases in /data/fasta/e_coli.fasta
1. Counts number of times 'ATGC' occurs in /data/fasta/e_coli.fasta
1. Calculates AT/GC ratio in /data/fasta/e_coli.fasta

### Run
From the /code/ folder of the repo.

```
sh unixPrac1.txt
```

### Paths
INPUT: `data/fasta/*.fasta`
OUTPUT: None. Results printed directly in terminal. 

### Code validation
Code tested on a .fasta file with 9 characters, line breaks between them and ATGC present. Expected number of bases and ATGC count returned. 

## tabtocsv.sh
Tab delineated to comma delineated file converter.

### Run
**From repo root.**

```
bash code/tabtocsv.sh data/<file>.tsv
```

Example working code:

```
bash code/tabtocsv.sh data/tab-example.tsv
```
### Paths
INPUT: `<path>/<file>.tsv` from root repo
OUTPUT: `results/<file>.tsv.csv` from root repo

### Validation
Output checked on `data/tab-example.tsv`. Output checked for invalid file number, and invalid file names. 

## csvtospace.sh
Comma-delineated file to space delineated file. Uses simple comma substitution, can not handle commas in quotation marks as data. 

### Run
**From repo root.**

```
bash code/csvtospace.sh data/<file>.csv
```

Example working code:

```
bash code/csvtospace.sh data/temperatures/1801.csv
```
### Paths
INPUT: `<path>/<file>.csv` from repo root
OUTPUT: `results/<file>.csv.space` from root repo

### Validation
Output checked on files in `data/temperatures/`. Output checked for invalid file number, and invalid file names. 

# Assignment 2
## clean_silwood_trees.py 

Validates and cleans tree survey data. Valid records are written to a clean file, rejected records to an issues file with reasons, and accepted oaks (genus *Quercus*) are counted by species.

### Run

From the repo root: 

```
Python3 code/clean_silwood_trees.py
```

### Paths

- INPUT: `data/silwood_trees_raw.csv` (unchanged downloaded file)
- OUTPUTS, written to `results/` and overwritten on every run:
    - `results/silwood_trees_clean.csv` accepted records
    - `results/silwood_trees_issues.csv` rejected records 
    - `results/oak_species_counts.csv` count of accepted *Quercus* records

### Validation rules

As described in `data/silwood_trees_metadata.md`. 

## test_silwood_trees.py
Checks whether functions of clean_silwood_trees.py gives expected outputs given feedback from coursework. If all tests passed, prints "All tests passed".

### Run
From the repo root: 

```
Python3 code/test_silwood_trees.py
```
### Paths
Takes functions from `data/silwood_trees_raw.csv`. No output.

# Assignment 3
## TreeHeight.R

Calculate tree height from the angle and distance from a tree, using height = distance * tan(angle in radians)

### Run

From the repo root:

```
Rscript code/TreeHeight.R
```

### Paths

- Input: `data/trees.csv` (unchanged downloaded file)
- Output: `results/TreeHts.csv` (generated; the script recreates it)

### Check

Row 1: Species = _Populus tremula_, Distance = 31.66583m, Angle = 41.28264 degrees.

By hand: 31.66583 * tan(41.28264 * pi / 180) = 27.80212.
<br> 'results/TreeHts.csv' gives the same answer.

## get_TreeHeight.R

Generalisable script that calculates tree height from the angle and distance from a tree, using height = distance * tan(angle in radians)

### Run

From the repo root:

```
Rscript code/get_TreeHeight.R data/<any_tree.csv>
```
Example script:
```
Rscript code/get_TreeHeight.R data/trees.csv
```

### Paths

- Input: `<data/any_tree.csv>` File with columns: "Species", "Distance.m" and "Angle.degrees"
- Output: `results/<any_tree>_treeheights.csv` generated

### Check

- Input with no supplied data file: Please supply exactly one argument
- Input with >1 supplied arguemnt: Please supply exactly one argument
- Input with csv file with incorrect colnames: Invalid column names
- Script over-writes results file when called twice. 

## run_get_TreeHeight.sh
Bash script that runs get_TreeHeight.R

### Run
From the repo root:
```
code/run_get_TreeHeight.sh
```

### Paths
Uses same paths as get_TreeHeight.R

## pound_hill_analysis.R

Pivots pound hill data to a long format, saves a mean plot species richness table and figure. Missing values coded as zeros. 

### Run

From the repo root:

```
Rscript code/pound_hill_analysis.R
```

### Paths

- Input: `data/pound_hill_data.csv` (unchanged downloaded file)
- Output: `results/pound_hill_plot_richness.csv` and `results/pound_hill_plot_richness.pdf`

# Classwork
## variables.sh
Practice code to show how variables are stored and called. The arguments can be any values and the script will prompt you in the terminal to type a string and two integers separated by a space.

### Run

From repo root:
```
bash code/variables.sh <value> <value>
```
## MyExampleScript.sh
Basic bash script to show how variables can be stored and called. Prints "Hello \<user>"

### Run

From repo root:
```
bash code/MyExampleScript.sh
```

## boilerplate.sh
Basic bash script to show how scripts can be run from the terminal

### Run

From repo root:
```
bash code/boilerplate.sh
```
or
```
code/boilerplate.sh
```

## CheckLabel.sh
Exercise to learn basics of if statements. If the argument supplied is an oak or pine, it prints oak or pine respectively. Else, it prints 'Unknown label'.

### Run

From repo root:
```
bash code/CheckLabel.sh <argument>
```
e.g.
```
bash code/CheckLabel.sh oak
```

