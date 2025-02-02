--[[ nvim-dap ]]

local dap = require("dap")

-- Setup debugging executables
local lldb_path = vim.fn.exepath("lldb-dap")
if lldb_path ~= "" then
	dap.adapters.lldb = {
		type = "executable",
		command = lldb_path,
		name = "lldb",
	}
end

-- Define language specific debug config
dap.configurations.cpp = {
	{
		name = "Launch",
		type = "lldb",
		request = "launch",
		program = function()
			-- use the cached file location
			if vim.g.cpp_executable_file_path and vim.loop.fs_stat(vim.g.cpp_executable_file_path) then
				return vim.g.cpp_executable_file_path
			end

			-- get the user input location for the exe
			local path = vim.fn.input({
				prompt = "Path to executable: ",
				default = vim.fn.getcwd() .. "/",
				completion = "file",
			})

			-- save the new location
			if path ~= "" then
				vim.g.cpp_executable_file_path = path
				return path
			end
			return nil
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
}

-- Override run_last implementation
dap.run_last = function()
	if dap.last_run then
		dap.run(dap.last_run.config, dap.last_run.opts)
	else
		dap.continue()
	end
end

-- [[ nvim-dap-virtual-text ]]
local vt = require("nvim-dap-virtual-text")
vt.setup({})

-- [[ nvim-dap-ui ]]
local ui = require("dapui")
ui.setup({ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } })

-- Open UI and enable virtual text on DAP initialization
local function open_dap_ui()
	ui.open()
	vt.enable()
end

-- Close UI and disable virtual text on DAP termination
local function close_dap_ui()
	vt.disable()
	ui.close()
end

dap.listeners.after.event_initialized["dapui_config"] = open_dap_ui

dap.listeners.before.event_terminated["dapui_config"] = close_dap_ui

dap.listeners.before.event_exited["dapui_config"] = close_dap_ui
