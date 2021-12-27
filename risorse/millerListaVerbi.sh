#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$folder"/tmp_verbs.md ]; then
  rm "$folder"/tmp_verbs.md
fi

mlrgo -l | mlrgo --nidx cat | while read line; do
  echo -e "### $line\n" >>"$folder"/tmp_verbs.md
  echo -e '!!! aiuto "mlr '"$line"' --help"\n' >>"$folder"/tmp_verbs.md
  echo -e '    ```' >>"$folder"/tmp_verbs.md
  mlrgo "$line" --help | sed -r 's/^(.+)$/    \1/g' | grep -vP '(Usage:|--help)' >>"$folder"/tmp_verbs.md
  echo -e '    ```\n' >>"$folder"/tmp_verbs.md
done
