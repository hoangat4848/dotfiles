local o = vim.opt
-- Appearance
o.cmdheight = 1
o.pumheight = 10
--o.colorcolumn = "80"
o.cursorline = true
o.laststatus = 1 -- One single statusbar for all windows (3)
-- o.foldmethod = 'marker'
o.number = true
o.relativenumber = true
o.numberwidth = 4
o.ruler = false -- My statusline take care of that
o.showmode = false
o.showtabline = 2
o.signcolumn = "yes"
o.termguicolors = true
o.wrap = false

-- Backups
o.backup = false
o.writebackup = false
o.swapfile = false
o.undofile = true -- enable persistent undo
-- o.autoread = true -- Automatically read a file when it has been changed from outside vim

-- Completion
o.completeopt = "menuone,noselect"
o.pumblend = 10 -- Popup menu transparency
o.pumheight = 8 -- Popup menu height

-- General
o.conceallevel = 0 -- so that `` is visible in markdown files
o.clipboard = "unnamedplus"
o.fileencoding = "utf-8"
o.hidden = true
o.joinspaces = false
o.mouse = "a"
o.scrolloff = 8
o.sidescrolloff = 8
o.splitbelow = true
o.splitright = true
o.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
o.updatetime = 300 -- faster completion (4000ms default)
o.virtualedit = "block" -- Make visual block can select a rectangle block
o.iskeyword = o.iskeyword + "-"
--o.whichwrap = "b,s,<,>,[,],h,l"

-- -- Listchars
-- vim.opt.list = true
-- vim.opt.listchars:append 'eol:↴'
-- vim.opt.listchars:append 'space:⋅'

-- Performance
o.lazyredraw = true

-- Search
o.inccommand = "nosplit" -- show substitutions incrementally
o.ignorecase = true
o.smartcase = true
o.wildignore = { ".git/*", "node_modules/*" }
o.wildignorecase = true

-- Tabs
o.expandtab = true -- convert tabs to spaces
o.shiftwidth = 2 -- the number of spaces inserted for
o.softtabstop = 2 -- insert N spaces for a tab
o.tabstop = 2 -- insert N spaces for a tab
o.smartindent = true -- make indenting smarter again
o.smarttab = true
-- Shortmess
o.shortmess = o.shortmess
  + {
    A = true, -- don't give the "ATTENTION" message when an existing swap file is found.
    I = true, -- don't give the intro message when starting Vim |:intro|.
    W = true, -- don't give "written" or "[w]" when writing a file
    c = true, -- don't give |ins-completion-menu| messages
    m = true, -- use "[+]" instead of "[Modified]"
  }

-- Format options
o.formatoptions = o.formatoptions
  + {
    c = false,
    o = false, -- O and o, don't continue comments
    r = true, -- Pressing Enter will continue comments
  }

-- Remove builtin plugins
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_zip = 1

o.foldlevel = 99
o.foldmethod = "syntax"
-- foldmethod = "expr",
o.foldexpr = "nvim_treesitter#foldexpr()"
