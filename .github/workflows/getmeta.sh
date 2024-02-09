#!/usr/bin/env bash
shopt -s lastpipe

readarray -t arr < <(jq '.links' templates_tmp.json)

for i in "${arr[@]}"
do
  if  [ "$i" = "[" ] || [ "$i" = "]" ]; then
    echo ""
  else
    link=$(echo "$i" | tr -d '"' | tr -d ',' | xargs)

    rm -f /tmp/tmp.json
    etalagename=""
    screenshot_ext=""

    echo /tmp/embgit repo_show_quiqrsite $link
    out=$(/tmp/embgit repo_show_quiqrsite $link) && echo "$out" > /tmp/tmp.json

    if [ -f /tmp/tmp.json ]; then

      cat /tmp/tmp.json | \
        jq -r ".QuiqrEtalageName" | \
        tr -s ' ' '-' | \
        read etalagename

      if  [ "$etalagename" != "" ]; then
        cat /tmp/tmp.json | jq "del(.Screenshot) | .SourceLink = \"$link\" | .NormalizedName = \"$etalagename\"" > _$etalagename.json

        cat /tmp/tmp.json | jq -r '.ScreenshotImageType' | read screenshot_ext
        if  [ "$screenshot_ext" != "" ]; then
          mkdir -p public/templates/$etalagename

          echo screenshot.$screenshot_ext > public/templates/$etalagename/screenshot.txt
          cat /tmp/tmp.json | jq -r '.Screenshot' | sed 's/^data:image\/[a-z]*;base64,//' | base64 -d -i > public/templates/$etalagename/screenshot.$screenshot_ext
        fi
      else
        echo "ERROR: template $link does not seem to be valid."
      fi
    fi
  fi

done

rm -f templates_tmp.json
jq -s 'flatten' _*.json > public/templates.json
rm -f _*.json
cat public/templates.json
