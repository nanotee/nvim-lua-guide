#!/usr/bin/awk -f
{
    if (lastline ~ /^=+$/) {
        tag = tolower($0)
        gsub(/[^A-Za-z]/, "-", tag)
        print $0
        printf("%80s", "*" "luaguide-" tag "*")
        print ""
    }
    else {
        print
    }
}

{ lastline = $0 }
