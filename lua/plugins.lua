vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  -- Packer сам себя
  use 'wbthomason/packer.nvim'

  -----------------------------------------------------------
  -- ПЛАГИНЫ ВНЕШНЕГО ВИДА
  -----------------------------------------------------------

  -- Цветовая схема
  use 'morhetz/gruvbox'
  use 'doums/darcula'
  --- Информационная строка внизу
  use { 'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup { options = { theme = 'gruvbox' } }
    end, }
  -- Табы вверху
  use { 'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require("bufferline").setup {}
    end, }
  -----------------------------------------------------------
  -- НАВИГАЦИЯ
  -----------------------------------------------------------
  -- Тагбар для навигации по коду
  use 'preservim/tagbar'
  -- Закрывалка буферов
  use 'famiu/bufdelete.nvim'
  -- Файловый менеджер
  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function()
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
      vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_diagnostics = true,
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        default_component_configs = {
          container = {
            enable_character_fade = true
          },
          indent = {
            indent_size = 1,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon"
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added     = "✚", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified  = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted   = "✖", -- this can only be used in the git_status source
              renamed   = "", -- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored   = "",
              unstaged  = "",
              staged    = "",
              conflict  = "",
            }
          },
        },
        window = {
          position = "left",
          width = 45,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["e"] = {
              "toggle_node",
            },
          }
        }
      })
    end
  }
  -- Поисковик
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }
  -- По нажатию jk, jj выход из режима редактирования
  use {
    "max397574/better-escape.nvim",
    config = function() require("better_escape").setup {
        mapping = { "jk", "jj" },
        timout = 50,
      }
    end,
  }
  -- Терминал
  use {
    "akinsho/toggleterm.nvim",
    config = function() require('toggleterm').setup({
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
    "williamboman/nvim-lsp-installer"
  }
  use {
    'nvim-treesitter/nvim-treesitter'
  }
  use 'neovim/nvim-lspconfig'
  -- go to reference в сплывающем окошке
  use {
    'wiliamks/nice-reference.nvim',
    requires = { 'rmagatti/goto-preview', config = function() require('goto-preview').setup {} end }
  }
  -- LSP java
  use 'mfussenegger/nvim-jdtls'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  -- Rust LSP
  use 'simrat39/rust-tools.nvim'
end)
