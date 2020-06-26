# Getting started using Lua in Neovim

## Introduction

The integration of Lua as a first-class language inside Neovim is shaping up to be one of its killer features. However, the amount of teaching material for learning how to write plugins in Lua is not as large as what you would find for writing them in Vimscript. This is an attempt at providing some basic information to get people started.

This guide assumes you are using the latest [nightly build](https://github.com/neovim/neovim/releases/tag/nightly) of Neovim.

### Learning Lua

### Existing tutorials for writing Lua in Neovim

## Where to put Lua files

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

## Defining autocommands

<!-- TODO: Mention wrapper + pending PR -->

## Making your code more robust

### vim.validate()

### Unit tests

## Miscellaneous

### vim.loop

<!-- TODO: Mention libuv docs + luvit api -->

### vim.lsp

### vim.treesitter
