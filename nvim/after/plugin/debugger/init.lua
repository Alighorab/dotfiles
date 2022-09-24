local Remap = require("keymap")
local dap = require("dap")
local dapui = require("dapui")
local daptext = require("nvim-dap-virtual-text")

local nnoremap = Remap.nnoremap

-- Config --

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

daptext.setup()

dapui.setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = {
		{
			elements = {
				"watches",
                "stacks",
                "scopes",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				"console",
			},
			size = 10,
			position = "bottom",
		},
	},
})

-- Functions

local setup = function ()
    local args
    Target = vim.fn.input('Debug target [{f}ile, {p}roject]: ')
    Exec = nil
    Args = {}
    if Target == "p" then
        Exec = vim.fn.input('Exec name: ')
    end
    args = vim.fn.input(string.format("argv: "))
    for arg in string.gmatch(args, "%S+") do
        table.insert(Args, arg)
    end
    vim.cmd('echo ""')
end

local compile = function()
    local file_type = vim.bo.filetype
    if Target == "f" then
        local file_name = vim.fn.expand("%")

        if file_type == "c" then
            os.execute(string.format("gcc -g %s -o debug", file_name))
        elseif file_type == "cpp" then
            os.execute(string.format("gcc -g %s -o debug", file_name))
        elseif file_type == "rust" then
            os.execute("cargo build")
        end
    elseif Target == "p" then
        if file_type == "rust" then
            os.execute("cargo build")
        else
            os.execute("make")
        end
    end
end

local continue = function()
    if Target == "f" or Target == "p" then
        dapui.open()
        compile()
        dap.continue()
    else
        vim.cmd('echohl WarningMsg | echo "Type <F6> to call setup()" | echohl None')
    end
end

local terminate = function()
	dap.terminate()
    if Target == "f" then
        os.remove("debug")
    elseif Target == "p" then
        os.execute("make clean")
    end
end

local restart = function()
	dap.terminate()
	vim.cmd("sleep 50ms")
	compile()
	dap.continue()
end

local exit = function()
	dap.terminate()
	dapui.close()
	vim.cmd("sleep 50ms")
	dap.repl.close()
    if Target == "f" then
        os.remove("debug")
    elseif Target == "p" then
        os.execute("make clean")
    end
end

-- Mappings --

nnoremap('<F6>', setup)

nnoremap("<F9>", continue)

nnoremap("<F21>", terminate) -- SHIFT+F9

nnoremap("<F45>", restart) -- CTRL+SHIFT+F9

nnoremap("<F7>", exit)

nnoremap("<leader>B", function()
	dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end)

nnoremap("<F8>", dap.toggle_breakpoint)

nnoremap("<F20>", dap.clear_breakpoints) -- SHIFT+F8

nnoremap("<F10>", dap.step_over)

nnoremap("<leader>rc", dap.run_to_cursor)

nnoremap("<F11>", dap.step_into)

nnoremap("<F12>", dap.step_out)

nnoremap('<leader>dp', dap.pause)
