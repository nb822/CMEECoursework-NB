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

```bash
sh unixPrac1.txt
```

### Paths
- INPUT: `data/fasta/*.fasta`
- OUTPUT: None. Results printed directly in terminal. 

### Code validation
Code tested on a .fasta file with 9 characters, line breaks between them and ATGC present. Expected number of bases and ATGC count returned. 

## tabtocsv.sh
Tab delineated to comma delineated file converter.

### Run
**From repo root.**

```bash
bash code/tabtocsv.sh data/<file>.tsv
```

Example working code:

```bash
bash code/tabtocsv.sh data/tab-example.tsv
```
### Paths
- INPUT: `<path>/<file>.tsv` from root repo
- OUTPUT: `results/<file>.tsv.csv` from root repo

### Validation
Output checked on `data/tab-example.tsv`. Output checked for invalid file number, and invalid file names. 

## csvtospace.sh
Comma-delineated file to space delineated file. Uses simple comma substitution, can not handle commas in quotation marks as data. 

### Run
**From repo root.**

```bash
bash code/csvtospace.sh data/<file>.csv
```

Example working code:

```bash
bash code/csvtospace.sh data/temperatures/1801.csv
```
### Paths
- INPUT: `<path>/<file>.csv` from repo root
- OUTPUT: `results/<file>.csv.space` from root repo

### Validation
Output checked on files in `data/temperatures/`. Output checked for invalid file number, and invalid file names. 

# Assignment 2
## clean_silwood_trees.py 

Validates and cleans tree survey data. Valid records are written to a clean file, rejected records to an issues file with reasons, and accepted oaks (genus *Quercus*) are counted by species.

### Run

From the repo root: 

```bash
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

```bash
Python3 code/test_silwood_trees.py
```
### Paths
Takes functions from `data/silwood_trees_raw.csv`. No output.

# Assignment 3
## TreeHeight.R

Calculate tree height from the angle and distance from a tree, using height = distance * tan(angle in radians)

### Run

From the repo root:

```bash
Rscript code/TreeHeight.R
```

### Paths

- INPUT: `data/trees.csv` (unchanged downloaded file)
- OUTPUT: `results/TreeHts.csv` (generated; the script recreates it)

### Check

Row 1: Species = _Populus tremula_, Distance = 31.66583m, Angle = 41.28264 degrees.

By hand: 31.66583 * tan(41.28264 * pi / 180) = 27.80212.
<br> 'results/TreeHts.csv' gives the same answer.

## get_TreeHeight.R

Generalisable script that calculates tree height from the angle and distance from a tree, using height = distance * tan(angle in radians)

### Run

From the repo root:

```bash
Rscript code/get_TreeHeight.R data/<any_tree.csv>
```
Example script:
```bash
Rscript code/get_TreeHeight.R data/trees.csv
```

### Paths

- INPUT: `<data/any_tree.csv>` File with columns: "Species", "Distance.m" and "Angle.degrees"
- OUTPUT: `results/<any_tree>_treeheights.csv` generated

### Check

- Input with no supplied data file: Please supply exactly one argument
- Input with >1 supplied arguemnt: Please supply exactly one argument
- Input with csv file with incorrect colnames: Invalid column names
- Script over-writes results file when called twice. 

## run_get_TreeHeight.sh
Bash script that runs get_TreeHeight.R

### Run
From the repo root:
```bash
code/run_get_TreeHeight.sh
```

### Paths
Uses same paths as get_TreeHeight.R

## pound_hill_analysis.R

Pivots pound hill data to a long format, saves a mean plot species richness table and figure. Missing values coded as zeros. 

### Run

From the repo root:

```bash
Rscript code/pound_hill_analysis.R
```

### Paths

- INPUT: `data/pound_hill_data.csv` (unchanged downloaded file)
- OUTPUTS: `results/pound_hill_plot_richness.csv` and `results/pound_hill_plot_richness.pdf`

# Classwork
## variables.sh
Practice code to show how variables are stored and called. The arguments can be any values and the script will prompt you in the terminal to type a string and two integers separated by a space.

### Run

From repo root:
```bash
bash code/variables.sh <value> <value>
```
## MyExampleScript.sh
Basic bash script to show how variables can be stored and called. Prints "Hello \<user>"

### Run

From repo root:
```bash
bash code/MyExampleScript.sh
```

## boilerplate.sh
Basic bash script to show how scripts can be run from the terminal

### Run

From repo root:
```bash
bash code/boilerplate.sh
```
or
```bash
code/boilerplate.sh
```

## CheckLabel.sh
Exercise to learn basics of if statements. If the argument supplied is an oak or pine, it prints oak or pine respectively. Else, it prints 'Unknown label'.

### Run

From repo root:
```bash
bash code/CheckLabel.sh <argument>
```
e.g.
```bash
bash code/CheckLabel.sh oak
```
## CountLines.sh
Counts number of lines in a file.

### Run
From repo root:
```bash
bash code/CountLines.sh <file.txt>
```
Example code:
```bash
bash code/CountLines.sh data/spawannxs.txt
```

## ConcatenateTwoFiles.sh
script that concatenates two supplied files together and outputs combined file.

### Run
From repo root:
```bash
bash code/ConcatenateTwoFiles.sh <file1>.txt <file2>.txt <file3>.txt
```

Example test:
```bash
#make directory if doesn't already exist
mkdir -p sandbox/results sandbox/code

