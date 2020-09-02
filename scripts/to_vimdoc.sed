#!/bin/sed -f

# Title
/^# / {
    s/# /*nvim-lua-guide.txt*  /
}

# Sections
/^## / {
    s/[a-z]/\u&/g
    s/## //
    i==============================================================================
}

# Sub-sections, tips and caveats
/^####\? / {
    s/####\? //
    s/.*/&~/
}

# Markdown links
/\[.*\](http.*)/ {
    y/[]()/ :  /
}

# Todos
s/\*\*TODO\*\*:/\t*Todo\ttasks:/g

# Warnings
s/\*\*\(WARNING\)\*\*/\1/

# Code blocks
/^```.*$/,/^```$/{
    s/.*/    &/
    s/```.\+/>/
    s/\s*```$/</
}

# Help links
s/- `:help \(.*\)`/- |\1|/

# Trim trailing whitespace
s/\s\+$//

$a\
\
vim:tw=78:ts=8:noet:ft=help:norl:
