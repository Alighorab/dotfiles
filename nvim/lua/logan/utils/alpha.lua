local M = {}

function M.alpha_button(sc, txt)
  -- replace <leader> in shortcut text with LDR for nicer printing
  local sc_ = sc:gsub("%s", ""):gsub("LDR", "<leader>")
  -- if the leader is set, replace the text with the actual leader key for nicer printing
  if vim.g.mapleader then
    sc = sc:gsub("LDR", vim.g.mapleader == " " and "SPC" or vim.g.mapleader)
  end
  -- return the button entity to display the correct text and send the correct keybinding on press
  return {
    type = "button",
    val = txt,
    on_press = function()
      local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
      vim.api.nvim_feedkeys(key, "normal", false)
    end,
    opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 36,
      align_shortcut = "right",
      hl = "DashboardCenter",
      hl_shortcut = "DashboardShortcut",
    },
  }
end

return M
