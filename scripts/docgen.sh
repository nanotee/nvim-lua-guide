#!/usr/bin/env sh

SCRIPT_ROOT="$(dirname "$0")"

"$SCRIPT_ROOT"/to_vimdoc.sed "$SCRIPT_ROOT"/../README.md | fmt -s | "$SCRIPT_ROOT"/sections_tags.awk > "$SCRIPT_ROOT"/../doc/nvim-lua-guide.txt
