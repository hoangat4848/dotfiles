-- vim.cmd([[
--     augroup ftplugin
--       au!
--       au BufWinEnter * set formatoptions-=cro " Stop comment in new line.
--       au BufNewFile,BufRead *.json setl filetype=jsonc " To allow comments on json files.
--       au FileType man setl laststatus=0 noruler " Not showing statusbar on man files.
--       au FileType markdown setl wrap linebreak conceallevel=2
--       au FileType vim,html,css,json,javascript,javascriptreact,typescript,typescriptreact,lua,sh,zsh setl sw=2
--       au TermOpen term://* setl nornu nonu nocul so=0 scl=no
--     augroup END
--     augroup highlight_yank
--       au!
--       au TextYankPost * silent! lua vim.highlight.on_yank { timeout = 150 }
--     augroup packer_user_config
--       autocmd!
--       autocmd BufWritePost plugins.lua source <afile> | PackerSync
--     augroup end
-- ]])

local new_autocmd = vim.api.nvim_create_autocmd
local new_augroup = vim.api.nvim_create_augroup

--[[ Filetypes ]]

local ft_group = new_augroup("ftconfig", { clear = true })

-- Stop comment in new line
new_autocmd("BufWinEnter", {
  pattern = "*",
  command = "set formatoptions-=cro",
  group = ft_group,
})

-- To allow comments on json
new_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.json",
  command = "setl filetype=jsonc",
  group = ft_group,
})

new_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.ejs",
  command = "setl filetype=html",
  group = ft_group,
})

-- Not showing statusbar on man files
new_autocmd("FileType", {
  pattern = "man",
  command = "setl laststatus=0 noruler",
  group = ft_group,
})

new_autocmd("FileType", {
  pattern = "markdown",
  command = "setl wrap linebreak conceallevel=2",
  group = ft_group,
})

-- set shiftwidth
new_autocmd("FileType", {
  pattern = {
    "vim",
    "html",
    "css",
    "json",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "lua",
    "sh",
    "zsh",
  },
  command = "setl sw=2",
  group = ft_group,
})

-- config terminal
-- new_autocmd("TermOpen", {
-- 	command = "term://* setl nornu nonu nocul so=0 scl=no",
-- 	group = ft_group,
-- })

-- Windows to close with "q".
new_autocmd("FileType", {
  pattern = { "help", "startuptime", "qf", "lspinfo" },
  command = [[
    nnoremap <buffer><silent> q :close<CR>
    set nobuflisted
  ]],
  group = ft_group,
})

new_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]], group = ft_group })

-- Go to last location when opening a buffer
new_autocmd(
  "BufReadPost",
  { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
)

--- Remove all trailing whitespace on save
local trim_group = new_augroup("TrimWhiteSpaceGrp", { clear = true })
new_autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = trim_group,
})

-- Highlight on yanking
local yank_highlight_group = new_augroup("YankHighlight", { clear = true })
new_autocmd("TextYankPost", {
  command = "silent! lua vim.highlight.on_yank()",
  group = yank_highlight_group,
})

-- Show cursor line only in active window.
local cursor_focus_group = new_augroup("CursorLineFocus", { clear = true })
new_autocmd({ "InsertLeave", "WinEnter" }, {
  pattern = "*",
  command = "set cursorline",
  group = cursor_focus_group,
})

new_autocmd({ "InsertEnter", "WinLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "NvimTree" then
      return
    end

    vim.cmd "set nocursorline"
  end,
  group = cursor_focus_group,
})

-- Auto PackerSync when save plugins.lua file
local packer_config_group = new_augroup("PackerAutoSync", { clear = true })
new_autocmd("BufWritePost", {
  pattern = "plugins.lua",
  command = "source <afile> | PackerSync",
  group = packer_config_group,
})

-- Close nvim if NvimTree is only running buffer
new_autocmd("BufEnter", { command = [[if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]] })

-- vim.cmd [[
-- augroup cmdline
--     autocmd!
--     autocmd CmdlineLeave : lua vim.defer_fn(function() vim.cmd('echo ""') end, 5000)
-- augroup END
-- ]]

local parsers = require "nvim-treesitter.parsers"
local configs = parsers.get_parser_configs()
local ft_str = table.concat(
  vim.tbl_map(function(ft)
    return configs[ft].filetype or ft
  end, parsers.available_parsers()),
  ","
)

vim.cmd("autocmd Filetype " .. ft_str .. " setlocal foldmethod=expr foldexpr=nvim_treesitter#foldexpr()")
vim.cmd "autocmd ColorScheme * highlight WhichKeyFloat ctermbg=NONE ctermfg=NONE"
-- vim.cmd "autocmd ColorScheme * lua require'lightspeed'.init_highlight(true)"

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinEnter", "BufFilePost", "InsertEnter", "BufWritePost" }, {
  callback = function()
    require("hoangat.modules.config.winbar").get_winbar()
  end,
})

local autocmd = vim.api.nvim_create_autocmd
-- Disable statusline in dashboard
autocmd("FileType", {
  pattern = "alpha",
  callback = function()
    vim.opt.laststatus = 0
    vim.opt.showtabline = 0
  end,
})

autocmd("BufUnload", {
  buffer = 0,
  callback = function()
    vim.opt.laststatus = 3
    vim.opt.showtabline = 0
  end,
})

vim.opt.statusline = "%!v:lua.require'ui.statusline'.run()"
