local dap = require("dap")

dap.adapters.cppdbg = {
	id = "cppdbg",
	type = "executable",
	command = "/usr/bin/OpenDebugAD",
}

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "/usr/bin/codelldb",
		args = { "--port", "${port}" },
	},
}

dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode',
  name = 'lldb'
}

dap.configurations.cpp = {
	{
		type = "codelldb",
		request = "launch",
		program = function ()
            -- Compile and return exec name
            local filetype = vim.bo.filetype
            local filename = vim.fn.expand("%")
            local basename = vim.fn.expand('%:t:r')
            local handle = io.popen("(ls | grep -i makefile)")
            local makefile
            if handle then
                makefile = handle:read("*a")
            else
                return 1
            end
            if makefile ~= "" then
                os.execute("make")
            else
                if filetype == "c" then
                    os.execute(string.format("gcc -g -o %s %s", basename, filename))
                else
                    os.execute(string.format("g++ -g -o %s %s", basename, filename))
                end
            end
            handle:close()
            return basename
		end,
		args = function ()
            local argv = {}
            local arg = vim.fn.input(string.format("argv: "))
            for a in string.gmatch(arg, "%S+") do
                table.insert(argv, a)
            end
            vim.cmd('echo ""')
            return argv
		end,
		cwd = "${workspaceFolder}",
		-- stopAtEntry = true,
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

dap.configurations.rust = {
	{
		type = "codelldb",
		request = "launch",
		program = function ()
            os.execute("cargo build &> /dev/null")
            return "target/debug/${workspaceFolderBasename}"
		end,
		args = function ()
            local argv = {}
            local arg = vim.fn.input(string.format("argv: "))
            for a in string.gmatch(arg, "%S+") do
                table.insert(argv, a)
            end
            vim.cmd('echo ""')
            return argv
		end,
		cwd = "${workspaceFolder}",
		-- stopOnEntry = true,
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
