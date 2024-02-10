#!/usr/bin/env python3

import json
import os
import shutil
from pathlib import Path
ROOT = Path(__file__).parent.parent.parent.resolve()

#{
#        'HugoVersion': 'extended_0.101.0',
#        'HugoTheme': 'summer-qremix',
#        'QuiqrFormsEndPoints': 0,
#        'QuiqrModel': 'base collections menu singles',
#        'QuiqrEtalageName': 'Summer',
#        'QuiqrEtalageDescription': 'Simple fresh looking recipe site, ported from Jekyll to Hugo',
#        'QuiqrEtalageHomepage': 'https://github.com/mipmip/summer-qremix',
#        'QuiqrEtalageDemoUrl': 'https://mipmip.github.io/summer-qremix/',
#        'QuiqrEtalageLicense': 'MIT',
#        'QuiqrEtalageLicenseURL': 'https://github.com/mipmip/summer-qremix/blob/main/LICENSE',
#        'QuiqrEtalageAuthor': 'Connor Bär (Ported by Pim Snel)',
#        'QuiqrEtalageAuthorHomepage': 'https://github.com/connor-baer',
#        'QuiqrEtalageScreenshots': ['quiqr/etalage/screenshots/quiqr-generated-screenshot.jpg'],
#        'ScreenshotImageType': 'jpg',
#        'SourceLink': 'https://github.com/mipmip/summer-qremix',
#        'NormalizedName': 'Summer'
#}


def write_tpl_page(template):

    repos_path = ROOT.joinpath("content", "theme")

    with open(str(repos_path.joinpath(template["NormalizedName"])) + ".md", "w+") as f:
        f.write(
            f"""---
title: {template["NormalizedName"]}
github: {template["QuiqrEtalageHomepage"]}
demo: {template["QuiqrEtalageDemoUrl"]}
author: {template["QuiqrEtalageAuthor"]}
author_link: {template["QuiqrEtalageAuthorHomepage"]}
date: NOTYET
thumbnail: templates/{template["NormalizedName"]}/screenshot.{template["ScreenshotImageType"]}
ssg:
  - Hugo
cms:
  - Quiqr
css:
  - CSS
archetype:
  - Blog
description: {template["QuiqrEtalageDescription"]}
---

# {template["QuiqrEtalageName"]}

"""
        )

def main() -> None:

    with open(ROOT.joinpath( "public2", "templates.json")) as f:
        templates = json.load(f)

        for template in templates:
            print(template)
            print("\n")

            write_tpl_page(template)

if __name__ == "__main__":
    main()
