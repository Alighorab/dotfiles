if vim.g.neovide then
    vim.opt.guifont = "Inconsolata for Powerline:h11"
    vim.g.neovide_transparency = 0.8
    vim.g.transparency = 0.8
    vim.g.neovide_background_color = "'#0f1117'.printf('%x', float2nr(255 * g:transparency))"
end
