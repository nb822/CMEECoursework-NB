# Assignment 1 feedback - Nick Brown

**Formative feedback | Rubric 2026.2**

Q1, Q2 and the decimal ratio matched the independent checks, and the history has descriptive development commits. The Unix answers are short, and the converters already contain basic argument/readability checks. The next tests should expose the two sequence-counting errors rather than only repeat familiar outputs.

Q3 counts line-ending characters as well as sequence positions, and Q4 searches wrapped lines separately. Both returned incorrect counts. Think of a motif whose first two bases are at the end of one line and whose last two are at the start of the next: the DNA has not changed, but a line-by-line search misses it. Test that small example, and distinguish the sequence from how a text file happens to display it. Also, +2 means start at line 2, not skip the first two lines.

The converters place results relative to the input directory, which can mean data/results instead of the repository's results/. The tab converter does not create that directory, and the CSV converter uses .space rather than the required full-basename .txt output. Check regular-file status and conversion success as well as readability.

Supply the missing own TSV and four temperature files; the missing-data checks are not successful conversions. Replace the one-sentence README with actual commands, outputs, tests and any help account. Document bc and the GNU-specific --total=never option, ignore generated results and use the next descriptive commits to capture these focused fixes.

---

## Project structure

Relevant tracked layout (simplified; missing required paths are marked):

```text
README.md
.gitignore
code/  unixPrac1.txt, tabtocsv.sh, csvtospace.sh
data/fasta/  3 required files present
data/temperatures/  missing here: 1800.csv, 1801.csv, 1802.csv, 1803.csv
data/tab-example.tsv [missing]
results/  no files tracked; generated on run
sandbox/  no files tracked; optional
```

The root README, ignore file, assessed code and FASTA inputs are present. The own TSV and four required temperature files are absent from their required paths. No generated results are tracked, and sandbox is ignored.

Complete the missing data and keep one repository-root results destination. The scripts currently derive output paths from the input location, which can create data/results and blur the input/output separation. Add an explicit results ignore rule and document the corrected layout and filenames in the README.

**Assessed snapshot:** `87e6c23e8b37c1f135e365f7a53bc9e1f35c17b7`
