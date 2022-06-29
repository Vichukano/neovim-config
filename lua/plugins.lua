vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
    -- Packer сам себя
    use 'wbthomason/packer.nvim'

    -----------------------------------------------------------
    -- ПЛАГИНЫ ВНЕШНЕГО ВИДА
    -----------------------------------------------------------

    -- Цветовая схема
    use 'morhetz/gruvbox'
    --- Информационная строка внизу
    use { 'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function() 
               require('lualine').setup{ options = { theme = 'gruvbox' } }
             end, }
    -- Табы вверху
    use {'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons',
    config = function()
        require("bufferline").setup{}
    end, }
    -----------------------------------------------------------
    -- НАВИГАЦИЯ
    -----------------------------------------------------------
    -- Тагбар для навигации по коду
    use 'preservim/tagbar'
    -- Файловый менеджер
    use {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v2.x",
      requires = { 
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
      config = function ()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      vim.fn.sign_define("DiagnosticSignError", {text = " ", texthl = "DiagnosticSignError"})
      vim.fn.sign_define("DiagnosticSignWarn", {text = " ", texthl = "DiagnosticSignWarn"})
      vim.fn.sign_define("DiagnosticSignInfo", {text = " ", texthl = "DiagnosticSignInfo"})
      vim.fn.sign_define("DiagnosticSignHint", {text = "", texthl = "DiagnosticSignHint"})
      require("neo-tree").setup({
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_diagnostics = true,
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
      })
      end
    }
    -- Поисковик
    use {'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/plenary.nvim'}}}
    -- По нажатию jk, jj выход из режима редактирования
    use {
        "max397574/better-escape.nvim",
        config = function() require("better_escape").setup {
	      mapping = {"jk", "jj"},
	      timout = 50, }
        end,
        }
    -- Терминал
    use {
        "akinsho/toggleterm.nvim",
        config = function() require('toggleterm').setup ({
                   size = 10,
                   open_mapping = [[<c-\>]],
                   hide_numbers = true,
                   shade_filetypes = {},
                   shade_terminals = true,
                   shading_factor = 2,
                   start_in_insert = true,
                   insert_mappings = true,
                   persist_size = true,
                   direction = "float",
                   close_on_exit = true,
                   shell = vim.o.shell,
                   float_opts = {
                     border = "curved",
                     winblend = 0,
                     highlights = {
                       border = "Normal",
                       background = "Normal",
                     },
                   },
                 })
                 end
        }
    -- РАЗНОЕ
    -----------------------------------------------------------
    -- Стартовая страница, если просто набрать vim в консоле
    use 'mhinz/vim-startify'
    -- LSP, подсветка синтаксиса, автодополнение, навигация
    use {
      'nvim-treesitter/nvim-treesitter',
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {'java'},
        highlight = {
          enable = true
        }
      }
    }
    use 'neovim/nvim-lspconfig'
    -- LSP java
    use 'mfussenegger/nvim-jdtls'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
end)
