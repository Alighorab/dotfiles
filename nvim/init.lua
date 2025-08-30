-- Check if running in VS Code
if vim.g.vscode then
    -- Load VS Code specific configuration
    require("vscode-settings")
else
    -- Load regular Neovim configuration
    require("logan")
end
