require("nvim-lsp-installer").setup {}
require 'nvim-treesitter.configs'.setup {
    ensure_installed = { 'java', 'rust' },
      highlight = {
        enable = true
    }
}
local nvim_lsp = require'lspconfig'
local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
           	parameter_hints_prefix = "<- ",
      			other_hints_prefix = "=> ",
        },
    },
    server = {
        settings = {
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}
require('rust-tools').setup(opts)
require'lspconfig'.lemminx.setup{}
require'lspconfig'.sumneko_lua.setup{}

