local dap = require("dap")

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "/usr/bin/OpenDebugAD",
}

dap.configurations.cpp = {
	{
		type = "cppdbg",
		request = "launch",
		program = function ()
		    if Exec == nil or Exec == '' then
		        return vim.fn.getcwd() .. "/debug"
            else
                return vim.fn.getcwd() .. '/' .. Exec
            end
		end,
        args = function ()
            local next = next
            if next(Args) == nil then
                return {}
            else
                return Args
            end
        end,
		cwd = "${workspaceFolder}",
		stopOnEntry = true,
		MIMode = "gdb",
		miDebuggerPath = "/usr/bin/gdb",
		setupCommands = {
			{
				text = "-enable-pretty-printing",
				description = "enable pretty printing",
				ignoreFailures = false,
			},
		},
	},
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
