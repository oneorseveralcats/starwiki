#!/usr/bin/env bash
#
# DESCRIPTION: uses the mwoffliner tool to download the base zim and then uses
#              a custom article preprocessor to remove the undesired elements
#              from it.

# secrets:
#   EMAIL: added to request headers so <mediawiki> being scraped knows who to
#          contact if scraping is a problem.
source ./secrets

generate_zim() {
  local mwUrl="$1"
  local pageList="$2"
  local customZimTitle="$3"
  local customZimDescription="$4"

  mkdir -p "$(pwd)/out"

  if [ -n "$4" ]; then
    podman run \
      -v "$(pwd)/flavours/starWiki.js":/starWiki.js \
      -v "$(pwd)/test.tsv":/test.tsv \
      -v "$(pwd)"/out:/out \
      -ti ghcr.io/openzim/mwoffliner:dev mwoffliner \
        --adminEmail="$EMAIL" \
        --customFlavour starWiki \
        --mwUrl="$mwUrl" \
        --pageList="$pageList" \
        --customZimTitle="$customZimTitle" \
        --customZimDescription="$customZimDescription" \
        --customZimFilename="$customZimTitle.zim" \
        --javaScript=none \
        --format=nodet,nopdf,nopic:mini \
        --webp
  else
    echo "ERROR: not enough arguments provided!" >&2
  fi
}

# testing () {
#   podman run \
#     -v "$(pwd)/customFlavour.js":/customFlavour.js \
#     -v "$(pwd)/test.tsv":/test.tsv \
#     -v "$(pwd)"/out:/out \
#     -ti ghcr.io/openzim/mwoffliner:dev mwoffliner \
#       --mwUrl=https://en.wikipedia.org/ \
#       --adminEmail=massiet1@mymail.nku.edu \
#       --pageList=test.tsv \
#       --customFlavour customFlavour \
#       --customZimTitle='En Wikipedia 50K Stardict' \
#       --customZimDescription='Top 50,000 English Wikipedia articles as an encyclopedia.' \
#       --customZimFavicon=https://drive.farm.openzim.org/blobs/9a529a27-47d6-4cae-b7cb-d0575d4af56b.png \
#       --customZimFilename=test.zim \
#       --forceRender=ActionParse \
#       --format=nodet,nopdf,nopic:mini \
#       --javaScript=none \
#       --publisher=openZIM \
#       --webp

#       # --minifyHtml \
# }

recipes=(
  "eo"
  "en100k"
  "en1m"
  "testing"
)

case "$1" in
  "eo") generate_zim \
    "https://eo.wikipedia.org/" \
    "" \
    "starwiki_eo" \
    "All Esperanto Wikipedia articles as an encyclopedia."
  ;;
  "en100k") generate_zim \
    "https://en.wikipedia.org/" \
    "https://download.openzim.org/wp1/enwiki/tops/100000.tsv" \
    "starwiki_en_100k" \
    "Top 100,000 English Wikipedia articles as an encyclopedia." \
  ;;
  "en1m") generate_zim \
    "https://en.wikipedia.org/" \
    "https://download.openzim.org/wp1/enwiki/tops/1000000.tsv" \
    "starwiki_en_1m" \
    "Top 1 Million English Wikipedia articles as an encyclopedia." \
  ;;
  "test"|"testing") generate_zim \
    "https://en.wikipedia.org/" \
    "test.tsv" \
    "test" \
    "testing zim." \
  ;;
  "tok") generate_zim \
    "https://tok.wikipedia.org/" \
    "" \
    "starwiki_tok" \
    "All Toki Pona Wikipedia articles as an encyclopedia."
  ;;
  # TODO: create structs with the above information, so that it's possible to
  # loop through all of them and generate all of them. Not sure when/if I would
  # that would take multiple days.
  # "all")
  #   for func in "${recipes[@]}"; do
  #     $func
  #   done
  # ;;
esac
