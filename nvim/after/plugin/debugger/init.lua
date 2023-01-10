local dap = require("dap")
local dapui = require("dapui")

vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "", linehl = "", numhl = "" })

dap.defaults.fallback.force_external_terminal = true

dapui.setup({
  layouts = {
    {
      elements = {
        "watches",
        { id = "scopes", size = 0.5 },
        { id = "repl", size = 0.15 },
      },
      size = 79,
      position = "left",
    },
    {
      elements = {
        "console",
      },
      size = 0.25,
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "↻",
      terminate = "□",
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({})
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close({})
  dap.repl.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close({})
  dap.repl.close()
end

-- Mason
require("mason-nvim-dap").setup({
  ensure_installed = {
    "cppdbg",
    "lldb",
    "python",
  },
})

-- Start
vim.keymap.set("n", "<F9>", function()
  dap.continue()
end, { desc = "Dap Continue" })

-- Exit
vim.keymap.set("n", "<F7>", function()
  dap.terminate()
end, { desc = "Dap Exit" })

vim.keymap.set("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Dap Conditional Breakpoint" })

vim.keymap.set("n", "<F8>", function()
  dap.toggle_breakpoint()
end, { desc = "Dap Toggle Breakpoint" })

vim.keymap.set("n", "<F20>", function()
  dap.clear_breakpoints()
end, { desc = "Dap Clear Breakpoints" }) -- SHIFT+F8

vim.keymap.set("n", "<F10>", function()
  dap.step_over()
end, { desc = "Dap Step Over" })

vim.keymap.set("n", "<leader>rc", function()
  dap.run_to_cursor()
end, { desc = "Dap Run to Cursor" })

vim.keymap.set("n", "<F11>", function()
  dap.step_into()
end, { desc = "Dap Step Into" })

vim.keymap.set("n", "<F12>", function()
  dap.step_out()
end, { desc = "Dap Step Out" })

vim.keymap.set("n", "<leader>dp", function()
  dap.pause()
end, { desc = "Dap Pause" })
