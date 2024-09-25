require("which-key").setup()

-- Document existing key chains
require("which-key").register({
	{ "", group = "[C]ode" },
	{ "", desc = "<leader>c_", hidden = true },
	{ "", group = "[S]earch" },
	{ "", desc = "<leader>s_", hidden = true },
	{ "", group = "[T]oggle" },
	{ "", desc = "<leader>t_", hidden = true },
	{ "", group = "[W]orkspace" },
	{ "", desc = "<leader>w_", hidden = true },
	{ "", group = "[R]ename" },
	{ "", desc = "<leader>r_", hidden = true },
	{ "", group = "Git [H]unk" },
	{ "", desc = "<leader>h_", hidden = true },
	{ "", group = "[D]ocument" },
	{ "", desc = "<leader>d_", hidden = true },
})

-- visual mode
require("which-key").register({
	{ "<leader>h", desc = "Git [H]unk", mode = "v" },
})
