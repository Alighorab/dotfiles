local M = {}

M.setup = function()
  local dap = require("dap")
  local dap_vscode = require("dap.ext.vscode")

  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = "codelldb",
      args = { "--port", "${port}" },
    },
  }

  dap.configurations.cpp = {
    {
      name = "Debug",
      type = "codelldb",
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
      type = "codelldb",
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
      type = "codelldb",
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
      type = "codelldb",
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
  }

  dap.configurations.c = dap.configurations.cpp

  dap.configurations.rust = {
    {
      type = "codelldb",
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

  dap_vscode.json_decode = require("json5").parse
  dap_vscode.load_launchjs("./.launch.json", { codelldb = { "c", "cpp", "rust" } })
end

return M
