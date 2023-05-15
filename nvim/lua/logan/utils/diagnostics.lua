local M = {}

M.float_opts = {
  border = "none",
  scope = "line",
  source = "always",
  severity_sort = true,
  focus = false,
  close_events = {
    "CursorMoved",
    "InsertEnter",
    "DiagnosticChanged",
  },
  prefix = function(diagnostic)
    local signs = {
      [vim.diagnostic.severity.ERROR] = function()
        return "Error: "
      end,
      [vim.diagnostic.severity.WARN] = function()
        return "Warning: "
      end,
      [vim.diagnostic.severity.HINT] = function()
        return "Hint: "
      end,
      [vim.diagnostic.severity.INFO] = function()
        return "Info: "
      end,
    }
    local colors = {
      [vim.diagnostic.severity.ERROR] = function()
        return "DiagnosticFloatingError"
      end,
      [vim.diagnostic.severity.WARN] = function()
        return "DiagnosticFloatingWarn"
      end,
      [vim.diagnostic.severity.HINT] = function()
        return "DiagnosticFloatingHint"
      end,
      [vim.diagnostic.severity.INFO] = function()
        return "DiagnosticFloatingInfo"
      end,
    }
    return signs[diagnostic.severity](), colors[diagnostic.severity]()
  end,
  format = function(diagnostic)
    local WIN_WIDTH = vim.fn.winwidth(0)
    local max_width = math.floor(WIN_WIDTH * 0.7)
    local wrap_msg = require("logan.utils.wrap").wrap_text(diagnostic.message, max_width)
    local msg = table.concat(wrap_msg, "\n")
    return msg
  end,
}

M.setup = function()
  -- diagnostics
  vim.diagnostic.config({
    virtual_text = true,
    float = M.float_opts,
  })
  -- signs
  local signs = { Error = "E", Warn = "W", Hint = "H", Info = "I" }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

return M
