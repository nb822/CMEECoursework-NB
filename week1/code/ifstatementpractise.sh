
## tells user if they have not added an input argument what they can input (oak or pine)
if [[ $# -ne 1 ]]; then
  printf 'Usage: %s oak|pine\n' "$0" >&2
  ## exits with error code 2 if no input argument is given
  exit 2
fi
## if oak or pine not inputted but something else is, tells user that it is an unknown label and exits with error code 1
if [[ "$1" != "oak" && "$1" != "pine" ]]; then
  printf 'Unknown label: %s\n' "$1" >&2
  ## exits with error code 1 if unknown label is inputted
  exit 1
fi

##prints the input if oak or pine is inputted; exits with error code 0 if oak or pine is inputted
printf 'Selected speces: %s\n' "$1"