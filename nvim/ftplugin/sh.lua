vim.keymap.set("n", "<leader>x", function()
    vim.cmd("!chmod +x %")
end, {
    desc = "Make the script e[x]ecutable"
})
