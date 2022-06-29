#!/usr/bin/env bash
shopt -s lastpipe

readarray -t arr < <(jq '.links' templates_tmp.json)

for i in "${arr[@]}"
do
  if  [ "$i" = "[" ] || [ "$i" = "]" ]; then
    echo ""
  else
    link=$(echo "$i" | tr -d '"' | tr -d ',')

    rm -f /tmp/tmp.json
    etalagename=""
    screenshot_ext=""

    echo ./embgit repo_show_quiqrsite $link
    out=$(./embgit repo_show_quiqrsite $link) && echo "$out" > /tmp/tmp.json

    if [ -f /tmp/tmp.json ]; then

      cat /tmp/tmp.json | \
        jq -r ".QuiqrEtalageName" | \
        tr -s ' ' '-' | \
        read etalagename

      if  [ "$etalagename" != "" ]; then
        cat /tmp/tmp.json | jq "del(.Screenshot) | .NormalizedName = \"$etalagename\"" > _$etalagename.json

        cat /tmp/tmp.json | jq -r '.ScreenshotImageType' | read screenshot_ext
        if  [ "$screenshot_ext" != "" ]; then
          mkdir -p templates/$etalagename

          echo screenshot.$screenshot_ext > templates/$etalagename/screenshot.txt
          cat /tmp/tmp.json | jq -r '.Screenshot' | sed 's/^data:image\/[a-z]*;base64,//' |base64 -d -i > templates/$etalagename/screenshot.$screenshot_ext
        fi
      fi

    fi
  fi

done

rm -f templates_tmp.json
jq -s 'flatten' _*.json > templates.json
rm -f _*.json
cat templates.json

#ls -al
#find ./templates
