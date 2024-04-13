if vim.g.vscode then
    -- VSCode extension
else
    -- ordinary Neovim
    require("shaonhuang.core")
    require("shaonhuang.lazy")
end