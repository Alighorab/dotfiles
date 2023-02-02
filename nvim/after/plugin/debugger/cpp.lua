local dap = require("dap")

dap.adapters.lldb = {
  id = "vscode-lldb",
  type = "executable",
  command = "lldb-vscode"
}

dap.configurations.cpp = {
  {
    name = "Debug",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
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
  {
    name = "Debug (with args)",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    args = function()
      local argv = {}
      local arg = vim.fn.input(string.format("Arguments: "))
      for a in string.gmatch(arg, "%S+") do
        table.insert(argv, a)
      end
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
  {
    name = "Debug (file)",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.expand("%:t:r")
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
  {
    name = "Debug (file with args)",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.expand("%:t:r")
    end,
    args = function()
      local argv = {}
      local arg = vim.fn.input(string.format("Arguments: "))
      for a in string.gmatch(arg, "%S+") do
        table.insert(argv, a)
      end
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
  {
    name = "Payment Application",
    type = "lldb",
    request = "launch",
    cwd = "${workspaceFolder}",
    program = "build/PaymentApp",
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
  {
    name = "Payment Application Test",
    type = "lldb",
    request = "launch",
    cwd = "${workspaceFolder}",
    program = "build/${fileBasenameNoExtension}",
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
    type = "lldb",
    request = "launch",
    program = function()
      os.execute("cargo build &> /dev/null")
      return "target/debug/${workspaceFolderBasename}"
    end,
    args = function()
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
