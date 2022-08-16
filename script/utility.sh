#!/bin/bash

set -x
set -e
set -u
set -o pipefail

folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$folder"/../docs/utilities/index.md ]; then
  rm "$folder"/../docs/utilities/index.md
fi

cp "$folder"/../risorse/utility_header.md "$folder"/../docs/utilities/index.md

yq -c '.[]' "$folder"/../docs/utilities/utilities.yml | mlr --json put -S '$name=tolower($nome)' then sort -f name | while read line;do
nome=$(echo "$line" | jq -r '.nome')
URL=$(echo "$line" | jq -r '.URL')
descrizione=$(echo "$line" | jq -r '.cosaFa')
ardcmd=$(echo "$line" | jq -r '.ardcmd')
echo -e "## $nome\n" >> "$folder"/../docs/utilities/index.md
echo -e "$descrizione\n" >> "$folder"/../docs/utilities/index.md
if [ "$ardcmd" = "null" ]
then
    echo "vuoto"
else
    echo -e ":arrow_right: [pagina dedicata](../$ardcmd)<br>" >> "$folder"/../docs/utilities/index.md
    echo "non vuoto"
fi
echo -e ":information_source: <$URL>\n" >> "$folder"/../docs/utilities/index.md
done

