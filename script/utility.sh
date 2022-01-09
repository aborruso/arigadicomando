#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$folder"/../docs/utilities/index.md ]; then
  rm "$folder"/../docs/utilities/index.md
fi

#echo -e "# Utility\n" >> "$folder"/../docs/utilities/index.md

cp "$folder"/../risorse/utility_header.md "$folder"/../docs/utilities/index.md

yq -c '.[]' "$folder"/../docs/utilities/utilities.yml | mlr --json sort -f nome | while read line;do
nome=$(echo "$line" | jq -r '.nome')
URL=$(echo "$line" | jq -r '.URL')
descrizione=$(echo "$line" | jq -r '.cosaFa')
echo -e "## $nome\n" >> "$folder"/../docs/utilities/index.md
echo -e "$descrizione\n" >> "$folder"/../docs/utilities/index.md
echo -e ":arrow_right: <$URL>\n" >> "$folder"/../docs/utilities/index.md
done

