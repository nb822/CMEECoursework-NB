# Assignment 3 formative feedback

This feedback is organised using the [Computing Bootcamp rubric](https://mulquabio.github.io/MQB/rubrics/Computing_Bootcamp_Rubric.html). It does not award a mark; use it to decide what to revise and check before final submission.

## Criterion 1: Repository organisation & workflow discipline

- Your required scripts and supplied inputs are present, and the inputs match the supplied files. Generated results are ignored and none are tracked: keep this separation between source files and outputs.
- Before final submission, **Make output creation reproducible.** Both tree programs stopped because `results/` did not exist. Consequently, `results/TreeHts.csv` and `results/trees_treeheights.csv` were missing; their numerical contents were not checked. Have each program create its output directory when needed, rather than relying on a directory left from an earlier run. Test the fixed and generalised routes separately from the directory containing `code/`, `data/` and the root `README.md`.

## Criterion 2: Code completeness & functional correctness

Before final submission, run the fixed tree-height route, the generalised route and the Pound Hill analysis separately; check the exact files each one creates.

## Criterion 3: Code quality & style

As you revise, keep names descriptive, use comments to explain decisions rather than restating code, and avoid repeating the same calculation in several places.

## Criterion 4: Documentation

Give exact commands in the root `README.md`, together with each script’s input and output files, so that another student could repeat your checks.

## Criterion 5: Version-control practice

Commit each functional revision with a short message that says what changed; this makes your development easier to follow than one large final commit.

## Criterion 8: Basic error-handling & input validation

- Before final submission, **Recheck the function interface and validation after removing that blocker.** The interface check stopped while sourcing the script and trying to write the CSV; this does not show that your argument order is wrong. The first input should be the angle in degrees and the second the horizontal distance, as your definition already indicates. Try the taught example call and compare it with a direct calculation. The fixed invalid-input test also stopped at the output-writing error after reporting valid columns: its expected exit is therefore not evidence that it rejected the intended bad value. Rerun an ordinary and an invalid case for each route, checking that invalid data produce a useful error and no new result.

## Criterion 9: Problem-solving approach & method implementation

- The tree-height source defines the function with angle first and distance second, including conversion from degrees to radians. Your README also records an independent hand calculation; this is useful checking evidence, although its claimed agreement with the CSV could not be confirmed in this rerun.
- The generalised invalid-input run reported an invalid distance and exited as expected. Your Pound Hill source shows an explicit route from reshaping measurements to quadrat richness and then plot means, with interpretation comments to revisit against the generated figure.
- Before final submission, **Complete the Pound Hill route through checked outputs.** The run used for this feedback did not complete successfully, and neither `results/pound_hill_plot_richness.csv` nor `results/pound_hill_plot_richness.pdf` was produced. Compare those exact paths with the filenames your script creates—a spelling difference alone can make a required output appear missing. Add directory creation here too, then inspect the first remaining error. When rerunning through `Rscript`, check that the ggplot is explicitly drawn to the PDF device. Visually inspect the resulting PDF; file presence alone cannot confirm its labels or values. Manually trace one quadrat’s positive species counts into richness and one plot’s quadrat values into its mean. Revisit your interpretation: cultivation month is a treatment, so explain treatment differences without implying repeated seasonal measurements of the same plots.

## Criterion 10: Learning progression demonstration

Use this feedback as a revision checklist. Make the changes in small, descriptive commits, then add a short README note explaining what you changed and how you checked it. This will make your development from this formative checkpoint visible in the final portfolio.

## Priorities before final submission

- Repeat the tests above from a state without generated results, preserving the supplied inputs.
- Replace the generalised README command’s angle-bracket placeholder with a runnable example, and document the shell wrapper and invalid-input examples. Record what you actually observe, then commit the fixes with descriptive messages.
