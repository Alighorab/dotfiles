vim.keymap.set("n", "<leader>gh", vim.cmd.ClangdSwitchSourceHeader, {
  silent = true,
  buffer = true,
  desc = "Clang Switch Source Header",
})

local make = function()
  local uv = vim.loop
  local stdout = uv.new_pipe()
  local stderr = uv.new_pipe()

  uv.spawn("make", {
    stdio = { stdout, stderr },
  })

  uv.read_start(stdout, function(err, data)
    assert(not err, err)
    if data then
      print(data)
    end
  end)

  uv.read_start(stderr, function(err, data)
    assert(not err, err)
    if data then
      print(data)
    end
  end)
end

local compile = function()
  local uv = vim.loop
  local cmd = "clang"
  local args = {
    "-Wall",
    "-g",
    vim.fn.expand("%:t"),
    "-o",
    vim.fn.expand("%:t:r"),
  }
  print(cmd, table.concat(args, " "))
  uv.spawn(cmd, {
    args = args,
  })
end
