:arrow_upper_left: (Feeling lost? Use the GitHub TOC!)

# Getting started using Lua in Neovim

## Translations

- [:cn: Chinese version](https://github.com/glepnir/nvim-lua-guide-zh)
- [:es: Spanish version](https://github.com/RicardoRien/nvim-lua-guide/blob/master/README.esp.md)
- [:brazil: Portuguese version](https://github.com/npxbr/nvim-lua-guide/blob/master/README.pt-br.md)
- [:jp: Japanese version](https://github.com/willelz/nvim-lua-guide-ja/blob/master/README.ja.md)
- [:ru: Russian version](https://github.com/kuator/nvim-lua-guide-ru)

## Introduction

The [integration of Lua](https://www.youtube.com/watch?v=IP3J56sKtn0) as a [first-class language inside Neovim](https://github.com/neovim/neovim/wiki/FAQ#why-embed-lua-instead-of-x) is shaping up to be one of its killer features.
However, the amount of teaching material for learning how to write plugins in Lua is not as large as what you would find for writing them in Vimscript. This is an attempt at providing some basic information to get people started.

This guide assumes you are using at least version 0.5 of Neovim.

### Learning Lua

If you are not already familiar with the language, there are plenty of resources to get started:

- The [Learn X in Y minutes page about Lua](https://learnxinyminutes.com/docs/lua/) should give you a quick overview of the basics
- [This guide](https://github.com/medwatt/Notes/blob/main/Lua/Lua_Quick_Guide.ipynb) is also a good resource for getting started quickly
- If videos are more to your liking, Derek Banas has a [1-hour tutorial on the language](https://www.youtube.com/watch?v=iMacxZQMPXs)
- Want something a little more interactive with runnable examples? Try [the LuaScript tutorial](https://www.luascript.dev/learn)
- The [lua-users wiki](http://lua-users.org/wiki/LuaDirectory) is full of useful information on all kinds of Lua-related topics
- The [official reference manual for Lua](https://www.lua.org/manual/5.1/) should give you the most comprehensive tour of the language (exists as a Vimdoc plugin if you want to read it from the comfort of your editor: [milisims/nvim-luaref](https://github.com/milisims/nvim-luaref))

It should also be noted that Lua is a very clean and simple language. It is easy to learn, especially if you have experience with similar scripting languages like JavaScript. You may already know more Lua than you realise!

Note: the version of Lua that Neovim embeds is [LuaJIT](https://staff.fnwi.uva.nl/h.vandermeer/docs/lua/luajit/luajit_intro.html) 2.1.0, which maintains compatibility with Lua 5.1.

### Existing tutorials for writing Lua in Neovim

A few tutorials have already been written to help people write plugins in Lua. Some of them helped quite a bit when writing this guide. Many thanks to their authors.

- [teukka.tech - From init.vim to init.lua](https://teukka.tech/luanvim.html)
- [dev.to - How to write neovim plugins in Lua](https://dev.to/2nit/how-to-write-neovim-plugins-in-lua-5cca)
- [dev.to - How to make UI for neovim plugins in Lua](https://dev.to/2nit/how-to-make-ui-for-neovim-plugins-in-lua-3b6e)
- [ms-jpq - Neovim Async Tutorial](https://github.com/ms-jpq/neovim-async-tutorial)
- [oroques.dev - Neovim 0.5 features and the switch to init.lua](https://oroques.dev/notes/neovim-init/)
- [Building A Vim Statusline from Scratch - jdhao's blog](https://jdhao.github.io/2019/11/03/vim_custom_statusline/)
- [Configuring Neovim using Lua](https://icyphox.sh/blog/nvim-lua/)
- [Devlog | Everything you need to know to configure neovim using lua](https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/)

### Companion plugins

- [Vimpeccable](https://github.com/svermeulen/vimpeccable) - Plugin to help write your .vimrc in Lua
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim) - All the lua functions I don't want to write twice
- [popup.nvim](https://github.com/nvim-lua/popup.nvim) - An implementation of the Popup API from vim in Neovim
- [nvim_utils](https://github.com/norcalli/nvim_utils)
- [nvim-luadev](https://github.com/bfredl/nvim-luadev) - REPL/debug console for nvim lua plugins
- [nvim-luapad](https://github.com/rafcamlet/nvim-luapad) - Interactive real time neovim scratchpad for embedded lua engine
- [nlua.nvim](https://github.com/tjdevries/nlua.nvim) - Lua Development for Neovim
- [BetterLua.vim](https://github.com/euclidianAce/BetterLua.vim) - Better Lua syntax highlighting in Vim/NeoVim

## Where to put Lua files

### init.lua

Neovim supports loading an `init.lua` file for configuration instead of the usual `init.vim`.

Note: `init.lua` is of course _completely_ optional. Support for `init.vim` is not going away and is still a valid option for configuration. Do keep in mind that some features are not 100% exposed to Lua yet.

See also:
- [`:help config`](https://neovim.io/doc/user/starting.html#config)

### Modules

Lua modules are found inside a `lua/` folder in your `'runtimepath'` (for most users, this will mean `~/.config/nvim/lua` on \*nix systems and `~/AppData/Local/nvim/lua` on Windows). You can `require()` files in this folder as Lua modules.

Let's take the following folder structure as an example:

```text
📂 ~/.config/nvim
├── 📁 after
├── 📁 ftplugin
├── 📂 lua
│  ├── 🌑 myluamodule.lua
│  └── 📂 other_modules
│     ├── 🌑 anothermodule.lua
│     └── 🌑 init.lua
├── 📁 pack
├── 📁 plugin
├── 📁 syntax
└── 🇻 init.vim
```

The following Lua code will load `myluamodule.lua`:

```lua
require('myluamodule')
```

Notice the absence of a `.lua` extension.

Similarly, loading `other_modules/anothermodule.lua` is done like so:

```lua
require('other_modules.anothermodule')
-- or
require('other_modules/anothermodule')
```

Path separators are denoted by either a dot `.` or a slash `/`.

A folder containing an `init.lua` file can be required directly, without having to specify the name of the file.

```lua
require('other_modules') -- loads other_modules/init.lua
```

Requiring a nonexistent module or a module which contains syntax errors aborts the currently executing script.
`pcall()` may be used to prevent errors.

```lua
local ok, _ = pcall(require, 'module_with_error')
if not ok then
  -- not loaded
end
```

See also:
- [`:help lua-require`](https://neovim.io/doc/user/lua.html#lua-require)

#### Tips

Several Lua plugins might have identical filenames in their `lua/` folder. This could lead to namespace clashes.

If two different plugins have a `lua/main.lua` file, then doing `require('main')` is ambiguous: which file do we want to source?

It might be a good idea to namespace your config or your plugin with a top-level folder, like so: `lua/plugin_name/main.lua`

### Runtime files

Much like Vimscript files, Lua files can be loaded automatically from special folders in your `runtimepath`. Currently, the following folders are supported:

- `colors/`
- `compiler/`
- `ftplugin/`
- `ftdetect/`
- `indent/`
- `plugin/`
- `syntax/`

Note: in a runtime directory, all `*.vim` files are sourced before `*.lua` files.

See also:
- [`:help 'runtimepath'`](https://neovim.io/doc/user/options.html#'runtimepath')
- [`:help load-plugins`](https://neovim.io/doc/user/starting.html#load-plugins)

#### Tips

Since runtime files aren't based on the Lua module system, two plugins can have a `plugin/main.lua` file without it being an issue.

## Using Lua from Vimscript

### :lua

This command executes a chunk of Lua code.

```vim
:lua require('myluamodule')
```

Multi-line scripts are possible using heredoc syntax:

```vim
echo "Here's a bigger chunk of Lua code"

lua << EOF
local mod = require('mymodule')
local tbl = {1, 2, 3}

for k, v in ipairs(tbl) do
    mod.method(v)
end

print(tbl)
EOF
```

Note: each `:lua` command has its own scope and variables declared with the `local` keyword are not accessible outside of the command. This won't work:

```vim
:lua local foo = 1
:lua print(foo)
" prints 'nil' instead of '1'
```

Note 2: the `print()` function in Lua behaves similarly to the `:echomsg` command. Its output is saved in the message-history and can be suppressed by the `:silent` command.

See also:

- [`:help :lua`](https://neovim.io/doc/user/lua.html#Lua)
- [`:help :lua-heredoc`](https://neovim.io/doc/user/lua.html#:lua-heredoc)

### :luado

This command executes a chunk of Lua code that acts on a range of lines in the current buffer. If no range is specified, the whole buffer is used instead. Whatever string is `return`ed from the chunk is used to determine what each line should be replaced with.

The following command would replace every line in the current buffer with the text `hello world`:

```vim
:luado return 'hello world'
```

Two implicit `line` and `linenr` variables are also provided. `line` is the text of the line being iterated upon whereas `linenr` is its number. The following command would make every line whose number is divisible by 2 uppercase:

```vim
:luado if linenr % 2 == 0 then return line:upper() end
```

See also:

- [`:help :luado`](https://neovim.io/doc/user/lua.html#:luado)

### Sourcing Lua files

Neovim provides 3 Ex commands to source Lua files

- `:luafile`
- `:source`
- `:runtime`

`:luafile` and `:source` are very similar:

```vim
:luafile ~/foo/bar/baz/myluafile.lua
:luafile %
:source ~/foo/bar/baz/myluafile.lua
:source %
```

`:source` also supports ranges, which can be useful to only execute part of a script:

```vim
:1,10source
```

`:runtime` is a little different: it uses the `'runtimepath'` option to determine which files to source. See [`:help :runtime`](https://neovim.io/doc/user/repeat.html#:runtime) for more details.

See also:

- [`:help :luafile`](https://neovim.io/doc/user/lua.html#:luafile)
- [`:help :source`](https://neovim.io/doc/user/repeat.html#:source)
- [`:help :runtime`](https://neovim.io/doc/user/repeat.html#:runtime)

#### Sourcing a lua file vs calling require():

You might be wondering what the difference between calling the `require()` function and sourcing a Lua file is and whether you should prefer one way over the other. They have different use cases:

- `require()`:
    - is a built-in Lua function. It allows you to take advantage of Lua's module system
    - searches for modules in `lua/` folders in your `'runtimepath'`
    - keeps track of what modules have been loaded and prevents a script from being parsed and executed a second time. If you change the file containing the code for a module and try to `require()` it a second time while Neovim is running, the module will not actually update
- `:luafile`, `:source` and `:runtime`:
    - are Ex commands. They do not support modules
    - execute the contents of a script regardless of whether it has been executed before
    - `:luafile` and `:source` take a path that is either absolute or relative to the working directory of the current window
    - `:runtime` uses the `'runtimepath'` option to find files

Files sourced via `:source`, `:runtime` or automatically from runtime directories will also show up in `:scriptnames` and `--startuptime`

### luaeval()

This built-in Vimscript function evaluates a Lua expression string and returns its value. Lua data types are automatically converted to Vimscript types (and vice versa).

```vim
" You can store the result in a variable
let variable = luaeval('1 + 1')
echo variable
" 2
let concat = luaeval('"Lua".." is ".."awesome"')
echo concat
" 'Lua is awesome'

" List-like tables are converted to Vim lists
let list = luaeval('{1, 2, 3, 4}')
echo list[0]
" 1
echo list[1]
" 2
" Note that unlike Lua tables, Vim lists are 0-indexed

" Dict-like tables are converted to Vim dictionaries
let dict = luaeval('{foo = "bar", baz = "qux"}')
echo dict.foo
" 'bar'

" Same thing for booleans and nil
echo luaeval('true')
" v:true
echo luaeval('nil')
" v:null

" You can create Vimscript aliases for Lua functions
let LuaMathPow = luaeval('math.pow')
echo LuaMathPow(2, 2)
" 4
let LuaModuleFunction = luaeval('require("mymodule").myfunction')
call LuaModuleFunction()

" It is also possible to pass Lua functions as values to Vim functions
lua X = function(k, v) return string.format("%s:%s", k, v) end
echo map([1, 2, 3], luaeval("X"))
```

`luaeval()` takes an optional second argument that allows you to pass data to the expression. You can then access that data from Lua using the magic global `_A`:

```vim
echo luaeval('_A[1] + _A[2]', [1, 1])
" 2

echo luaeval('string.format("Lua is %s", _A)', 'awesome')
" 'Lua is awesome'
```

See also:
- [`:help luaeval()`](https://neovim.io/doc/user/lua.html#luaeval())

### v:lua

This global Vim variable allows you to call Lua functions in the global namespace ([`_G`](https://www.lua.org/manual/5.1/manual.html#pdf-_G)) directly from Vimscript. Again, Vim data types are converted to Lua types and vice versa.

```vim
call v:lua.print('Hello from Lua!')
" 'Hello from Lua!'

let scream = v:lua.string.rep('A', 10)
echo scream
" 'AAAAAAAAAA'

" How about a nice statusline?
lua << EOF
function _G.statusline()
    local filepath = '%f'
    local align_section = '%='
    local percentage_through_file = '%p%%'
    return string.format(
        '%s%s%s',
        filepath,
        align_section,
        percentage_through_file
    )
end
EOF

set statusline=%!v:lua.statusline()

" Also works in expression mappings
lua << EOF
function _G.check_back_space()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')) and true
end
EOF

inoremap <silent> <expr> <Tab>
    \ pumvisible() ? "\<C-N>" :
    \ v:lua.check_back_space() ? "\<Tab>" :
    \ completion#trigger_completion()

" Call a function from a Lua module by using single quotes and omitting parentheses:
call v:lua.require'module'.foo()
```

See also:
- [`:help v:lua`](https://neovim.io/doc/user/eval.html#v:lua)
- [`:help v:lua-call`](https://neovim.io/doc/user/lua.html#v:lua-call)

#### Caveats

This variable can only be used to call functions. The following will always throw an error:

```vim
" Aliasing functions doesn't work
let LuaPrint = v:lua.print

" Accessing dictionaries doesn't work
echo v:lua.some_global_dict['key']

" Using a function as a value doesn't work
echo map([1, 2, 3], v:lua.global_callback)
```

### Tips

You can get Lua syntax highlighting inside .vim files by putting `let g:vimsyn_embed = 'l'` in your configuration file. See [`:help g:vimsyn_embed`](https://neovim.io/doc/user/syntax.html#g:vimsyn_embed) for more on this option.

## The vim namespace

Neovim exposes a global `vim` variable which serves as an entry point to interact with its APIs from Lua. It provides users with an extended "standard library" of functions as well as various sub-modules.

Some notable functions and modules include:

- `vim.inspect`: transform Lua objects into human-readable strings (useful for inspecting tables)
- `vim.regex`: use Vim regexes from Lua
- `vim.api`: module that exposes API functions (the same API used by remote plugins)
- `vim.ui`: overridable UI functions that can be leveraged by plugins
- `vim.loop`: module that exposes the functionality of Neovim's event-loop (using LibUV)
- `vim.lsp`: module that controls the built-in LSP client
- `vim.treesitter`: module that exposes the functionality of the tree-sitter library

This list is by no means comprehensive. If you wish to know more about what's made available by the `vim` variable, [`:help lua-stdlib`](https://neovim.io/doc/user/lua.html#lua-stdlib) and [`:help lua-vim`](https://neovim.io/doc/user/lua.html#lua-vim) are the way to go. Alternatively, you can do `:lua print(vim.inspect(vim))` to get a list of every module. API functions are documented under [`:help api-global`](https://neovim.io/doc/user/api.html#api-global).

#### Tips

Writing `print(vim.inspect(x))` every time you want to inspect the contents of an object can get pretty tedious. It might be worthwhile to have a global wrapper function somewhere in your configuration (in Neovim 0.7.0+, this function is built-in, see [`:help vim.pretty_print()`](https://neovim.io/doc/user/lua.html#vim.pretty_print())):

```lua
function _G.put(...)
  local objects = {}
  for i = 1, select('#', ...) do
    local v = select(i, ...)
    table.insert(objects, vim.inspect(v))
  end

  print(table.concat(objects, '\n'))
  return ...
end
```

You can then inspect the contents of an object very quickly in your code or from the command-line:

```lua
put({1, 2, 3})
```

```vim
:lua put(vim.loop)
```

Alternatively, you can use the `:lua` command to pretty-print a Lua expression by prefixing it with `=` (Neovim 0.7+ only):
```vim
:lua =vim.loop
```

Additionally, you may find that built-in Lua functions are sometimes lacking compared to what you would find in other languages (for example `os.clock()` only returns a value in seconds, not milliseconds). Be sure to look at the Neovim stdlib (and `vim.fn`, more on that later), it probably has what you're looking for.

## Using Vimscript from Lua

### vim.api.nvim_eval()

This function evaluates a Vimscript expression string and returns its value. Vimscript data types are automatically converted to Lua types (and vice versa).

It is the Lua equivalent of the `luaeval()` function in Vimscript

```lua
-- Data types are converted correctly
print(vim.api.nvim_eval('1 + 1')) -- 2
print(vim.inspect(vim.api.nvim_eval('[1, 2, 3]'))) -- { 1, 2, 3 }
print(vim.inspect(vim.api.nvim_eval('{"foo": "bar", "baz": "qux"}'))) -- { baz = "qux", foo = "bar" }
print(vim.api.nvim_eval('v:true')) -- true
print(vim.api.nvim_eval('v:null')) -- nil
```

#### Caveats

Unlike `luaeval()`, `vim.api.nvim_eval()` does not provide an implicit `_A` variable to pass data to the expression.

### vim.api.nvim_exec()

This function evaluates a chunk of Vimscript code. It takes in a string containing the source code to execute and a boolean to determine whether the output of the code should be returned by the function (you can then store the output in a variable, for example).

```lua
local result = vim.api.nvim_exec(
[[
let s:mytext = 'hello world'

function! s:MyFunction(text)
    echo a:text
endfunction

call s:MyFunction(s:mytext)
]],
true)

print(result) -- 'hello world'
```

#### Caveats

`nvim_exec` does not support script-local variables (`s:`) prior to Neovim 0.6.0

### vim.api.nvim_command()

This function executes an ex command. It takes in a string containing the command to execute.

```lua
vim.api.nvim_command('new')
vim.api.nvim_command('wincmd H')
vim.api.nvim_command('set nonumber')
vim.api.nvim_command('%s/foo/bar/g')
```

### vim.cmd()

Alias for `vim.api.nvim_exec()`. Only the command argument is needed, `output` is always set to `false`.

```lua
vim.cmd('buffers')
vim.cmd([[
let g:multiline_list = [
            \ 1,
            \ 2,
            \ 3,
            \ ]

echo g:multiline_list
]])
```

#### Tips

Since you have to pass strings to these functions, you often end up having to escape backslashes:

```lua
vim.cmd('%s/\\Vfoo/bar/g')
```

Double bracketed strings are easier to use as they do not require escaping characters:

```lua
vim.cmd([[%s/\Vfoo/bar/g]])
```

### vim.api.nvim_replace_termcodes()

This API function allows you to escape terminal codes and Vim keycodes.

You may have come across mappings like this one:

```vim
inoremap <expr> <Tab> pumvisible() ? "\<C-N>" : "\<Tab>"
```

Trying to do the same in Lua can prove to be a challenge. You might be tempted to do it like this:

```lua
function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and [[\<C-N>]] or [[\<Tab>]]
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
```

only to find out that the mapping inserts `\<Tab>` and `\<C-N>` literally...

Being able to escape keycodes is actually a Vimscript feature. Aside from the usual escape sequences like `\r`, `\42` or `\x10` that are common to many programming languages, Vimscript `expr-quotes` (strings surrounded with double quotes) allow you to escape the human-readable representation of Vim keycodes.

Lua doesn't have such a feature built-in. Fortunately, Neovim has an API function for escaping terminal codes and keycodes: `nvim_replace_termcodes()`

```lua
print(vim.api.nvim_replace_termcodes('<Tab>', true, true, true))
```

This is a little verbose. Making a reusable wrapper can help:

```lua
-- The function is called `t` for `termcodes`.
-- You don't have to call it that, but I find the terseness convenient
local function t(str)
    -- Adjust boolean arguments as needed
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

print(t'<Tab>')
```

Coming back to our earlier example, this should now work as expected:

```lua
local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.smart_tab()
    return vim.fn.pumvisible() == 1 and t'<C-N>' or t'<Tab>'
end

vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
```

This is not necessary with `vim.keymap.set()` as it automatically transforms vim keycodes returned by Lua functions in `expr` mappings by default:

```lua
vim.keymap.set('i', '<Tab>', function()
    return vim.fn.pumvisible() == 1 and '<C-N>' or '<Tab>'
end, {expr = true})
```

See also:

- [`:help keycodes`](https://neovim.io/doc/user/intro.html#keycodes)
- [`:help expr-quote`](https://neovim.io/doc/user/eval.html#expr-quote)
- [`:help nvim_replace_termcodes()`](https://neovim.io/doc/user/api.html#nvim_replace_termcodes())

## Managing vim options

### Using api functions

Neovim provides a set of API functions to either set an option or get its current value:

- Global options:
    - [`vim.api.nvim_set_option()`](https://neovim.io/doc/user/api.html#nvim_set_option())
    - [`vim.api.nvim_get_option()`](https://neovim.io/doc/user/api.html#nvim_get_option())
- Buffer-local options:
    - [`vim.api.nvim_buf_set_option()`](https://neovim.io/doc/user/api.html#nvim_buf_set_option())
    - [`vim.api.nvim_buf_get_option()`](https://neovim.io/doc/user/api.html#nvim_buf_get_option())
- Window-local options:
    - [`vim.api.nvim_win_set_option()`](https://neovim.io/doc/user/api.html#nvim_win_set_option())
    - [`vim.api.nvim_win_get_option()`](https://neovim.io/doc/user/api.html#nvim_win_get_option())

They take a string containing the name of the option to set/get as well as the value you want to set it to.

Boolean options (like `(no)number`) have to be set to either `true` or `false`:

```lua
vim.api.nvim_set_option('smarttab', false)
print(vim.api.nvim_get_option('smarttab')) -- false
```

Unsurprisingly, string options have to be set to a string:

```lua
vim.api.nvim_set_option('selection', 'exclusive')
print(vim.api.nvim_get_option('selection')) -- 'exclusive'
```

Number options accept a number:

```lua
vim.api.nvim_set_option('updatetime', 3000)
print(vim.api.nvim_get_option('updatetime')) -- 3000
```

Buffer-local and window-local options also need a buffer number or a window number (using `0` will set/get the option for the current buffer/window):

```lua
vim.api.nvim_win_set_option(0, 'number', true)
vim.api.nvim_buf_set_option(10, 'shiftwidth', 4)
print(vim.api.nvim_win_get_option(0, 'number')) -- true
print(vim.api.nvim_buf_get_option(10, 'shiftwidth')) -- 4
```

### Using meta-accessors

A few meta-accessors are available if you want to set options in a more "idiomatic" way. They essentially wrap the above API functions and allow you to manipulate options as if they were variables:

- [`vim.o`](https://neovim.io/doc/user/lua.html#vim.o): behaves like `:let &{option-name}`
- [`vim.go`](https://neovim.io/doc/user/lua.html#vim.go): behaves like `:let &g:{option-name}`
- [`vim.bo`](https://neovim.io/doc/user/lua.html#vim.bo): behaves like `:let &l:{option-name}` for buffer-local options
- [`vim.wo`](https://neovim.io/doc/user/lua.html#vim.wo): behaves like `:let &l:{option-name}` for window-local options

```lua
vim.o.smarttab = false -- let &smarttab = v:false
print(vim.o.smarttab) -- false
vim.o.isfname = vim.o.isfname .. ',@-@' -- on Linux: let &isfname = &isfname .. ',@-@'
print(vim.o.isfname) -- '@,48-57,/,.,-,_,+,,,#,$,%,~,=,@-@'

vim.bo.shiftwidth = 4
print(vim.bo.shiftwidth) -- 4
```

You can specify a number for buffer-local and window-local options. If no number is given, the current buffer/window is used:

```lua
vim.bo[4].expandtab = true -- same as vim.api.nvim_buf_set_option(4, 'expandtab', true)
vim.wo.number = true -- same as vim.api.nvim_win_set_option(0, 'number', true)
```

These wrappers also have more sophisticated `vim.opt*` variants that provide convenient mechanisms for setting options in Lua. They're similar to what you might be used to in your `init.vim`:

- `vim.opt`: behaves like `:set`
- `vim.opt_global`: behaves like `:setglobal`
- `vim.opt_local`: behaves like `:setlocal`

```lua
vim.opt.smarttab = false
print(vim.opt.smarttab:get()) -- false
```

Some options can be set using Lua tables:

```lua
vim.opt.completeopt = {'menuone', 'noselect'}
print(vim.inspect(vim.opt.completeopt:get())) -- { "menuone", "noselect" }
```

Wrappers for list-like, map-like and set-like options also come with methods and metamethods that work similarly to their `:set+=`, `:set^=` and `:set-=` counterparts in Vimscript.

```lua
vim.opt.shortmess:append({ I = true })
-- alternative form:
vim.opt.shortmess = vim.opt.shortmess + { I = true }

vim.opt.whichwrap:remove({ 'b', 's' })
-- alternative form:
vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' }
```

Be sure to look at [`:help vim.opt`](https://neovim.io/doc/user/lua.html#vim.opt) for more information.

See also:
- [`:help lua-vim-options`](https://neovim.io/doc/user/lua.html#lua-vim-options)

## Managing vim internal variables

### Using api functions

Much like options, internal variables have their own set of API functions:

- Global variables (`g:`):
    - [`vim.api.nvim_set_var()`](https://neovim.io/doc/user/api.html#nvim_set_var())
    - [`vim.api.nvim_get_var()`](https://neovim.io/doc/user/api.html#nvim_get_var())
    - [`vim.api.nvim_del_var()`](https://neovim.io/doc/user/api.html#nvim_del_var())
- Buffer variables (`b:`):
    - [`vim.api.nvim_buf_set_var()`](https://neovim.io/doc/user/api.html#nvim_buf_set_var())
    - [`vim.api.nvim_buf_get_var()`](https://neovim.io/doc/user/api.html#nvim_buf_get_var())
    - [`vim.api.nvim_buf_del_var()`](https://neovim.io/doc/user/api.html#nvim_buf_del_var())
- Window variables (`w:`):
    - [`vim.api.nvim_win_set_var()`](https://neovim.io/doc/user/api.html#nvim_win_set_var())
    - [`vim.api.nvim_win_get_var()`](https://neovim.io/doc/user/api.html#nvim_win_get_var())
    - [`vim.api.nvim_win_del_var()`](https://neovim.io/doc/user/api.html#nvim_win_del_var())
- Tabpage variables (`t:`):
    - [`vim.api.nvim_tabpage_set_var()`](https://neovim.io/doc/user/api.html#nvim_tabpage_set_var())
    - [`vim.api.nvim_tabpage_get_var()`](https://neovim.io/doc/user/api.html#nvim_tabpage_get_var())
    - [`vim.api.nvim_tabpage_del_var()`](https://neovim.io/doc/user/api.html#nvim_tabpage_del_var())
- Predefined Vim variables (`v:`):
    - [`vim.api.nvim_set_vvar()`](https://neovim.io/doc/user/api.html#nvim_set_vvar())
    - [`vim.api.nvim_get_vvar()`](https://neovim.io/doc/user/api.html#nvim_get_vvar())

With the exception of predefined Vim variables, they can also be deleted (the `:unlet` command is the equivalent in Vimscript). Local variables (`l:`), script variables (`s:`) and function arguments (`a:`) cannot be manipulated as they only make sense in the context of a Vim script, Lua has its own scoping rules.

If you are unfamiliar with what these variables do, [`:help internal-variables`](https://neovim.io/doc/user/eval.html#internal-variables) describes them in detail.

These functions take a string containing the name of the variable to set/get/delete as well as the value you want to set it to.

```lua
vim.api.nvim_set_var('some_global_variable', { key1 = 'value', key2 = 300 })
print(vim.inspect(vim.api.nvim_get_var('some_global_variable'))) -- { key1 = "value", key2 = 300 }
vim.api.nvim_del_var('some_global_variable')
```

Variables that are scoped to a buffer, a window or a tabpage also receive a number (using `0` will set/get/delete the variable for the current buffer/window/tabpage):

```lua
vim.api.nvim_win_set_var(0, 'some_window_variable', 2500)
vim.api.nvim_tab_set_var(3, 'some_tabpage_variable', 'hello world')
print(vim.api.nvim_win_get_var(0, 'some_window_variable')) -- 2500
print(vim.api.nvim_buf_get_var(3, 'some_tabpage_variable')) -- 'hello world'
vim.api.nvim_win_del_var(0, 'some_window_variable')
vim.api.nvim_buf_del_var(3, 'some_tabpage_variable')
```

### Using meta-accessors

Internal variables can be manipulated more intuitively using these meta-accessors:

- [`vim.g`](https://neovim.io/doc/user/lua.html#vim.g): global variables
- [`vim.b`](https://neovim.io/doc/user/lua.html#vim.b): buffer variables
- [`vim.w`](https://neovim.io/doc/user/lua.html#vim.w): window variables
- [`vim.t`](https://neovim.io/doc/user/lua.html#vim.t): tabpage variables
- [`vim.v`](https://neovim.io/doc/user/lua.html#vim.v): predefined Vim variables
- [`vim.env`](https://neovim.io/doc/user/lua.html#vim.env): environment variables

```lua
vim.g.some_global_variable = {
    key1 = 'value',
    key2 = 300
}

print(vim.inspect(vim.g.some_global_variable)) -- { key1 = "value", key2 = 300 }

-- target a specific buffer/window/tabpage (Neovim 0.6+)
vim.b[2].myvar = 1
```

Some variable names may contain characters that cannot be used for identifiers in Lua. You can still manipulate these variables by using this syntax: `vim.g['my#variable']`.

To delete one of these variables, simply assign `nil` to it:

```lua
vim.g.some_global_variable = nil
```

See also:
- [`:help lua-vim-variables`](https://neovim.io/doc/user/lua.html#lua-vim-variables)

#### Caveats

You cannot add/update/delete keys from a dictionary stored in one of these variables. For example, this snippet of Vimscript code does not work as expected:

```vim
let g:variable = {}
lua vim.g.variable.key = 'a'
echo g:variable
" {}
```

You can use a temporary variable as a workaround:

```vim
let g:variable = {}
lua << EOF
local tmp = vim.g.variable
tmp.key = 'a'
vim.g.variable = tmp
EOF
echo g:variable
" {'key': 'a'}
```

This is a known issue:

- [Issue #12544](https://github.com/neovim/neovim/issues/12544)

## Calling Vimscript functions

### vim.fn.{function}()

`vim.fn` can be used to call a Vimscript function. Data types are converted back and forth from Lua to Vimscript.

```lua
print(vim.fn.printf('Hello from %s', 'Lua'))

local reversed_list = vim.fn.reverse({ 'a', 'b', 'c' })
print(vim.inspect(reversed_list)) -- { "c", "b", "a" }

local function print_stdout(chan_id, data, name)
    print(data[1])
end

vim.fn.jobstart('ls', { on_stdout = print_stdout })
```

Hashes (`#`) are not valid characters for identifiers in Lua, so autoload functions have to be called with this syntax:

```lua
vim.fn['my#autoload#function']()
```

The functionality of `vim.fn` is identical to `vim.call`, but allows a more Lua-like syntax.

It is distinct from `vim.api.nvim_call_function` in that converting Vim/Lua objects is automatic: `vim.api.nvim_call_function` returns a table for floating point numbers and does not accept Lua closures while `vim.fn` handles these types transparently.

See also:
- [`:help vim.fn`](https://neovim.io/doc/user/lua.html#vim.fn)

#### Tips

Neovim has an extensive library of powerful built-in functions that are very useful for plugins. See [`:help vim-function`](https://neovim.io/doc/user/eval.html#vim-function) for an alphabetical list and [`:help function-list`](https://neovim.io/doc/user/usr_41.html#function-list) for a list of functions grouped by topic.

Neovim API functions can be used directly through `vim.api.{..}`. See [`:help api`](https://neovim.io/doc/user/api.html#API) for information.

#### Caveats

Some Vim functions that should return a boolean return `1` or `0` instead. This isn't a problem in Vimscript as `1` is truthy and `0` falsy, enabling constructs like these:

```vim
if has('nvim')
    " do something...
endif
```

In Lua however, only `false` and `nil` are considered falsy, numbers always evaluate to `true` no matter their value. You have to explicitly check for `1` or `0`:

```lua
if vim.fn.has('nvim') == 1 then
    -- do something...
end
```

## Defining mappings

### API functions

Neovim provides a list of API functions to set, get and delete mappings:

- Global mappings:
    - [`vim.api.nvim_set_keymap()`](https://neovim.io/doc/user/api.html#nvim_set_keymap())
    - [`vim.api.nvim_get_keymap()`](https://neovim.io/doc/user/api.html#nvim_get_keymap())
    - [`vim.api.nvim_del_keymap()`](https://neovim.io/doc/user/api.html#nvim_del_keymap())
- Buffer-local mappings:
    - [`vim.api.nvim_buf_set_keymap()`](https://neovim.io/doc/user/api.html#nvim_buf_set_keymap())
    - [`vim.api.nvim_buf_get_keymap()`](https://neovim.io/doc/user/api.html#nvim_buf_get_keymap())
    - [`vim.api.nvim_buf_del_keymap()`](https://neovim.io/doc/user/api.html#nvim_buf_del_keymap())

Let's start with `vim.api.nvim_set_keymap()` and `vim.api.nvim_buf_set_keymap()`

The first argument passed to the function is a string containing the name of the mode for which the mapping will take effect:

| String value           | Help page     | Affected modes                           | Vimscript equivalent |
| ---------------------- | ------------- | ---------------------------------------- | -------------------- |
| `''` (an empty string) | `mapmode-nvo` | Normal, Visual, Select, Operator-pending | `:map`               |
| `'n'`                  | `mapmode-n`   | Normal                                   | `:nmap`              |
| `'v'`                  | `mapmode-v`   | Visual and Select                        | `:vmap`              |
| `'s'`                  | `mapmode-s`   | Select                                   | `:smap`              |
| `'x'`                  | `mapmode-x`   | Visual                                   | `:xmap`              |
| `'o'`                  | `mapmode-o`   | Operator-pending                         | `:omap`              |
| `'!'`                  | `mapmode-ic`  | Insert and Command-line                  | `:map!`              |
| `'i'`                  | `mapmode-i`   | Insert                                   | `:imap`              |
| `'l'`                  | `mapmode-l`   | Insert, Command-line, Lang-Arg           | `:lmap`              |
| `'c'`                  | `mapmode-c`   | Command-line                             | `:cmap`              |
| `'t'`                  | `mapmode-t`   | Terminal                                 | `:tmap`              |

The second argument is a string containing the left-hand side of the mapping (the key or set of keys that trigger the command defined in the mapping). An empty string is equivalent to `<Nop>`, which disables a key.

The third argument is a string containing the right-hand side of the mapping (the command to execute).

The final argument is a table containing boolean options for the mapping as defined in [`:help :map-arguments`](https://neovim.io/doc/user/map.html#:map-arguments) (including `noremap` and excluding `buffer`). Since Neovim 0.7.0, you can also pass a `callback` option to invoke a Lua function instead of the right-hand side when executing the mapping.

Buffer-local mappings also take a buffer number as their first argument (`0` sets the mapping for the current buffer).

```lua
vim.api.nvim_set_keymap('n', '<Leader><Space>', ':set hlsearch!<CR>', { noremap = true, silent = true })
-- :nnoremap <silent> <Leader><Space> :set hlsearch<CR>
vim.api.nvim_set_keymap('n', '<Leader>tegf',  [[<Cmd>lua require('telescope.builtin').git_files()<CR>]], { noremap = true, silent = true })
-- :nnoremap <silent> <Leader>tegf <Cmd>lua require('telescope.builtin').git_files()<CR>

vim.api.nvim_buf_set_keymap(0, '', 'cc', 'line(".") == 1 ? "cc" : "ggcc"', { noremap = true, expr = true })
-- :noremap <buffer> <expr> cc line('.') == 1 ? 'cc' : 'ggcc'

vim.api.nvim_set_keymap('n', '<Leader>ex', '', {
    noremap = true,
    callback = function()
        print('My example')
    end,
    -- Since Lua function don't have a useful string representation, you can use the "desc" option to document your mapping
    desc = 'Prints "My example" in the message area',
})
```

`vim.api.nvim_get_keymap()` takes a string containing the shortname of the mode for which you want the list of mappings (see table above). The return value is a table containing all global mappings for the mode.

```lua
print(vim.inspect(vim.api.nvim_get_keymap('n')))
-- :verbose nmap
```

`vim.api.nvim_buf_get_keymap()` takes an additional buffer number as its first argument (`0` will get mapppings for the current bufffer)

```lua
print(vim.inspect(vim.api.nvim_buf_get_keymap(0, 'i')))
-- :verbose imap <buffer>
```

`vim.api.nvim_del_keymap()` takes a mode and the left-hand side of a mapping.

```lua
vim.api.nvim_del_keymap('n', '<Leader><Space>')
-- :nunmap <Leader><Space>
```

Again, `vim.api.nvim_buf_del_keymap()`, takes a buffer number as its first argument, with `0` representing the current buffer.

```lua
vim.api.nvim_buf_del_keymap(0, 'i', '<Tab>')
-- :iunmap <buffer> <Tab>
```

### vim.keymap

:warning: The functions discussed in this section are only available in Neovim 0.7.0+

Neovim provides two functions to set/del mappings:
- [`vim.keymap.set()`](https://neovim.io/doc/user/lua.html#vim.keymap.set())
- [`vim.keymap.del()`](https://neovim.io/doc/user/lua.html#vim.keymap.del())

These are similar to the above API functions with added syntactic sugar.

`vim.keymap.set()` takes a string as its first argument. It can also be a table of strings to define mappings for multiple modes at once:

```lua
vim.keymap.set('n', '<Leader>ex1', '<Cmd>lua vim.notify("Example 1")<CR>')
vim.keymap.set({'n', 'c'}, '<Leader>ex2', '<Cmd>lua vim.notify("Example 2")<CR>')
```

The second argument is the left-hand side of the mapping.

The third argument is the right-hand side of the mapping, which can either be a string or a Lua function:

```lua
vim.keymap.set('n', '<Leader>ex1', '<Cmd>echomsg "Example 1"<CR>')
vim.keymap.set('n', '<Leader>ex2', function() print("Example 2") end)
vim.keymap.set('n', '<Leader>pl1', require('plugin').plugin_action)
-- To avoid the startup cost of requiring the module, you can wrap it in a function to require it lazily when invoking the mapping:
vim.keymap.set('n', '<Leader>pl2', function() require('plugin').plugin_action() end)
```

The fourth (optional) argument is a table of options that correspond to the options passed to `vim.api.nvim_set_keymap()`, with a few additions (see [`:help vim.keymap.set()`](https://neovim.io/doc/user/lua.html#vim.keymap.set()) for the full list).

```lua
vim.keymap.set('n', '<Leader>ex1', '<Cmd>echomsg "Example 1"<CR>', {buffer = true})
vim.keymap.set('n', '<Leader>ex2', function() print('Example 2') end, {desc = 'Prints "Example 2" to the message area'})
```

Defining keymaps with a Lua function is different from using a string. The usual way to show information about a keymap like `:nmap <Leader>ex1` will not output useful information (the string itself), but instead only show `Lua function`. It is recommended to add a `desc` key to describe the behavior of your keymap. This is especially important for documenting plugin mappings so users can understand the usage of the keymap more easily.

An interesting feature of this API is that it irons out some historical quirks of Vim mappings:
- Mappings are `noremap` by default, except when the `rhs` is a `<Plug>` mapping. This means you rarely have to think about whether a mapping should be recursive or not:
    ```lua
    vim.keymap.set('n', '<Leader>test1', '<Cmd>echo "test"<CR>')
    -- :nnoremap <Leader>test <Cmd>echo "test"<CR>

    -- If you DO want the mapping to be recursive, set the "remap" option to "true"
    vim.keymap.set('n', '>', ']', {remap = true})
    -- :nmap > ]

    -- <Plug> mappings don't work unless they're recursive, vim.keymap.set() handles that for you automatically
    vim.keymap.set('n', '<Leader>plug', '<Plug>(plugin)')
    -- :nmap <Leader>plug <Plug>(plugin)
    ```
- In `expr` mappings, `nvim_replace_termcodes()` is automatically applied to strings returned from Lua functions:
    ```lua
    vim.keymap.set('i', '<Tab>', function()
        return vim.fn.pumvisible == 1 and '<C-N>' or '<Tab>'
    end, {expr = true})
    ```

See also:
- [`:help recursive_mapping`](https://neovim.io/doc/user/map.html#recursive_mapping)

`vim.keymap.del()` works the same way but deletes mappings instead:

```lua
vim.keymap.del('n', '<Leader>ex1')
vim.keymap.del({'n', 'c'}, '<Leader>ex2', {buffer = true})
```

## Defining user commands

:warning: The API functions discussed in this section are only available in Neovim 0.7.0+

Neovim provides API functions for user-defined commands:

- Global user commands:
    - [`vim.api.nvim_create_user_command()`](https://neovim.io/doc/user/api.html#nvim_create_user_command())
    - [`vim.api.nvim_del_user_command()`](https://neovim.io/doc/user/api.html#nvim_del_user_command())
- Buffer-local user commands:
    - [`vim.api.nvim_buf_create_user_command()`](https://neovim.io/doc/user/api.html#nvim_buf_create_user_command())
    - [`vim.api.nvim_buf_del_user_command()`](https://neovim.io/doc/user/api.html#nvim_buf_del_user_command())

Let's start with `vim.api.nvim_create_user_command()`

The first argument passed to this function is the name of the command (which must start with an uppercase letter).

The second argument is the code to execute when invoking said command. It can either be:

A string (in which case it will be executed as Vimscript). You can use escape sequences like `<q-args>`, `<range>`, etc. like you would with `:command`
```lua
vim.api.nvim_create_user_command('Upper', 'echo toupper(<q-args>)', { nargs = 1 })
-- :command! -nargs=1 Upper echo toupper(<q-args>)

vim.cmd('Upper hello world') -- prints "HELLO WORLD"
```

Or a Lua function. It receives a dictionary-like table that contains the data normally provided by escape sequences (see [`:help nvim_create_user_command()`](https://neovim.io/doc/user/api.html#nvim_create_user_command()) for a list of available keys)
```lua
vim.api.nvim_create_user_command(
    'Upper',
    function(opts)
        print(string.upper(opts.args))
    end,
    { nargs = 1 }
)
```

The third argument lets you pass command attributes as a table (see [`:help command-attributes`](https://neovim.io/doc/user/map.html#command-attributes)). Since you can already define buffer-local user commands with `vim.api.nvim_buf_create_user_command()`, `-buffer` is not a valid attribute.

Two additional attributes are available:
- `desc` allows you to control what gets displayed when you run `:command {cmd}` on a command defined as a Lua callback. Similarly to keymaps, it is recommended to add a `desc` key to commands defined as Lua functions.
- `force` is equivalent to calling `:command!` and replaces a command if one with the same name already exists. It is true by default, unlike its Vimscript equivalent.

The `-complete` attribute can take a Lua function in addition to the attributes listed in [`:help :command-complete`](https://neovim.io/doc/user/map.html#:command-complete).

```lua
vim.api.nvim_create_user_command('Upper', function() end, {
    nargs = 1,
    complete = function(ArgLead, CmdLine, CursorPos)
        -- return completion candidates as a list-like table
        return { 'foo', 'bar', 'baz' }
    end,
})
```

Buffer-local user commands also take a buffer number as their first argument. This is an advantage over `-buffer` which can only define a command for the current buffer.

```lua
vim.api.nvim_buf_create_user_command(4, 'Upper', function() end, {})
```

`vim.api.nvim_del_user_command()` takes a command name.

```lua
vim.api.nvim_del_user_command('Upper')
-- :delcommand Upper
```

Again, `vim.api.nvim_buf_del_user_command()`, takes a buffer number as its first argument, with `0` representing the current buffer.

```lua
vim.api.nvim_buf_del_user_command(4, 'Upper')
```

See also:
- [`:help nvim_create_user_command()`](https://neovim.io/doc/user/api.html#nvim_create_user_command())
- [`:help 40.2`](https://neovim.io/doc/user/usr_40.html#40.2)
- [`:help command-attributes`](https://neovim.io/doc/user/map.html#command-attributes)

### Caveats

The `-complete=custom` attribute automatically filters completion candidates and has built-in wildcard ([`:help wildcard`](https://neovim.io/doc/user/editing.html#wildcard)) support:

```vim
function! s:completion_function(ArgLead, CmdLine, CursorPos) abort
    return join([
        \ 'strawberry',
        \ 'star',
        \ 'stellar',
        \ ], "\n")
endfunction

command! -nargs=1 -complete=custom,s:completion_function Test echo <q-args>
" Typing `:Test st[ae]<Tab>` returns "star" and "stellar"
```

Passing a Lua function to `complete` makes it behave like `customlist` which leaves filtering up to the user:

```lua
vim.api.nvim_create_user_command('Test', function() end, {
    nargs = 1,
    complete = function(ArgLead, CmdLine, CursorPos)
        return {
            'strawberry',
            'star',
            'stellar',
        }
    end,
})

-- Typing `:Test z<Tab>` returns all the completion results because the list was not filtered
```

## Defining autocommands

(this section is a work in progress)

Neovim 0.7.0 has API functions for autocommands. See `:help api-autocmd` for details

- [Pull request #14661](https://github.com/neovim/neovim/pull/14661) (lua: autocmds take 2)

## Defining highlights

(this section is a work in progress)

Neovim 0.7.0 has API functions for highlight groups. See also:

- [`:help nvim_set_hl()`](https://neovim.io/doc/user/api.html#nvim_set_hl())
- [`:help nvim_get_hl_by_id()`](https://neovim.io/doc/user/api.html#nvim_get_hl_by_id())
- [`:help nvim_get_hl_by_name()`](https://neovim.io/doc/user/api.html#nvim_get_hl_by_name())

## General tips and recommendations

### Reloading cached modules

In Lua, the `require()` function caches modules. This is a good thing for performance, but it can make working on plugins a bit cumbersome because modules are not updated on subsequent `require()` calls.

If you'd like to refresh the cache for a particular module, you have to modify the `package.loaded` global table:

```lua
package.loaded['modname'] = nil
require('modname') -- loads an updated version of module 'modname'
```

The [nvim-lua/plenary.nvim](https://github.com/nvim-lua/plenary.nvim) plugin has a [custom function](https://github.com/nvim-lua/plenary.nvim/blob/master/lua/plenary/reload.lua) that does this for you.

### Don't pad Lua strings!

When using double bracketed strings, resist the temptation to pad them! While it is fine to do in contexts where spaces are ignored, it can cause hard to debug issues when whitespace is significant:

```lua
vim.api.nvim_set_keymap('n', '<Leader>f', [[ <Cmd>call foo()<CR> ]], {noremap = true})
```

In the above example, `<Leader>f` is mapped to `<Space><Cmd>call foo()<CR><Space>` instead of `<Cmd>call foo()<CR>`.

### Notes about Vimscript <-> Lua type conversion

#### Converting a variable creates a copy:
You can't directly interact with the reference to a Vim object from Lua or a Lua object from Vimscript.  
For example, the `map()` function in Vimscript modifies a variable in place:

```vim
let s:list = [1, 2, 3]
let s:newlist = map(s:list, {_, v -> v * 2})

echo s:list
" [2, 4, 6]
echo s:newlist
" [2, 4, 6]
echo s:list is# s:newlist
" 1
```

Using this function from Lua creates a copy instead:

```lua
local tbl = {1, 2, 3}
local newtbl = vim.fn.map(tbl, function(_, v) return v * 2 end)

print(vim.inspect(tbl)) -- { 1, 2, 3 }
print(vim.inspect(newtbl)) -- { 2, 4, 6 }
print(tbl == newtbl) -- false
```

#### Conversion is not always possible
This mostly affects functions and tables:

Lua tables that are a mix between a List and a Dictionary can't be converted:

```lua
print(vim.fn.count({1, 1, number = 1}, 1))
-- E5100: Cannot convert given lua table: table should either have a sequence of positive integer keys or contain only string keys
```

While you can call Vim functions in Lua with `vim.fn`, you can't hold references to them. This can cause surprising behaviors:

```lua
local FugitiveHead = vim.fn.funcref('FugitiveHead')
print(FugitiveHead) -- vim.NIL

vim.cmd("let g:test_dict = {'test_lambda': {-> 1}}")
print(vim.g.test_dict.test_lambda) -- nil
print(vim.inspect(vim.g.test_dict)) -- {}
```

Passing Lua functions to Vim functions is OK, storing them in Vim variables is not (fixed in Neovim 0.7.0+):

```lua
-- This works:
vim.fn.jobstart({'ls'}, {
    on_stdout = function(chan_id, data, name)
        print(vim.inspect(data))
    end
})

-- This doesn't:
vim.g.test_dict = {test_lambda = function() return 1 end} -- Error: Cannot convert given lua type
```

Note however that doing the same from Vimscript with `luaeval()` **does** work:

```vim
let g:test_dict = {'test_lambda': luaeval('function() return 1 end')}
echo g:test_dict
" {'test_lambda': function('<lambda>4714')}
```

#### Vim booleans
A common pattern in Vim scripts is to use `1` or `0` instead of proper booleans. Indeed, Vim did not have a separate boolean type until version 7.4.1154.

Lua booleans are converted to actual booleans in Vimscript, not numbers:

```vim
lua vim.g.lua_true = true
echo g:lua_true
" v:true
lua vim.g.lua_false = false
echo g:lua_false
" v:false
```

### Setting up linters/language servers

If you're using linters and/or language servers to get diagnostics and autocompletion for Lua projects, you may have to configure Neovim-specific settings for them. Here are a few recommended settings for popular tools:

#### luacheck

You can get [luacheck](https://github.com/mpeterv/luacheck/) to recognize the `vim` global by putting this configuration in `~/.luacheckrc` (or `$XDG_CONFIG_HOME/luacheck/.luacheckrc`):

```lua
globals = {
    "vim",
}
```

The [Alloyed/lua-lsp](https://github.com/Alloyed/lua-lsp/) language server uses `luacheck` to provide linting and reads the same file.

For more information on how to configure `luacheck`, please refer to its [documentation](https://luacheck.readthedocs.io/en/stable/config.html)

#### sumneko/lua-language-server

The [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/) repository contains [instructions to configure sumneko/lua-language-server](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua) (the example uses the built-in LSP client but the configuration should be identical for other LSP client implementations).

For more information on how to configure [sumneko/lua-language-server](https://github.com/sumneko/lua-language-server/) see ["Setting"](https://github.com/sumneko/lua-language-server/wiki/Setting)

#### coc.nvim

The [rafcamlet/coc-nvim-lua](https://github.com/rafcamlet/coc-nvim-lua/) completion source for [coc.nvim](https://github.com/neoclide/coc.nvim/) provides completion items for the Neovim stdlib.

### Debugging Lua code

You can debug Lua code running in a separate Neovim instance with [jbyuki/one-small-step-for-vimkind](https://github.com/jbyuki/one-small-step-for-vimkind)

The plugin uses the [Debug Adapter Protocol](https://microsoft.github.io/debug-adapter-protocol/). Connecting to a debug adapter requires a DAP client like [mfussenegger/nvim-dap](https://github.com/mfussenegger/nvim-dap/) or [puremourning/vimspector](https://github.com/puremourning/vimspector/).

### Debugging Lua mappings/commands/autocommands

The `:verbose` command allows you to see where a mapping/command/autocommand was defined:

```vim
:verbose map m
```

```text
n  m_          * <Cmd>echo 'example'<CR>
        Last set from ~/.config/nvim/init.vim line 26
```

By default, this feature is disabled in Lua for performance reasons. You can enable it by starting Neovim with a verbose level greater than 0:

```sh
nvim -V1
```

See also:
- [`:help 'verbose'`](https://neovim.io/doc/user/options.html#'verbose')
- [`:help -V`](https://neovim.io/doc/user/starting.html#-V)
- [neovim/neovim#15079](https://github.com/neovim/neovim/pull/15079)

### Testing Lua code

- [plenary.nvim: test harness](https://github.com/nvim-lua/plenary.nvim/#plenarytest_harness)
- [notomo/vusted](https://github.com/notomo/vusted)

### Using Luarocks packages

[wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim) supports Luarocks packages. Instructions for how to set this up are available in the [README](https://github.com/wbthomason/packer.nvim/#luarocks-support)

## Miscellaneous

### vim.loop

`vim.loop` is the module that exposes the LibUV API. Some resources:

- [Official documentation for LibUV](https://docs.libuv.org/en/v1.x/)
- [Luv documentation](https://github.com/luvit/luv/blob/master/docs.md)
- [teukka.tech - Using LibUV in Neovim](https://teukka.tech/posts/2020-01-07-vimloop/)

See also:
- [`:help vim.loop`](https://neovim.io/doc/user/lua.html#vim.loop)

### vim.lsp

`vim.lsp` is the module that controls the built-in LSP client. The [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/) repository contains default configurations for popular language servers.

The behavior of the client can be configured using "lsp-handlers". For more information:
- [`:help lsp-handler`](https://neovim.io/doc/user/lsp.html#lsp-handler)
- [neovim/neovim#12655](https://github.com/neovim/neovim/pull/12655)
- [How to migrate from diagnostic-nvim](https://github.com/nvim-lua/diagnostic-nvim/issues/73#issue-737897078)

You may also want to take a look at [plugins built around the LSP client](https://github.com/rockerBOO/awesome-neovim#lsp)

See also:
- [`:help lsp`](https://neovim.io/doc/user/lsp.html#LSP)

### vim.treesitter

`vim.treesitter` is the module that controls the integration of the [Tree-sitter](https://tree-sitter.github.io/tree-sitter/) library in Neovim. If you want to know more about Tree-sitter, you may be interested in this [presentation (38:37)](https://www.youtube.com/watch?v=Jes3bD6P0To).

The [nvim-treesitter](https://github.com/nvim-treesitter/) organisation hosts various plugins taking advantage of the library.

See also:
- [`:help lua-treesitter`](https://neovim.io/doc/user/treesitter.html#lua-treesitter)

### Transpilers

One advantage of using Lua is that you don't actually have to write Lua code! There is a multitude of transpilers available for the language.

- [Moonscript](https://moonscript.org/)

Probably one of the most well-known transpilers for Lua. Adds a lots of convenient features like classes, list comprehensions or function literals. The [svermeulen/nvim-moonmaker](https://github.com/svermeulen/nvim-moonmaker) plugin allows you to write Neovim plugins and configuration directly in Moonscript.

- [Fennel](https://fennel-lang.org/)

A lisp that compiles to Lua. You can write configuration and plugins for Neovim in Fennel with the [Olical/aniseed](https://github.com/Olical/aniseed) or the [Hotpot](https://github.com/rktjmp/hotpot.nvim) plugin. Additionally, the [Olical/conjure](https://github.com/Olical/conjure) plugin provides an interactive development environment that supports Fennel (among other languages).

- [Teal](https://github.com/teal-language/tl)

The name Teal comes from pronouncing TL (typed lua).  This is exactly what it tries to do - add strong typing to lua while otherwise remaining close to standard lua syntax.  The [nvim-teal-maker](https://github.com/svermeulen/nvim-teal-maker) plugin can be used to write Neovim plugins or configuration files directly in Teal

Other interesting projects:
- [TypeScriptToLua/TypeScriptToLua](https://github.com/TypeScriptToLua/TypeScriptToLua)
- [Haxe](https://haxe.org/)
- [SwadicalRag/wasm2lua](https://github.com/SwadicalRag/wasm2lua)
- [hengestone/lua-languages](https://github.com/hengestone/lua-languages)
