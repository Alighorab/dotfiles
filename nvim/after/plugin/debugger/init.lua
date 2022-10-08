local Remap = require("keymap")
local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")
local telescope = require("telescope")

local nnoremap = Remap.nnoremap

vim.fn.sign_define(
	"DapBreakpoint",
	{ text = "●", texthl = "", linehl = "debugBreakpoint", numhl = "debugBreakpoint" }
)
vim.fn.sign_define(
	"DapBreakpointCondition",
	{ text = "◆", texthl = "", linehl = "debugBreakpoint", numhl = "debugBreakpoint" }
)
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "debugPC", numhl = "debugPC" })

dap.defaults.fallback.force_external_terminal = true

daptext.setup({
	enabled = true,
	enabled_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = true,
	show_stop_reason = true,
	commented = false,
	only_first_definition = true,
	all_references = true,
	filter_references_pattern = "<module",
})

dapui.setup({
	layouts = {
		{
			elements = {
				"watches",
				{ id = "scopes", size = 0.5 },
				{ id = "repl", size = 0.15 },
			},
			size = 79,
			position = "left",
		},
		{
			elements = {
				"console",
			},
			size = 0.25,
			position = "bottom",
		},
	},
	controls = {
		-- Requires Neovim nightly (or 0.8 when released)
		enabled = true,
		-- Display controls in this element
		element = "repl",
		icons = {
			pause = "",
			play = "",
			step_into = "",
			step_over = "",
			step_out = "",
			step_back = "",
			run_last = "↻",
			terminate = "□",
		},
	},
})

telescope.load_extension("dap")

-- Start
nnoremap("<F9>", function()
	dap.continue()
	dapui.open({})
end)

-- Exit
nnoremap("<F7>", function()
	dap.terminate()
	dapui.close({})
	vim.cmd("sleep 50ms")
	dap.repl.close()
end)

-- Restart
nnoremap("<F21>", function()
	dap.terminate()
	vim.cmd("sleep 50ms")
	dap.repl.close()
	dap.continue()
end) -- Shift F9

nnoremap("<leader>B", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

nnoremap("<F8>", function()
	dap.toggle_breakpoint()
end)

nnoremap("<F20>", function()
	dap.clear_breakpoints()
end) -- SHIFT+F8

nnoremap("<F10>", function()
	dap.step_over()
end)

nnoremap("<leader>rc", function()
	dap.run_to_cursor()
end)

nnoremap("<F11>", function()
	dap.step_into()
end)

nnoremap("<F12>", function()
	dap.step_out()
end)

nnoremap("<leader>dp", function()
	dap.pause()
end)

nnoremap("<leader>dtc", function()
	telescope.extensions.dap.commands({})
end)
