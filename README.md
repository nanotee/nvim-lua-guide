# Getting started using Lua in Neovim

## Introduction

The integration of Lua as a first-class language inside Neovim is shaping up to be one of its killer features. However, the amount of teaching material for learning how to write plugins in Lua is not as large as what you would find for writing them in Vimscript. This is an attempt at providing some basic information to get people started.

This guide assumes you are using the latest [nightly build](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.

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

## Where to put Lua files

Lua files are typically found inside a `lua/` folder in your `runtimepath` (for most users, this will mean `~/.config/nvim/lua` on *nix systems and `~/AppData/Local/nvim/lua` on Windows). The `package.path` and `package.cpath` globals are automatically adjusted to include lua files in this folder. This means you can `require()` these files as Lua modules.

Let's take the following folder structure as an example:

```
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

A folder containing an `init.lua` file can be required directly, without have to specify the name of the file.

```lua
require('other_modules') -- loads other_modules/init.lua
```

For more information: `:help lua-require`

Unlike .vim files, .lua files are not automatically sourced from directories in your `runtimepath`. Instead, you have to source/require them from Vimscript. There are plans to add the option to load an `init.lua` file as an alternative to `init.vim`:

- [Issue #7895](https://github.com/neovim/neovim/issues/7895)
- [Corresponding pull request](https://github.com/neovim/neovim/pull/12235)

## Using Lua from Vimscript

### :lua

### :luado

### :luafile

### luaeval()

### v:lua

## The vim namespace

### vim.inspect()

## Using Vimscript from Lua

### vim.api.nvim_eval()

### vim.api.nvim_exec()

### vim.api.nvim_command()

<!-- TODO: talk about the vim.cmd alias -->

## Managing vim options

### Using api functions

<!-- vim.api.nvim_set_option() -->
<!-- vim.api.nvim_get_option() -->
<!-- vim.api.nvim_buf_set_option() -->
<!-- vim.api.nvim_buf_get_option() -->
<!-- vim.api.nvim_win_set_option() -->
<!-- vim.api.nvim_win_get_option() -->

### Using meta-accessors

<!-- vim.o.{option} -->
<!-- vim.bo.{option} -->
<!-- vim.wo.{option} -->

## Managing vim internal variables

### Using api functions

<!-- vim.api.nvim_set_var() -->
<!-- vim.api.nvim_get_var() -->
<!-- vim.api.nvim_del_var() -->
<!-- vim.api.nvim_buf_set_var() -->
<!-- vim.api.nvim_buf_get_var() -->
<!-- vim.api.nvim_buf_del_var() -->
<!-- vim.api.nvim_win_set_var() -->
<!-- vim.api.nvim_win_get_var() -->
<!-- vim.api.nvim_win_del_var() -->
<!-- vim.api.nvim_tabpage_set_var() -->
<!-- vim.api.nvim_tabpage_get_var() -->
<!-- vim.api.nvim_tabpage_del_var() -->
<!-- vim.api.nvim_set_vvar() -->
<!-- vim.api.nvim_get_vvar() -->

### Using meta-accessors

<!-- vim.g.{name} -->
<!-- vim.b.{name} -->
<!-- vim.w.{name} -->
<!-- vim.t.{name} -->
<!-- vim.v.{name} -->

## Calling Vimscript functions

### vim.api.nvim_call_function()

### vim.call()

### vim.fn.{function}()

## Defining mappings

<!-- nvim_set_keymap() -->
<!-- nvim_get_keymap() -->
<!-- nvim_del_keymap() -->
<!-- nvim_buf_set_keymap() -->
<!-- nvim_buf_get_keymap() -->
<!-- nvim_buf_del_keymap() -->

## Defining user commands

<!-- https://github.com/neovim/neovim/pull/11613 -->

## Defining autocommands

<!-- TODO: Mention wrapper + pending PR -->

## Making your code more robust

### vim.validate()

### Unit tests

## Miscellaneous

### vim.loop

<!-- TODO: Mention libuv docs + luvit api -->
<!-- https://teukka.tech/vimloop.html -->

### vim.lsp

### vim.treesitter

<!-- TODO: add interesting projects (transpilers) -->
<!-- https://github.com/svermeulen/nvim-moonmaker -->
<!-- https://github.com/Olical/aniseed -->
<!-- https://github.com/Olical/conjure -->
<!-- https://github.com/TypeScriptToLua/TypeScriptToLua -->
<!-- https://github.com/teal-language/tl -->
<!-- https://haxe.org/ -->
<!-- https://github.com/SwadicalRag/wasm2lua -->
<!-- https://github.com/hengestone/lua-languages -->
