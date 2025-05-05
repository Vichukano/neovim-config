-- ╔═══════════════════════════════╗
-- ║       Welcome to Neovim       ║
-- ║  Custom Config by VICHUKANO   ║
-- ╚═══════════════════════════════╝

-- ==VARIABLES==
local cmd = vim.cmd
local opt = vim.opt
local g = vim.g
local indent = 2
local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
local modes = {
    ["n"] =  { "NORMAL" },
    ["no"] = { "NORMAL" },
    ["i"] =  { "INSERT" },
    ["v"] =  { "VISUAL" },
    ["V"] =  { "V-LINE" },
    [""] = { "V-BLOCK" },
    ["c"] =  { "COMMAND" },
    ["R"] =  { "REPLACE" },
    ["s"] =  { "SELECT" },
    ["S"] =  { "S-LINE"  },
    [""] = { "S-BLOCK" },
    ["t"] =  { "TERMINAL" },
}

-- #000000 black 
-- #ffffff white 
local black = { num = 0, hex = "#000000" }
local white = { num = 15, hex = "#ffffff" }
local green = { num = 2, hex = "#008000" }
local aqua = { num = 14, hex = "#00ffff" }
local yellow = { num = 11, hex = "#ffff00" }
local teal = { num = 6, hex = "#008080" }
local gray = { num = 7, hex = "#c0c0c0" }
local colors = {
    ["n"]  = { fg = black, bg = teal },
    ["i"]  = { fg = black, bg = green },
    ["v"]  = { fg = black, bg = yellow },
    ["v"]  = { fg = black, bg = yellow },
    ["V"]  = { fg = black, bg = yellow },
    [""] = { fg = black, bg = yellow },
}

-- ==OPTIONS==
g.mapleader = " "                                                                        -- leader is space

-- FILE EXPLORER OPTIONS
g.netrw_keepdir = 0                                                                      -- update files when directory changed 
g.netrw_liststyle = 3                                                                    -- file tree view 

-- INDENTION
opt.autoindent = true                                                                    -- auto indentation
opt.expandtab = true                                                                     -- convert tabs to spaces
opt.shiftwidth = indent                                                                  -- the number of spaces inserted for each indentation
opt.smartindent = true                                                                   -- make indenting smarter
opt.tabstop = indent                                                                     -- insert 2 spaces for a tab

-- SEARCH
opt.hlsearch = true                                                                      -- highlight all matches on previous search pattern
opt.ignorecase = true                                                                    -- ignore case in search patterns
opt.smartcase = true                                                                     -- smart case search

-- OTHER OPTS
opt.mouse = "a"                                                                          -- allow the mouse to be used in neovim
opt.number = true                                                                        -- set numbered lines
opt.scrolloff = 10                                                                       -- minimal number of screen lines to keep above and below the cursor
opt.splitbelow = true                                                                    -- open new split below
opt.splitright = true                                                                    -- open new split to the right
opt.wrap = false                                                                         -- don't wrap lines 
opt.history = 500                                                                        -- keep history
opt.swapfile = false                                                                     -- don't create swap file
opt.clipboard = "unnamedplus"                                                            -- yy -> system clipboard, now you can Ctrl+V it anywere 
opt.fileencoding = "utf-8"                                                               -- the encoding written to a file
opt.encoding = "utf-8"                                                                   -- the encoding
opt.syntax = "enable"                                                                    -- syntax highlight 
opt.termguicolors = false                                                                -- use only 256 xterm colors 
opt.showmode = false                                                                     -- all modes now in statusline
opt.compatible = false                                                                   -- disable legasy 

-- ==MAPPINGS==
-- SPLIT WINODWS
map("n", "<leader>sv", ":vsplit<CR>", {})
map("n", "<leader>sg", ":split<CR>", {})
-- MOVE AROUND SPLITS
map("n", "<leader>wh", "<C-w>h", {})
map("n", "<leader>wj", "<C-w>j", {})
map("n", "<leader>wk", "<C-w>k", {})
map("n", "<leader>wl", "<C-w>l", {})
-- BETTER ESCAPE
map("i", "jk", "<Esc>", { noremap = true })
map("i", "kj", "<Esc>", { noremap = true })
-- NOHL
map("n", "<leader>h", ":nohlsearch<CR>", { silent = true })
-- BUFFERS
map("n", "<leader>bl", ":ls<CR>", { silent = true })
map("n", "<Tab>", ":bn<CR>", {silent = true, noremap = true})
map("n", "<S-Tab>", ":bp<CR>", {silent = true, noremap = true})
map("n", "<leader>bn", ":bn<CR>", {silent = true, noremap = true})
map("n", "<leader>bp", ":bp<CR>", {silent = true, noremap = true})
map("n", "<leader>bq", ":bd<CR>", {})
-- FILE EXPLORER 
map("n", "<leader>e", ":Ex<CR>", {}) 
-- MARKS
map("n", "<leader>ml", ":marks<CR>", {})
map("n", "<leader>md", ":delm!<CR>", {silent = true})


-- ==STATUSLINE==
function _G.mode()
  local current_mode = vim.api.nvim_get_mode().mode
  return (modes[current_mode][1] or "UNKNOWN" )
end

local function update_color()
  local current_mode = vim.api.nvim_get_mode().mode
  local color = colors[current_mode] or { fg = white, bg = black }
  vim.api.nvim_set_hl(0, "StatusLine", { ctermfg = color.fg.num, ctermbg = color.bg.num })
end

-- STATUSLINE PATTERN
opt.statusline = table.concat({
  " %{v:lua.mode()}",                                                                    -- mode(INSERT, NORMAL, VISUAL, etc.)  
  " %f",                                                                                 -- file name 
  " %m",                                                                                 -- file change flag 
  "%=",                                                                                  -- alignment 
  "%l:%c ",                                                                              -- column and row numbers 
  "[%L] ",                                                                               -- count of lines 
  "(%p%%) ",                                                                             -- current position in % 
  "| %{&fileencoding?&fileencoding:&encoding} |",                                        -- file encoding 
})

-- ==EVENT CALLBACKS==
-- HIGHLIGHT ON YANK
autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = "800"
        })
    end
})

-- EVENT FOR CHANGE STATUS LINE COLOR 
autocmd("ModeChanged", {
  pattern = "*",
  callback = function()
    update_color()
  end,
})

-- ==EXECUTE AFTER START==
update_color()                                                                           -- update status line colors on startup

