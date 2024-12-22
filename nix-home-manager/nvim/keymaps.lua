-- See `:help vim.keymap.set()`

--[[ Standard Keymaps ]]
-- Keymaps for better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Screen centred half page jump down" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Screen centred half page jump up" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Screen centred jump to previous search term" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Screen centred jump to next search term" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set({ "n", "v", "i" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
-- visual mode selection movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
-- pasting
vim.keymap.set("x", "<leader>p", [["_d"*P]], { desc = "Paste and replace selection from clipboard" })
vim.keymap.set("n", "<leader>p", [["*p]], { desc = "Paste from system clipboard" })
vim.keymap.set("n", "<leader>P", [["*P]], { desc = "Paste from system clipboard" })
-- copying
vim.keymap.set({ "n", "v" }, "<M-c>", [["*y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["*Y]], { desc = "Yank to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["*y]], { desc = "Yank to system clipboard" })

--[[ NvimTree ]]
vim.keymap.set("n", "<leader>t", "<cmd>Neotree toggle<CR>", { desc = "Open file browser" })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

--[[ Telescope ]]
-- Fuzzy finding (See `:help telescope.builtin`)
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

-- Slightly advanced example of overriding default behavior and theme
vim.keymap.set("n", "<leader>/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "[S]earch [/] in Open Files" })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })

--[[ Conform ]]
vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "[F]ormat document" })

--[[ Nvim-dap]]
local dap = require("dap")

vim.keymap.set("n", "<leader>dk", function()
	dap.continue()
end, { desc = "Continue" })

vim.keymap.set("n", "<leader>dq", function()
	dap.close()
	require("dapui").close()
end, { desc = "Close" })

vim.keymap.set("n", "<leader>dl", function()
	dap.run_last()
end, { desc = "Run last" })

vim.keymap.set("n", "<leader>b", function()
	dap.toggle_breakpoint()
end, { desc = "Toggle breakpoint" })

vim.keymap.set("n", "<leader>dr", function()
	dap.repl.open()
end, { desc = "Open REPL" })

vim.keymap.set("n", "<leader>db", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Set conditional breakpoint" })

vim.keymap.set("n", "<leader>dc", function()
	dap.run_to_cursor()
end, { desc = "Continue to cursor" })

vim.keymap.set("n", "<leader>ds", function()
	dap.step_into()
end, { desc = "Step into" })

vim.keymap.set("n", "<leader>di", function()
	dap.step_out()
end, { desc = "Step out" })

vim.keymap.set("n", "<leader>dd", function()
	dap.step_over()
end, { desc = "Step over" })

vim.keymap.set("n", "<leader>dp", function()
	dap.pause()
end, { desc = "Pause execution" })

vim.keymap.set("n", "<leader>de", function()
	dap.goto_()
end, { desc = "Edit source" })

vim.keymap.set("n", "<leader>dw", function()
	dap.ui.widgets.hover()
end, { desc = "Show variables" })
