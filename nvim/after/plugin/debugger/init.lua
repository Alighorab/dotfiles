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
        { id = "repl", size = 0.25 },
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
  },
})

local function after_session()
  dapui.close()
  dap.repl.close()
end

dap.listeners.after.event_initialized["dapui_config"] = dapui.open
dap.listeners.after.event_terminated["dapui_config"] = after_session
dap.listeners.after.event_exited["dapui_config"] = after_session
dap.listeners.after.disconnect["dapui_config"] = after_session

-- Start
vim.keymap.set("n", "<F9>", function()
  dap.continue()
end, { desc = "Dap Continue" })

-- Exit
vim.keymap.set("n", "<F7>", function()
  dap.terminate(_, _, function()
    dap.repl.close()
    dapui.close()
  end)
end, { desc = "Dap Exit" })

-- Run last
vim.keymap.set("n", "<F21>", function()
  dap.run_last()
end)

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
