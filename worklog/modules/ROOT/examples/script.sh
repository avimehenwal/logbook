#!/bin/bash

# AUTHOR      : avimehenwal
# DATE        : 18 - Sep - 2020
# PURPOSE     : entrypoint script
# FILENAME    : script.sh
#
# Long problem description

APT_DEPENDENCIES=(bash bats make)
SNAP_DEPENDENCIES=(docker)

# https://www.utf8-chartable.de/unicode-utf8-table.pl?start=9984&number=128&names=-&utf8=string-literal
Y="\xe2\x9c\x97"
X="\xE2\x9C\x94"
F="\xe2\x9c\x88"

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

function apt_package_status {
  PKG=$1
  dpkg --status ${PKG} > /dev/null 2>&1
  status=$(echo $?)
  if  [ ${status} -ne 0 ]; then
    printf "${Y}  ${PKG}  ${F}  installing ${PKG^^}...\n"
    sudo apt install -y ${PKG}
  else
    printf "${X}  ${PKG}\n"
  fi
}

function install_apt_dependencies {
  for PACKAGE in "${APT_DEPENDENCIES[@]}"
  do
    apt_package_status ${PACKAGE}
  done
}

# function epub {
  # https://github.com/asciidoctor/docker-asciidoctor
# }

# function pdf {
  # use docker
# }

# MAIN
# build
# index_gen
install_apt_dependencies

# END