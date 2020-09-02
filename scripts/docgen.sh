#!/usr/bin/env sh

./to_vimdoc.sed ../README.md | fmt -s | ./sections_tags.awk > ../doc/nvim-lua-guide.txt
