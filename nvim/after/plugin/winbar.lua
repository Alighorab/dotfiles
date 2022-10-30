local function winbar()
    local icon, color = require("nvim-web-devicons").get_icon(vim.fn.expand('%:t'), vim.bo.filetype, {})
    if icon and color then
        vim.opt_local.winbar = '┃ %#' .. color .. '#' .. icon .. '%* ' .. "%f %m"
    else
        vim.opt_local.winbar = "┃ %f %m"
    end
end

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    group = vim.api.nvim_create_augroup("WinBarGroup", {}),
    callback = winbar
})
