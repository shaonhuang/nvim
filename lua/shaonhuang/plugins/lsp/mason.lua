return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    -- import modules
    local mason                = require("mason")
    local mason_lspconfig      = require("mason-lspconfig")
    local mason_tool_installer = require("mason-tool-installer")

    -- enable mason and customize UI icons
    mason.setup({
      ui = {
        icons = {
          package_installed   = "✓",
          package_pending     = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- configured LSP servers in lspconfig.lua, and unable automatic setup
    mason_lspconfig.setup({
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "svelte",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
      },
      automatic_enable = false, -- not invoke vim.lsp.enable()
    })

    -- configured commonly used formatters and linters
    mason_tool_installer.setup({
      ensure_installed = {
        "prettier", -- JS/TS fomatter
        "stylua",   -- Lua formatter
        "isort",    -- Python import sorter
        "black",    -- Python formatter
        "pylint",   -- Python lint
        "eslint_d", -- JS/TS lint
      },
      -- if you want these tools to be able to use after installation, you could add
      -- automatic_installation = true,
    })
  end,
}

