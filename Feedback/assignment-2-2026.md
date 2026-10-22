# Assignment 2 formative feedback

This feedback is organised by the relevant computing bootcamp criteria. Use it to decide what is already working, what you need to investigate, and what to revise before the cumulative submission.

The full criteria are in the [Computing Bootcamp assessment rubric](https://github.com/MulQuaBio/MQB/blob/main/content/rubrics/Computing_Bootcamp_Rubric.md).

## 1. Repository organisation and workflow discipline

- Your root README, `.gitignore`, cleaning script and supplied data files are in the expected locations, and the supplied inputs are unchanged. Add `code/test_silwood_trees.py` under `code/`, as described under Criterion 8.

## 2. Code completeness and functional correctness

- The supplied raw CSV and metadata remain unchanged. Your cleaning script ran and produced all three tables; separately, output checks found that `silwood_trees_clean.csv` satisfies the checked output requirements. The other two tables still need checking, as do the important validation edge cases.
- Resolve the two table differences while preserving the raw input, then retain the smallest failing examples as regression tests.
- Add and run the separate tests, then rerun the full workflow and inspect all three outputs.

## 3. Code quality and style

- Your `main()` function gives the program a clear overall structure by connecting loading, processing, summarising and writing. Keep these stages distinct as you revise; use descriptive names and add short comments where the reason for a validation check or data-cleaning step is not obvious.

## 4. Documentation

- Your root README is in place. Make it useful to someone opening the repository for the first time: explain what the cleaner does, how to run the script and tests from the repository root, and which three files it creates. Test the instructions in a newly cloned copy of your repository (a separate folder created with `git clone`): enter that folder and run each README command exactly as written. If something fails, correct the command or add the missing step.

## 5. Version-control practice

- Since the previous formative feedback was added, the saved history contains 9 non-merge commits. The recent history contains several checkpoints, but messages such as `finish python coursework, add code and README` and `add worked python coursework code` bundle several changes and do not identify which behaviour was implemented or tested.
- Before each commit, run `git diff --staged` to see exactly what will be recorded. Keep one coherent, working change per commit and write a concise message that names what changed—for example, the validation rule added, the failing test fixed or the README instruction clarified.

## 8. Basic error handling and input validation

- **Add a small separate test file.** `code/test_silwood_trees.py` is absent. It was added retrospectively to the notebook, so this is not treated as disregard of the original instructions, but it remains required for the final cumulative submission. Separate tests make it easier to check helper behaviour independently of a full run. Start with a valid record, a borderline rejected record and a small oak-summary example; check returned values and reasons, not just whether execution finishes.

## 9. Problem-solving approach and method implementation

- Your code shows a clear workflow: `main()` loads the CSV through `load_records()`, passes rows to `process_records()` and `validate_record()`, receives `(accepted_rows, issue_reports)`, summarises the cleaned records with `summarise_oaks()`, then calls `write_csv()` for all three outputs. The flow from input to outputs is easy to follow.
- **Trace the issue report and oak summary.** Output checks identified differences in row 2’s `reasons` field in `silwood_tree_issues.csv` and row 2’s `species` field in `oak_species_counts.csv`. These are output issues despite successful execution. Trace a borderline input row through `validate_record()` and the accepted/rejected branch, inspecting how its reasons are assembled. Then trace accepted oak records into `summarise_oaks()`, checking species labels, grouping and output ordering against the released requirements. This will help locate whether each difference arises during processing or writing, without assuming the whole workflow is wrong.
- After correcting the logic, keep the smallest example that exposed each problem as an assertion-based regression test in `code/test_silwood_trees.py`. Check the relevant function return value and the affected output table, then briefly explain the corrected data flow in your root README.
