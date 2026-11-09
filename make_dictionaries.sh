#!/usr/bin/env bash
#
# DESCRIPTION: entry point for StarWiki downloader/converter project. Supply a
#              list of a mix of either recipes (e.g. en1m) or wikipedia
#              subdomains (usualy 2-letter language code like "en", "es", "de",
#              "fr", etc.) to scrape wikipedia, and convert it into a stardict
#              dictionary.
#
#
# DEPENDENCIES: bash, docker/podman, sed, pyglossary, python-libzim
# 
# 

is_value_in_array() {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

make_dictionary() {
  local recipe="$1"

  local status=1
  while [[ $status -ne 0 ]]; do
    ./bin/generate_zim.sh "$recipe"
    status=$?
  done

  ./bin/generate_stardict.sh "$recipe"
}



main() {
  source res/wikis

  # local recipes=("${top50[@]}" "${conlangs[@]}" "${others[@]}")
  local recipes=("${top50[@]}" "${conlangs[@]}")
  while [ ! -z "$1" ]; do
    local value="$1"
    if [[ $value = "all" ]]; then
      for recipe in "${recipes[@]}"; do
        make_dictionary "$recipe"
      done
    else
      if (is_value_in_array "$value" "${recipes[@]}"); then
        make_dictionary "$value"
      else
        echo "ERROR: no recipe for $value"
      fi
    fi

    shift
  done
}

main "$@"
