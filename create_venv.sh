#!/usr/bin/env bash

# only required until python-libzim is in nixpkgs

venv_dir="./.venv"

python -m venv "$venv_dir"
source "$venv_dir/bin/activate"

pip install --upgrade pip
pip install --ignore-installed pyglossary libzim python-idzip
