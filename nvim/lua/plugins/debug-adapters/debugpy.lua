local M = {}

M.setup = function()
  local dap_vscode = require("dap.ext.vscode")
  require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

  table.insert(require("dap").configurations.python, {
    type = "python",
    request = "launch",
    name = "My custom launch configuration",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    args = function()
      local argv = {}
      local arg = vim.fn.input(string.format("Arguments: "))
      for a in string.gmatch(arg, "%S+") do
        table.insert(argv, a)
      end
      return argv
    end,
    justMyCode = false,
  })

  dap_vscode.load_launchjs("./.vscode/launch.json", { "python" })

  vim.api.nvim_create_user_command("DebugpyReloadLaunchJson", function()
    dap_vscode.load_launchjs("./.vscode/launch.json", { "python" })
  end, {
    complete = "file",
    nargs = "*",
  })
end

return M
