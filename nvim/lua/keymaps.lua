-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Keymaps for better default experience
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Screen centred half page jump down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Screen centred half page jump up' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Screen centred jump to previous search term' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Screen centred jump to next search term' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set({ 'n', 'v', 'i' }, '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- visual mode selection movement
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })
-- pasting
vim.keymap.set('x', '<leader>p', [["_d"*P]], { desc = 'Paste and replace selection from clipboard' })
vim.keymap.set('n', '<leader>p', [["*p]], { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<leader>P', [["*P]], { desc = 'Paste from system clipboard' })
-- copying
vim.keymap.set({ 'n', 'v' }, '<M-c>', [["*y]], { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', [["*Y]], { desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["*y]], { desc = 'Yank to system clipboard' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
