#!/usr/bin/env bash
readarray -t arr < <(jq '.links' templates.json)

for i in "${arr[@]}"
do
  if  [ "$i" = "[" ] || [ "$i" = "]" ]
  then
    echo ""
  else
    link=$(echo "$i" | tr -d '"' | tr -d ',')
    echo $link/quiqr/etalage/template.json
  fi

done

git status

