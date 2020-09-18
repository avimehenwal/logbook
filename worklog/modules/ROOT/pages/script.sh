#!/bin/bash

# AUTHOR      : avimehenwal
# DATE        : 18 - Sep - 2020
# PURPOSE     : entrypoint script
# FILENAME    : script.sh
#
# Long problem description

function build {
  asciidoctor \
    --backend html5 \
    --section-numbers \
    --require asciidoctor-diagram \
    --require asciidoctor-chart \
    --base-dir . \
    --destination-dir SITE \
    --verbose --timings \
    "**/*.adoc"
}

# Hierarchy is not supported in asciidoc
# If I start writing chapters in `chapter/*.adoc` directory, it would still be located at root
# in destination folder. Hierarchy with `chapter` is skipped
function trim {
  string=$1
  prefix="./"
  suffix=".adoc"
  foo=${string#"$prefix"}
  foo=${foo%"$suffix"}
  echo ${foo} | sed 's/Chapters\///g'
}

function index_gen {
  INDEX="index.adoc"
  echo > ${INDEX}
cat <<EOT > ${INDEX}
= Index File

.Pages
EOT

  for FILE in $(find . -type f -name '*.adoc' ! -name 'index.adoc')
    do
      # LINK=$($FILE" | sed 's/.adoc//g' | sed 's/.\///g')
      # echo ${FILE}
      LINK=$(trim $FILE)
      echo "* link:${LINK}[${LINK^}]" | tee --append ${INDEX}
    done
}

# function epub {
  # https://github.com/asciidoctor/docker-asciidoctor
# }

# function pdf {
  # use docker
# }

# MAIN
build
index_gen


# END