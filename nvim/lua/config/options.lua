-- stylua: ignore
---@diagnostic disable: undefined-global

-- set leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Highlight current line.
vim.opt.cursorline = true

-- Add line numbers.
vim.wo.number = true
vim.wo.relativenumber = true

-- Disable netrw.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set default split directions.
vim.opt.splitright = true -- Vertical splits open on the left.
vim.opt.splitbelow = true -- Horizontal splits open at the bottom.

-- Set border for floating windows.
vim.o.winborder = "single"

vim.lsp.config("*", {
    -- Use the same border for LSP hover and signature help.
    border = "single",
})

-- change tab size
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

vim.opt.swapfile = false

vim.o.conceallevel = 2 -- set conceal level for obsidian plugin
