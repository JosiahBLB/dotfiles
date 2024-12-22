require("conform").setup({
	notify_on_error = false,
	formatters_by_ft = {
		nix = { "nixfmt" },
		lua = { "stylua" },
		python = { "isort", "ruff_python_formatter" }, -- multiple formatters
		javascript = { { "prettierd", "prettier" } }, -- run until a formatter is found
		c = { "clang-format" },
		cpp = { "clang-format" },
		cmake = { "cmake_format" },
	},
})
