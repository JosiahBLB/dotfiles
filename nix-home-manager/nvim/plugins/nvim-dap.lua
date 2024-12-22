--[[ Nvim-dap ]]

local dap = require("dap")
dap.set_log_level("DEBUG")
local handle = io.popen("which lldb-vscode")
local lldb_path
if handle then
	lldb_path = handle:read("*a")
	handle:close()
end
lldb_path = lldb_path:gsub("%s+", "")

-- Set up DAP configurations
dap.adapters.lldb = {
	type = "executable",
	command = lldb_path,
	name = "lldb",
}

dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			local path = vim.fn.input({
				prompt = "Path to executable: ",
				default = vim.fn.getcwd() .. "/",
				completion = "file",
			})
			return (path and path ~= "") and path or dap.ABORT
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

-- [[ Nvim-dap-ui ]]

require("dapui").setup({
	"rcarriga/nvim-dap-ui",
	dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
})

-- Automatically open and close the DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
	require("dapui").open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	require("dapui").close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	require("dapui").close()
end
