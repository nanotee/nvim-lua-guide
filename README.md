# Getting started using Lua in Neovim

## Translations

- [🇨🇳 Chinese version](https://github.com/glepnir/nvim-lua-guide-zh)
- [🇧🇷 Portuguese version](https://github.com/npxbr/nvim-lua-guide/blob/master/README.pt-br.md)
- [🇯🇵 Japanesese version](https://github.com/willelz/nvim-lua-guide-ja/blob/master/README.ja.md)

## Table of Contents

* [Introduction](#introduction)
  * [Learning Lua](#learning-lua)
  * [Existing tutorials for writing Lua in Neovim](#existing-tutorials-for-writing-lua-in-neovim)
  * [Companion plugins](#companion-plugins)
* [Where to put Lua files](#where-to-put-lua-files)
    * [Caveats](#caveats)
    * [Tips](#tips)
    * [A note about packages](#a-note-about-packages)
* [Using Lua from Vimscript](#using-lua-from-vimscript)
  * [:lua](#lua)
  * [:luado](#luado)
  * [:luafile](#luafile)
    * [luafile vs require():](#luafile-vs-require)
  * [luaeval()](#luaeval)
  * [v:lua](#vlua)
    * [Caveats](#caveats-1)
  * [Tips](#tips-1)
* [The vim namespace](#the-vim-namespace)
    * [Tips](#tips-2)
* [Using Vimscript from Lua](#using-vimscript-from-lua)
  * [vim.api.nvim_eval()](#vimapinvim_eval)
    * [Caveats](#caveats-2)
  * [vim.api.nvim_exec()](#vimapinvim_exec)
  * [vim.api.nvim_command()](#vimapinvim_command)
    * [Tips](#tips-3)
* [Managing vim options](#managing-vim-options)
  * [Using api functions](#using-api-functions)
  * [Using meta-accessors](#using-meta-accessors)
    * [Caveats](#caveats-3)
* [Managing vim internal variables](#managing-vim-internal-variables)
  * [Using api functions](#using-api-functions-1)
  * [Using meta-accessors](#using-meta-accessors-1)
    * [Caveats](#caveats-4)
* [Calling Vimscript functions](#calling-vimscript-functions)
  * [vim.call()](#vimcall)
  * [vim.fn.{function}()](#vimfnfunction)
    * [Tips](#tips-4)
    * [Caveats](#caveats-5)
* [Defining mappings](#defining-mappings)
* [Defining user commands](#defining-user-commands)
* [Defining autocommands](#defining-autocommands)
* [Defining syntax/highlights](#defining-syntaxhighlights)
* [General tips and recommendations](#general-tips-and-recommendations)
  * [Setting up linters/language servers](#setting-up-linterslanguage-servers)
    * [luacheck](#luacheck)
    * [sumneko/lua-language-server](#sumnekolua-language-server)
    * [coc.nvim](#cocnvim)
* [Miscellaneous](#miscellaneous)
  * [vim.loop](#vimloop)
  * [vim.lsp](#vimlsp)
  * [vim.treesitter](#vimtreesitter)
  * [Transpilers](#transpilers)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)

## Introduction

The integration of Lua as a first-class language inside Neovim is shaping up to be one of its killer features. However, the amount of teaching material for learning how to write plugins in Lua is not as large as what you would find for writing them in Vimscript. This is an attempt at providing some basic information to get people started.

This guide assumes you are using the latest [nightly build](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim. Since version 0.5 of Neovim is a development version, keep in mind that some APIs that are being actively worked on are not quite stable and might change before release.

### Learning Lua

If you are not already familiar with the language, there are plenty of resources to get started:

- The [Learn X in Y minutes page about Lua](https://learnxinyminutes.com/docs/lua/) should give you a quick overview of the basics
- If videos are more to your liking, Derek Banas has a [1-hour tutorial on the language](https://www.youtube.com/watch?v=iMacxZQMPXs)
- The [lua-users wiki](http://lua-users.org/wiki/LuaDirectory) is full of useful information on all kinds of Lua-related topics
- The [official reference manual for Lua](https://www.lua.org/manual/5.1/) should give you the most comprehensive tour of the language

It should also be noted that Lua is a very clean and simple language. It is easy to learn, especially if you have experience with similar scripting languages like JavaScript. You may already know more Lua than you realise!

Note: the version of Lua that Neovim embeds is LuaJIT 2.1.0, which maintains compatibility with Lua 5.1 (with a few 5.2 extensions)

### Existing tutorials for writing Lua in Neovim

A few tutorials have already been written to help people write plugins in Lua. Some of them helped quite a bit when writing this guide. Many thanks to their authors.

- [teukka.tech - From init.vim to init.lua](https://teukka.tech/luanvim.html)
- [2n.pl - How to write neovim plugins in Lua](https://www.2n.pl/blog/how-to-write-neovim-plugins-in-lua.md)
- [2n.pl - How to make UI for neovim plugins in Lua](https://www.2n.pl/blog/how-to-make-ui-for-neovim-plugins-in-lua)
- [ms-jpq - Neovim Async Tutorial](https://ms-jpq.github.io/neovim-async-tutorial/)

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

Lua files are typically found inside a `lua/` folder in your `runtimepath` (for most users, this will mean `~/.config/nvim/lua` on *nix systems and `~/AppData/Local/nvim/lua` on Windows). You can `require()` these files as Lua modules.

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

For more information: `:help lua-require`

#### Caveats

Unlike .vim files, .lua files are not automatically sourced from directories in your `runtimepath`. Instead, you have to source/require them from Vimscript. There are plans to add the option to load an `init.lua` file as an alternative to `init.vim`:

- [Issue #7895](https://github.com/neovim/neovim/issues/7895)
- [Corresponding pull request](https://github.com/neovim/neovim/pull/12235)

#### Tips

Several Lua plugins might have identical filenames in their `lua/` folder. This could lead to namespace clashes.

If two different plugins have a `lua/main.lua` file, then doing `require('main')` is ambiguous: which file do we want to source?

It might be a good idea to namespace your config or your plugin with a top-level folder, like so: `lua/plugin_name/main.lua`

#### A note about packages

**UPDATE**: if you're using the latest nightly build, this is [no longer an issue](https://github.com/neovim/neovim/pull/13119) and you can safely skip this section.

If you're a user of the `packages` feature or a plugin manager based on it (such as [packer.nvim](https://github.com/wbthomason/packer.nvim), [minpac](https://github.com/k-takata/minpac) or [vim-packager](https://github.com/kristijanhusak/vim-packager/)), there are things to be aware of when using Lua plugins.

Packages in the `start` folder are only loaded after sourcing your `init.vim`. This means that a package isn't added to the `runtimepath` until after Neovim has finished processing the file. This can cause issues if a plugin expects you to `require` a Lua module or call an autoloaded function.

Assuming a package `start/foo` has a `lua/bar.lua` file, doing this from your `init.vim` will throw an error because the `runtimepath` hasn't yet been updated:

```vim
lua require('bar')
```

You have to use the `packadd! foo` command before `require`ing the module.

```vim
packadd! foo
lua require('bar')
```

Appending `!` to `packadd` means Neovim will put the package in the `runtimepath` without sourcing any scripts in its `plugin` or `ftdetect` directory.

See also:
- `:help :packadd`
- [Issue #11409](https://github.com/neovim/neovim/issues/11409)

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

See also:

- `:help :lua`
- `:help :lua-heredoc`

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

- `:help :luado`

### :luafile

This command sources a Lua file.

```vim
:luafile ~/foo/bar/baz/myluafile.lua
```

It is analogous to the `:source` command for .vim files or the built-in `dofile()` function in Lua.

See also:

- `:help :luafile`

#### luafile vs require():

You might be wondering what the difference between `lua require()` and `luafile` is and whether you should use one over the other. They have different use cases:

- `require()`:
    - is a built-in Lua function. It allows you to take advantage of Lua's module system
    - searches for modules in `lua` folders in your `runtimepath`
    - keeps track of what modules have been loaded and prevents a script from being parsed and executed a second time. If you change the file containing the code for a module and try to `require()` it a second time while Neovim is running, the module will not actually update
- `:luafile`:
    - is an Ex command. It does not support modules
    - takes a path that is either absolute or relative to the working directory of the current window
    - executes the contents of a script regardless of whether it has been executed before

`:luafile` can also be useful if you want run a Lua file you are working on:

```vim
:luafile %
```

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
- `:help luaeval()`

### v:lua

This global Vim variable allows you to call global Lua functions directly from Vimscript. Again, Vim data types are converted to Lua types and vice versa.

```vim
call v:lua.print('Hello from Lua!')
" 'Hello from Lua!'

let scream = v:lua.string.rep('A', 10)
echo scream
" 'AAAAAAAAAA'

" Requiring modules works
call v:lua.require('mymodule').myfunction()

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
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end
EOF

inoremap <silent> <expr> <Tab>
    \ pumvisible() ? '\<C-n>' :
    \ v:lua.check_back_space() ? '\<Tab>' :
    \ completion#trigger_completion()
```

See also:
- `:help v:lua`
- `:help v:lua-call`

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

You can get Lua syntax highlighting inside .vim files by putting `let g:vimsyn_embed = 'l'` in your configuration file. See `:help g:vimsyn_embed` for more on this option.

## The vim namespace

Neovim exposes a global `vim` variable which serves as an entry point to interact with its APIs from Lua. It provides users with an extended "standard library" of functions as well as various sub-modules.

Some notable functions and modules include:

- `vim.inspect`: pretty-print Lua objects (useful for inspecting tables)
- `vim.regex`: use Vim regexes from Lua
- `vim.api`: module that exposes API functions (the same API used by remote plugins)
- `vim.loop`: module that exposes the functionality of Neovim's event-loop (using LibUV)
- `vim.lsp`: module that controls the built-in LSP client
- `vim.treesitter`: module that exposes the functionality of the tree-sitter library

This list is by no means comprehensive. If you wish to know more about what's made available by the `vim` variable, `:help lua-stdlib` and `:help lua-vim` are the way to go. Alternatively, you can do `:lua print(vim.inspect(vim))` to get a list of every module.

#### Tips

Writing `print(vim.inspect(x))` every time you want to inspect the contents of an object can get pretty tedious. It might be worthwhile to have a global wrapper function somewhere in your configuration:

```lua
function _G.dump(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    print(unpack(objects))
end
```

You can then inspect the contents of an object very quickly in your code or from the command-line:

```lua
dump({1, 2, 3})
```

```vim
:lua dump(vim.loop)
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

**TODO**: is it possible for `vim.api.nvim_eval()` to return a `funcref`?

#### Caveats

Unlike `luaeval()`, `vim.api.nvim_eval()` does not provide an implicit `_A` variable to pass data to the expression.

### vim.api.nvim_exec()

This function evaluates a chunk of Vimscript code. It takes in a string containing the source code to execute and a boolean to determine whether the output of the code should be returned by the function (you can then store the output in a variable, for example).

```lua
local result = vim.api.nvim_exec(
[[
let mytext = 'hello world'

function! MyFunction(text)
    echo a:text
endfunction

call MyFunction(mytext)
]],
true)

print(result) -- 'hello world'
```

**TODO**: The docs say that script-scope (`s:`) is supported, but running this snippet with a script-scoped variable throws an error. Why?

### vim.api.nvim_command()

This function executes an ex command. It takes in a string containing the command to execute.

```lua
vim.api.nvim_command('new')
vim.api.nvim_command('wincmd H')
vim.api.nvim_command('set nonumber')
vim.api.nvim_command('%s/foo/bar/g')
```

Note: `vim.cmd` is a shorter alias for this function

```lua
vim.cmd('buffers')
```

#### Tips

Since you have to pass strings to these functions, you often end up having to escape backslashes:

```lua
vim.cmd('%s/\\Vfoo/bar/g')
```

Literal strings are easier to use as they do not require escaping characters:

```lua
vim.cmd([[%s/\Vfoo/bar/g]])
```

## Managing vim options

### Using api functions

Neovim provides a set of API functions to either set an option or get its current value:

- Global options:
    - `vim.api.nvim_set_option()`
    - `vim.api.nvim_get_option()`
- Buffer-local options:
    - `vim.api.nvim_buf_set_option()`
    - `vim.api.nvim_buf_get_option()`
- Window-local options:
    - `vim.api.nvim_win_set_option()`
    - `vim.api.nvim_win_get_option()`

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

- `vim.o.{option}`: global options
- `vim.bo.{option}`: buffer-local options
- `vim.wo.{option}`: window-local options

```lua
vim.o.smarttab = false
print(vim.o.smarttab) -- false

vim.bo.shiftwidth = 4
print(vim.bo.shiftwidth) -- 4
```

You can specify a number for buffer-local and window-local options. If no number is given, the current buffer/window is used:

```lua
vim.bo[4].expandtab = true -- same as vim.api.nvim_buf_set_option(4, 'expandtab', true)
vim.wo.number = true -- same as vim.api.nvim_win_set_option(0, 'number', true)
```

See also:
- `:help lua-vim-internal-options`

#### Caveats

**WARNING**: The following section is based on a few experiments I did. The docs don't seem to mention this behavior and I haven't checked the source code to verify my claims.  
**TODO**: Can anyone confirm this?

If you've only ever dealt with options using the `:set` command, the behavior of some options might surprise you.

Essentially, options can either be global, local to a buffer/window, or have both a global **and** a local value.

The `:setglobal` command sets the global value of an option.
The `:setlocal` command sets the local value of an option.
The `:set` command sets the global **and** local value of an option.

Here's a handy table from `:help :setglobal`:

|                 Command | global value | local value |
| ----------------------: | :----------: | :---------: |
|       :set option=value |     set      |     set     |
|  :setlocal option=value |      -       |     set     |
| :setglobal option=value |     set      |      -      |

There is no equivalent to the `:set` command in Lua, you either set an option globally or locally.

You might expect the `number` option to be global, but the documentation describes it as being "local to window". Such options are actually "sticky": their value is copied over from the current window when you open a new one.

So if you were to set the option from your `init.lua`, you would do it like so:

```lua
vim.wo.number = true
```

Options that are "local to buffer" like `shiftwidth`, `expandtab` or `undofile`  are even more confusing. Let's say your `init.lua` contains the following code:

```lua
vim.bo.expandtab = true
```

When you launch Neovim and start editing, everything is fine: pressing `<Tab>` inserts spaces instead of a tab character. Open another buffer and you're suddenly back to tabs...

Setting it globally has the opposite problem:

```lua
vim.o.expandtab = true
```

This time, you insert tabs when you first launch Neovim. Open another buffer and pressing `<Tab>` does what you expect.

In short, options that are "local to buffer" have to be set like this if you want the correct behavior:

```lua
vim.bo.expandtab = true
vim.o.expandtab = true
```

See also:
- `:help :setglobal`
- `:help global-local`

**TODO**: Why does this happen? Do all buffer-local options behave this way? Might be related to [neovim/neovim#7658](https://github.com/neovim/neovim/issues/7658) and [vim/vim#2390](https://github.com/vim/vim/issues/2390). Also for window-local options: [neovim/neovim#11525](https://github.com/neovim/neovim/issues/11525) and [vim/vim#4945](https://github.com/vim/vim/issues/4945)

## Managing vim internal variables

### Using api functions

Much like options, internal variables have their own set of API functions:

- Global variables (`g:`):
    - `vim.api.nvim_set_var()`
    - `vim.api.nvim_get_var()`
    - `vim.api.nvim_del_var()`
- Buffer variables (`b:`):
    - `vim.api.nvim_buf_set_var()`
    - `vim.api.nvim_buf_get_var()`
    - `vim.api.nvim_buf_del_var()`
- Window variables (`w:`):
    - `vim.api.nvim_win_set_var()`
    - `vim.api.nvim_win_get_var()`
    - `vim.api.nvim_win_del_var()`
- Tabpage variables (`t:`):
    - `vim.api.nvim_tabpage_set_var()`
    - `vim.api.nvim_tabpage_get_var()`
    - `vim.api.nvim_tabpage_del_var()`
- Predefined Vim variables (`v:`):
    - `vim.api.nvim_set_vvar()`
    - `vim.api.nvim_get_vvar()`

With the exception of predefined Vim variables, they can also be deleted (the `:unlet` command is the equivalent in Vimscript). Local variables (`l:`), script variables (`s:`) and function arguments (`a:`) cannot be manipulated as they only make sense in the context of a Vim script, Lua has its own scoping rules.

If you are unfamiliar with what these variables do, `:help internal-variables` describes them in detail.

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

- `vim.g.{name}`: global variables
- `vim.b.{name}`: buffer variables
- `vim.w.{name}`: window variables
- `vim.t.{name}`: tabpage variables
- `vim.v.{name}`: predefined Vim variables

```lua
vim.g.some_global_variable = {
    key1 = 'value',
    key2 = 300
}

print(vim.inspect(vim.g.some_global_variable)) -- { key1 = "value", key2 = 300 }
```

To delete one of these variables, simply assign `nil` to it:

```lua
vim.g.some_global_variable = nil
```

#### Caveats

Unlike options meta-accessors, you cannot specify a number for buffer/window/tabpage-scoped variables.

Additionally, you cannot add/update/delete keys from a dictionary stored in one of these variables. For example, this snippet of Vimscript code does not work as expected:

```vim
let g:variable = {}
lua vim.g.variable.key = 'a'
echo g:variable
" {}
```

This is a known issue:

- [Issue #12544](https://github.com/neovim/neovim/issues/12544)

## Calling Vimscript functions

### vim.call()

`vim.call()` calls a Vimscript function. This can either be a built-in Vim function or a user function. Again, data types are converted back and forth from Lua to Vimscript.

It takes in the name of the function followed by the arguments you want to pass to that function:

```lua
print(vim.call('printf', 'Hello from %s', 'Lua'))

local reversed_list = vim.call('reverse', { 'a', 'b', 'c' })
print(vim.inspect(reversed_list)) -- { "c", "b", "a" }

local function print_stdout(chan_id, data, name)
    print(data[1])
end

vim.call('jobstart', 'ls', { on_stdout = print_stdout })

vim.call('my#autoload#function')
```

See also:
- `:help vim.call()`

### vim.fn.{function}()

`vim.fn` does the exact same thing as `vim.call()`, but looks more like a native Lua function call:

```lua
print(vim.fn.printf('Hello from %s', 'Lua'))

local reversed_list = vim.fn.reverse({ 'a', 'b', 'c' })
print(vim.inspect(reversed_list)) -- { "c", "b", "a" }

local function print_stdout(chan_id, data, name)
    print(data[1])
end

vim.fn.jobstart('ls', { on_stdout = print_stdout })
```

Hashes `#` aren't valid characters for indentifiers in Lua, so autoload functions have to be called with this syntax:

```lua
vim.fn['my#autoload#function']()
```

See also:
- `:help vim.fn`

#### Tips

Neovim has an extensive library of powerful built-in functions that are very useful for plugins. See `:help vim-function` for an alphabetical list and `:help function-list` for a list of functions grouped by topic.

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

Neovim provides a list of API functions to set, get and delete mappings:

- Global mappings:
    - `vim.api.nvim_set_keymap()`
    - `vim.api.nvim_get_keymap()`
    - `vim.api.nvim_del_keymap()`
- Buffer-local mappings:
    - `vim.api.nvim_buf_set_keymap()`
    - `vim.api.nvim_buf_get_keymap()`
    - `vim.api.nvim_buf_del_keymap()`

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

The final argument is a table containing boolean options for the mapping as defined in `:help :map-arguments` (including `noremap` and excluding `buffer`).

Buffer-local mappings also take a buffer number as their first argument (`0` sets the mapping for the current buffer).

```lua
vim.api.nvim_set_keymap('n', '<leader><Space>', ':set hlsearch!<CR>', { noremap = true, silent = true })
-- :nnoremap <silent> <leader><Space> :set hlsearch<CR>

vim.api.nvim_buf_set_keymap(0, '', 'cc', 'line(".") == 1 ? "cc" : "ggcc"', { noremap = true, expr = true })
-- :noremap <buffer> <expr> cc line('.') == 1 ? 'cc' : 'ggcc'
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
vim.api.nvim_del_keymap('n', '<leader><Space>')
-- :nunmap <leader><Space>
```

Again, `vim.api.nvim_buf_del_keymap()`, takes a buffer number as its first argument, with `0` representing the current buffer.

```lua
vim.api.nvim_buf_del_keymap(0, 'i', '<Tab>')
-- :iunmap <buffer> <Tab>
```

## Defining user commands

There is currently no interface to create user commands in Lua. It is planned, though:

- [Pull request #11613](https://github.com/neovim/neovim/pull/11613)

For the time being, you're probably better off creating commands in Vimscript.

## Defining autocommands

Augroups and autocommands do not have an interface yet but it is being worked on:

- [Pull request #12378](https://github.com/neovim/neovim/pull/12378)

In the meantime, you can either create autocommands in Vimscript or use [this wrapper from norcalli/nvim_utils](https://github.com/norcalli/nvim_utils/blob/master/lua/nvim_utils.lua#L554-L567)

## Defining syntax/highlights

The syntax API is still a work in progress. Here are a couple of pointers:

- [Issue #9876](https://github.com/neovim/neovim/issues/9876)
- [tjdevries/colorbuddy.vim, a library for creating colorschemes in Lua](https://github.com/tjdevries/colorbuddy.vim)
- `:help lua-treesitter`

## General tips and recommendations

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

Example configuration for [sumneko/lua-language-server](https://github.com/sumneko/lua-language-server/) (the example uses the built-in LSP client but the configuration should be identical for other LSP client implementations):

```lua
require'lspconfig'.sumneko_lua.setup {
    settings = {
        Lua = {
            runtime = {
                -- Get the language server to recognize LuaJIT globals like `jit` and `bit`
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'},
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                },
            },
        },
    },
}
```

For more information on how to configure [sumneko/lua-language-server](https://github.com/sumneko/lua-language-server/) see ["Setting without VSCode"](https://github.com/sumneko/lua-language-server/wiki/Setting-without-VSCode)

#### coc.nvim

The [rafcamlet/coc-nvim-lua](https://github.com/rafcamlet/coc-nvim-lua/) completion source for [coc.nvim](https://github.com/neoclide/coc.nvim/) provides completion items for the Neovim stdlib.

**TODO**:
- Hot-reloading of modules
- `vim.validate()`?
- Add stuff about unit tests? I know Neovim uses the [busted](https://olivinelabs.com/busted/) framework, but I don't know how to use it for plugins
- Best practices? I'm not a Lua wizard so I wouldn't know
- How to use LuaRocks packages ([wbthomason/packer.nvim](https://github.com/wbthomason/packer.nvim)?)

## Miscellaneous

### vim.loop

`vim.loop` is the module that exposes the LibUV API. Some resources:

- [Official documentation for LibUV](https://docs.libuv.org/en/v1.x/)
- [Luv documentation](https://github.com/luvit/luv/blob/master/docs.md)
- [teukka.tech - Using LibUV in Neovim](https://teukka.tech/vimloop.html)

See also:
- `:help vim.loop`

### vim.lsp

`vim.lsp` is the module that controls the built-in LSP client. The [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/) repository contains default configurations for popular language servers.

The behavior of the client can be configured using "lsp-handlers". For more information:
- `:help lsp-handler`
- [neovim/neovim#12655](https://github.com/neovim/neovim/pull/12655)
- [How to migrate from diagnostic-nvim](https://github.com/nvim-lua/diagnostic-nvim/issues/73#issue-737897078)

You may also want to take a look at plugins built around the LSP client:
- [nvim-lua/completion-nvim](https://github.com/nvim-lua/completion-nvim)
- [RishabhRD/nvim-lsputils](https://github.com/RishabhRD/nvim-lsputils)

See also:
- `:help lsp`

### vim.treesitter

`vim.treesitter` is the module that controls the integration of the [Tree-sitter](https://tree-sitter.github.io/tree-sitter/) library in Neovim. If you want to know more about Tree-sitter, you may be interested in this [presentation (38:37)](https://www.youtube.com/watch?v=Jes3bD6P0To).

The [nvim-treesitter](https://github.com/nvim-treesitter/) organisation hosts various plugins taking advantage of the library.

See also:
- `:help lua-treesitter`

### Transpilers

One advantage of using Lua is that you don't actually have to write Lua code! There is a multitude of transpilers available for the language.

- [Moonscript](https://moonscript.org/)

Probably one of the most well-known transpilers for Lua. Adds a lots of convenient features like classes, list comprehensions or function literals. The [svermeulen/nvim-moonmaker](https://github.com/svermeulen/nvim-moonmaker) plugin allows you to write Neovim plugins and configuration directly in Moonscript.

- [Fennel](https://fennel-lang.org/)

A lisp that compiles to Lua. You can write configuration and plugins for Neovim in Fennel with the [Olical/aniseed](https://github.com/Olical/aniseed) plugin. Additionally, the [Olical/conjure](https://github.com/Olical/conjure) plugin provides an interactive development environment that supports Fennel (among other languages).

Other interesting projects:
- [TypeScriptToLua/TypeScriptToLua](https://github.com/TypeScriptToLua/TypeScriptToLua)
- [teal-language/tl](https://github.com/teal-language/tl)
- [Haxe](https://haxe.org/)
- [SwadicalRag/wasm2lua](https://github.com/SwadicalRag/wasm2lua)
- [hengestone/lua-languages](https://github.com/hengestone/lua-languages)