#create two simple test .txt files
printf 'oak\n' > "sandbox/code/first.txt"
printf 'pine\n' > "sandbox/code/second.txt"

#run script
bash code/ConcatenateTwoFiles.sh "sandbox/code/first.txt" "sandbox/code/second.txt" "sandbox/results/third.txt"
```
### Paths
See Example test above  

- INPUT: two .txt files (within a specified directory) as the first two arguments
- OUTPUT: a .txt file (within a specified directory) as third argument.

## tiff2_png.sh
Converts a .tiff image to a .png image.

### Run
From repository root assuming .tiff file is in the root folder. Otherwise provide a path to the .tiff file. For an example using a folder containing a .tiff file outside the repository, see 'Example code':

```bash
bash code/tiff2_png.sh <name>.tiff
```

Example code (from repo root):
```bash
#store path to code as variable
project_root=$PWD
script_path=$project_root/code/tiff2_png.sh

#make temporary directory
test_dir=$(mktemp -d) && mkdir "$test_dir/images" && cd "$test_dir/images" && pwd

#copy .tiff images into the test directory. Here a .tiff file is downloaded manually to the ~/Downloads/ folder from https://commons.wikimedia.org/wiki/File:%221775...167th_Anniversary...1942%22_-_NARA_-_513783.tiff before this line of code is run.
cp ~/Downloads/_1775...167th_Anniversary...1942__-_NARA_-_513783.tiff "$test_dir/images/"

#run script
bash "$script_path" _1775...167th_Anniversary...1942__-_NARA_-_513783.tiff
```
### Paths
- INPUT(S): a .tiff file or directory containing .tiff files
- OUTPUT(S): (a) .png file(s) in the **same folder** as the .tiff file

## loops.py
Exercise to learn loop construction in Python.
- A `for` loop with `range(5)` prints the integers 0–4.
- A `for` loop iterates over a mixed-type list and prints every item.
- A `for` loop adds values in a list and prints the cumulative total after each addition.
- A `while` loop increments `z` from 0 to 100 and prints each value.

### Run
From repo root:
```bash
python3 code/loops.py
```

## cfexercises1.py
Exercise to learn how functions work in Python. Running the script from bash tests each of the following functions on simple integer values (3; 3,4; 4,5,3; 3; 3; 3 respectively) and prints the results.

- `foo_1(x)` returns the square root of `x`.
- `foo_2(x, y)` returns the larger of two numbers.
- `foo_3(x, y, z)` returns three numbers ordered from smallest to largest.
- `foo_4(x)` calculates `x` factorial with a `for` loop.
- `foo_5(x)` calculates `x` factorial recursively.
- `foo_6(x)` calculates `x` factorial with a `while` loop.

### Run 
From repo root:
```bash
python3 code/cfexercises1.py
```

## cfexercises2.py
Predictions exercise to understand `for`, `if` and `while` loops. 

### Run
To test the code works, run from repo root:
```bash
python3 code/cfexercises2.py
```

## MyExampleScript.py
Exercise to learn how to run python scripts in bash terminal. Runs a simple square function and prints the square of 2.

### Run
From repo root:
```bash
python3 code/MyExampleScript.py
```

## boilerplate.py
Exercise to learn how main guards work (`if __name__ == "__main__"`). If python3 is directly executed on the file, prints 'This is a boilerplate'.

### Run
From repo root:
```bash
python3 code/boilerplate.py
```

## using_name.py
Exercise that demonstrates how python sets `__name__`.

### Run 
From repo root:

```bash
python3 code/using_name.py
```
Should return `This module's name is __main__` <br><br>
Alternatively, in ipython3 run from /code/ folder:
```python
import using_name
using_name.module_name()
```
This should return `using_name`.

## sysargv.py
Exercise to learn how to use command-line arguments to store variables in a python script, without editing the python script. This script lets you input arguments to the bash command, printing (1) the script name (`sys.argv[0]`), (2) the number of arguments (`len(sys.argv) -1`) and (3) lists the arguments inputted (`sys.argv[1:]`)

### Run
From repo root:
```bash
python3 code/sysargv.py
```
For example, can input 4 arguments:7
```bash
python3 code/sysargv.py oak 12 example3 var
```

## control_flow.py
Exercise to practise use of `doctest`. Python script contains function which returns whether an input is odd or even.

### Run
From repo root:
```bash
python3 -m doctest -v code/control_flow.py
```
## test_control_flow.py
Script to demonstrate the `assert` function. Tests functions imported from `control_flow.py` and asserts expected value inputted into imported functions.

### Run
From repo root:
```bash
python3 code/test_control_flow.py
```