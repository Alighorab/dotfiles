local M = {}

M.setup = function()
  require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

  table.insert(require("dap").configurations.python, {
    type = "python",
    request = "launch",
    name = "My custom launch configuration",
    program = "${file}",
    args = function()
      local argv = {}
      local arg = vim.fn.input(string.format("Arguments: "))
      for a in string.gmatch(arg, "%S+") do
        table.insert(argv, a)
      end
      return argv
    end,
  })
end

return M
