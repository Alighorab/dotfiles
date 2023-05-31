local M = {}

M.setup = function()
  local dap = require("dap")
  local dap_vscode = require("dap.ext.vscode")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")

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
        return coroutine.create(function(coro)
          local opts = {}
          pickers
              .new(opts, {
                prompt_title = "Path to executable",
                finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
                sorter = conf.generic_sorter(opts),
                attach_mappings = function(buffer_number)
                  actions.select_default:replace(function()
                    actions.close(buffer_number)
                    coroutine.resume(coro, action_state.get_selected_entry()[1])
                  end)
                  return true
                end,
              })
              :find()
        end)
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
        return coroutine.create(function(coro)
          local opts = {}
          pickers
              .new(opts, {
                prompt_title = "Path to executable",
                finder = finders.new_oneshot_job({ "fd", "--hidden", "--no-ignore", "--type", "x" }, {}),
                sorter = conf.generic_sorter(opts),
                attach_mappings = function(buffer_number)
                  actions.select_default:replace(function()
                    actions.close(buffer_number)
                    coroutine.resume(coro, action_state.get_selected_entry()[1])
                  end)
                  return true
                end,
              })
              :find()
        end)
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
