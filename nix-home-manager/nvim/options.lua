-- See `:help vim.o`

-- Defaults
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.o.mouse = "a" -- enable mouse mode
vim.o.breakindent = true
vim.wo.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect" -- better completion experience
vim.o.termguicolors = true
vim.o.splitright = true -- vim-splits behaviour
vim.o.splitbelow = true

-- Editor
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.incsearch = true
vim.o.scrolloff = 8
vim.o.hlsearch = false -- highlight search
vim.wo.number = true -- make line numbers default
vim.o.ignorecase = true -- for searching
vim.o.smartcase = true -- case sensitive when capitals used
vim.o.cursorline = true -- highlight current line
vim.o.inccommand = "split" -- live substitutions

-- Indentation
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- History
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true
vim.opt.isfname:append("@-@")

-- vim: ts=2 sts=2 sw=2 et
