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

  local out_dir_uncompressed="$dir_name/stardict/${base_name}_uncompressed"
  local out_file_uncompressed="${out_dir_uncompressed}/${base_name}.ifo"

  if [ -e "$in_file" ]; then
    if [ ! -e "$out_file" ]; then
      mkdir -p "$out_dir"
      pyglossary \
         --read-format="Zim" \
         --sqlite \
         --write-options="dictzip=True" \
         "$in_file" \
         "$out_file"

      mkdir -p "$out_dir_uncompressed"
      pyglossary \
         --read-format="Zim" \
         --sqlite \
         "$in_file" \
         "$out_file_uncompressed"

      sed -i 's_\(bookname=.*\)\.zim_\1_g' "$out_file"
      sed -i 's_\(bookname=.*\)\.zim_\1_g' "$out_file_uncompressed"

      pushd "$out_dir" || exit
      tar -czf ../"$base_name".tar.gz ./*
      popd || exit

      pushd "$out_dir_uncompressed" || exit
      tar -czf ../"${base_name}_uncompressed".tar.gz ./*
      popd || exit

      rm -rf "$out_dir"
      rm -rf "$out_dir_uncompressed"
    else
      echo "Error: '$out_file' already exists!" >&2
    fi
  else
    echo "Error: '$in_file' doesn't exist!" >&2
  fi
}

main() {
  local match="$1"
  case "$match" in
    *1m) generate_stardict "./out/starwiki_${match::-2}_1m.zim";;
    test*) generate_stardict "./out/test.zim";;
    *) generate_stardict "./out/starwiki_${1}_all.zim";;
  esac
}

main "$@"

