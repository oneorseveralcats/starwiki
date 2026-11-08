#!/usr/bin/env bash
source ./.venv/bin/activate

# Takes a Zim file and generates a stardict file in the "stardict" subdirectory
# that the Zim is in.
#
# Argument:
#   $1 is the path to a Zim file.
generate_stardict() {
  local in_file="$1"

  local base_name
  base_name="$(basename "$in_file" '.zim')"

  local dir_name
  dir_name="$(dirname "$1")"

  local out_dir="$dir_name/stardict/$base_name"
  local out_file="$out_dir/$base_name.ifo"
  local out_file_uncompressed="${out_dir}_uncompressed/${base_name}.ifo"

  if [ -e "$in_file" ]; then
    if [ ! -e "$out_file" ]; then
      mkdir -p "$out_dir"
      pyglossary \
         --read-format="Zim" \
         --sqlite \
         --write-options="dictzip=True" \
         "$in_file" \
         "$out_file"

      pyglossary \
         --read-format="Zim" \
         --sqlite \
         "$in_file" \
         "$out_file_uncompressed"

    else
      echo "Error: '$out_file' already exists!" >&2
    fi
  else
    echo "Error: '$in_file' doesn't exist!" >&2
  fi
}

recipes=(
 "eo" 
 "en100k"
 "en1m"
 "testing"
)

case "$1" in
  "eo") generate_stardict "./out/starwiki_eo_all.zim";;
  "en100k") generate_stardict "./out/starwiki_en_100k.zim";;
  "en1m") generate_stardict "./out/starwiki_en_1m.zim";;
  "test"|"testing") generate_stardict "./out/test.zim";;
  "tok") generate_stardict "./out/starwiki_tok_all.zim";;
  "all")
    for in_file in "${recipes[@]}"; do
      generate_stardict "$in_file"
    done
  ;;
esac

