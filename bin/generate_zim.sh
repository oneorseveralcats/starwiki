#!/usr/bin/env bash
#
# DESCRIPTION: uses the mwoffliner tool to download the base zim and then uses
#              a custom article preprocessor to remove the undesired elements
#              from it.

# options:
#   EMAIL: added to request headers so <mediawiki> being scraped knows who to
#          contact if scraping is a problem.
#   SPEED: number of parallel workers to do the scraping
source ./options

generate_zim() {
  local mwUrl="$1"
  local pageList="$2"
  local customZimTitle="$3"

  local CMD
  if command -v podman &> /dev/null; then
    CMD=podman
  elif command -v docker &> /dev/null; then
    CMD=docker
  else
    echo "ERROR: container engine not found. Install either docker or podman"
    exit 127
  fi

  mkdir -p "$(pwd)/out"

  if [ -n "$3" ]; then
    $CMD run \
      -v "$(pwd)/res/flavours/starWiki.js":/starWiki.js \
      -v "$(pwd)/res/test.tsv":/test.tsv \
      -v "$(pwd)"/out:/out \
      -ti ghcr.io/openzim/mwoffliner:dev mwoffliner \
        --adminEmail="$EMAIL" \
        --customFlavour starWiki \
        --mwUrl="$mwUrl" \
        --pageList="$pageList" \
        --customZimTitle="$customZimTitle" \
        --customZimFilename="$customZimTitle.zim" \
        --javaScript=none \
        --format=nodet,nopdf,nopic:mini \
        --resume\
        --webp \
        --speed=$SPEED
  else
    echo "ERROR: not enough arguments provided!" >&2
  fi
}

generate_zim_wiki() {
  local languageCode="$1"
  local pages="$2"
  local variant="$3"

  local pageList
  if [[ $pages == /* ]]; then
    pageList="$pages"
  elif [[ $pages == "all" || $pages == "" ]]; then
    pageList=""
  else
    pageList="https://download.openzim.org/wp1/${languageCode}wiki/${pages}"
  fi

  generate_zim \
    "https://${languageCode}.wikipedia.org/" \
    "$pageList" \
    "starwiki_${languageCode}_${variant}"
}

generate_zim_1m_wiki() {
  local languageCode="$1"
  
  generate_zim_wiki "$languageCode" "tops/1000000.tsv" "1m"
}

generate_zim_full_wiki() {
  local languageCode="$1"
  
  generate_zim_wiki "$languageCode" "all" "all"
}

main() {
  local match="$1"
  case "$match" in
    *1m) generate_zim_1m_wiki "${match::-2}";;

    test*) generate_zim_wiki "en" "/test.tsv" "testing";;

    *) generate_zim_full_wiki "$match";;
  esac
}

main "$@"
