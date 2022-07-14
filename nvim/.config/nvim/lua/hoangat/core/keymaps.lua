require "hoangat.core.functions"
local map = function(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts or { silent = true })
  -- vim.api.nvim_set_keymap(mode, lhs, rhs, opts or { noremap = true, silent = true })
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--[[ Reset keymap for leader ]]
map("n", "<leader>", "<Nop>")
map("x", "<leader>", "<Nop>")

--[[ NORMAL ]]

map("n", "q:", "<Nop>")
map("n", "<CR>", '{->v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', { expr = true })
map("n", "x", '"_x')
map("n", "X", '"_X')
map("n", "<C-s>", "<cmd>w<CR>")
-- map("n", "<leader>E", "<CMD>e ~/.config/nvim/init.lua<cr>")
map("n", "<F9>", '<cmd>lua require"core.compiler".compile_and_run()<CR>')

-- Buffer
map("n", "<Tab>", "<cmd>bn<CR>")
map("n", "<S-Tab>", "<cmd>bp<CR>")
map("n", "<space>x", "<cmd>bd<CR>")

-- Window
map("n", "<C-h>", "<Plug>WinMoveLeft")
map("n", "<C-j>", "<Plug>WinMoveDown")
map("n", "<C-k>", "<Plug>WinMoveUp")
map("n", "<C-l>", "<Plug>WinMoveRight")
map("n", "<Up>", "<cmd>wincmd -<CR>")
map("n", "<Down>", "<cmd>wincmd +<CR>")
map("n", "<Left>", "<cmd>wincmd <<CR>")
map("n", "<Right>", "<cmd>wincmd ><CR>")
--map("n","<C-H>", "<cmd>wincmd -<CR>")
--map("n","<C-J>", "<cmd>wincmd +<CR>")
--map("n","<C-K>", "<cmd>wincmd <<CR>")
--map("n","<C-L>", "<cmd>wincmd ><CR>")
map("n", "<space>=", "<cmd>wincmd =<CR>")

-- Copy relative filepath eg: from nvim folder this would look like: "lua/core/keymaps.lua" copied to clipboard
map(
  "n",
  "<leader>cp",
  '<cmd>let @*=fnamemodify(expand("%"), ":~:.") | echo( \'"\' . (fnamemodify(expand("%"), ":~:.")) . \'" copied to clipboard\')<CR>'
)

-- Add new line(below and above) without leaving normal mode
map("n", "<leader>o", ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>')
map("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>')
map("n", "<leader><leader>o", ':<C-u>call append(line("."), "")<CR>:<C-u>call append(line(".")-1, "")<CR>')

-- Move text up and down
map("n", "<A-j>", ":m .+1<CR>==")
map("n", "<A-k>", ":m .-2<CR>==")

--After searching, pressing escape stops the highlight
map("n", "<esc>", ":noh<cr><esc>")

-- Keep search results centred
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")
map("n", "J", "mzJ`z")

--[[ INSERT ]]
map("i", "<C-c>", "<Esc>")
-- map("i", "jk", "<Esc>")
-- map("i", "kj", "<Esc>")
map("i", "<S-CR>", "<Esc>O")
map("i", "<C-CR>", "<Esc>o")

--[[ VISUAL ]]

-- Add new line(below and above) without leaving visual mode

map("x", "<leader>o", "<ESC>o<ESC>gv")
map("x", "<leader>O", "o<ESC>O<ESC>gvo")
map("x", "<leader><leader>o", "<ESC>o<ESC>gvo<ESC>O<ESC>gvo")

-- Indent then select again
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Paste when select behave better
map("v", "p", '"_dP')

-- Bubble text
map("v", "<A-j>", ":m .+1<CR>==")
map("v", "<A-k>", ":m .-2<CR>==")
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Yank and then return Normal mode
map("v", "y", "y<ESC>")
map("x", "y", "y<ESC>")

--[[ Terminal ]]
map("t", "<C-w>h", "<cmd>wincmd h<CR>")
map("t", "<C-w>j", "<cmd>wincmd j<CR>")
map("t", "<C-w>k", "<cmd>wincmd k<CR>")
map("t", "<C-w>l", "<cmd>wincmd l<CR>")
map("t", "<C-w><C-h>", "<cmd>wincmd h<CR>")
map("t", "<C-w><C-j>", "<cmd>wincmd j<CR>")
map("t", "<C-w><C-k>", "<cmd>wincmd k<CR>")
map("t", "<C-w><C-l>", "<cmd>wincmd l<CR>")

--[[ Command ]]
map("c", "<C-a>", "<Home>", { silent = false })
map("c", "<C-e>", "<End>", { silent = false })
map("c", "<C-h>", "<Left>", { silent = false })
map("c", "<C-j>", "<Down>", { silent = false })
map("c", "<C-k>", "<Up>", { silent = false })
map("c", "<C-l>", "<Right>", { silent = false })
map("c", "<C-d>", "<Del>", { silent = false })
map("c", "<C-f>", '<C-R>=expand("%:p")<CR>', { silent = false })

--[[ Git ]]
map("n", "<space>gs", "<cmd>Neogit<CR>")
--[[ Telescope ]]
local is_git_dir = os.execute "git rev-parse --is-inside-work-tree >> /dev/null 2>&1"
if is_git_dir == 0 then
  map("n", "<C-p>", "<cmd>Telescope git_files<CR>")
else
  map("n", "<C-p>", "<cmd>Telescope find_files<CR>")
end

--[[ Git signs ]]
-- map("n", "]g", '&diff ? "]g" : "<cmd>Gitsigns next_hunk<CR>"', { expr = true })
-- map("n", "[g", '&diff ? "[g" : "<cmd>Gitsigns prev_hunk<CR>"', { expr = true })
-- map('n', '', 'Gitsigns blame_line')

--[[ Zen mode ]]
-- map("n", "<space>z", "<cmd>ZenMode<CR>")
--vim.cmd([[command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor]])

-- Syntax Tree Surfer

-- Normal Mode Swapping
vim.api.nvim_set_keymap(
  "n",
  "vd",
  '<cmd>lua require("syntax-tree-surfer").move("n", false)<cr>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "vu",
  '<cmd>lua require("syntax-tree-surfer").move("n", true)<cr>',
  { noremap = true, silent = true }
)
-- .select() will show you what you will be swapping with .move(), you'll get used to .select() and .move() behavior quite soon!
vim.api.nvim_set_keymap(
  "n",
  "vx",
  '<cmd>lua require("syntax-tree-surfer").select()<cr>',
  { noremap = true, silent = true }
)
-- .select_current_node() will select the current node at your cursor
vim.api.nvim_set_keymap(
  "n",
  "vn",
  '<cmd>lua require("syntax-tree-surfer").select_current_node()<cr>',
  { noremap = true, silent = true }
)

-- NAVIGATION: Only change the keymap to your liking. I would not recommend changing anything about the .surf() parameters!
vim.api.nvim_set_keymap(
  "x",
  "J",
  '<cmd>lua require("syntax-tree-surfer").surf("next", "visual")<cr>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "x",
  "K",
  '<cmd>lua require("syntax-tree-surfer").surf("prev", "visual")<cr>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "x",
  "L",
  '<cmd>lua require("syntax-tree-surfer").surf("child", "visual")<cr>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "x",
  "H",
  '<cmd>lua require("syntax-tree-surfer").surf("parent", "visual")<cr>',
  { noremap = true, silent = true }
)

-- SWAPPING WITH VISUAL SELECTION: Only change the keymap to your liking. Don't change the .surf() parameters!
vim.api.nvim_set_keymap(
  "x",
  "<A-J>",
  '<cmd>lua require("syntax-tree-surfer").surf("next", "visual", true)<cr>',
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "x",
  "<A-K>",
  '<cmd>lua require("syntax-tree-surfer").surf("prev", "visual", true)<cr>',
  { noremap = true, silent = true }
)

--[[ VIM EASY ALIGN ]]

map({ "n", "x" }, "ga", "<Plug>(EasyAlign)")
map("n", "\\", "<cmd>Beacon<CR>")

map("n", "<C-c>", "<cmd> :%y+ <CR>") -- copy whole file content
map("n", "<C-s>", "<cmd> :w <CR>") -- ctrl + s to save file
map("n", "<S-t>", "<cmd> :enew <CR>") -- new buffer
-- map("n", "<C-t>b", "<cmd> :tabnew <CR>") -- new tabs

-- move cursor within insert mode

map("i", "<C-e>", "<End>")
map("i", "<C-a>", "<ESC>^i")

-- map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

map("n", "j", 'v:count == 0 ? "gj" : "j"', { expr = true })
map("n", "k", 'v:count == 0 ? "gk" : "k"', { expr = true })
map("n", "^", 'v:count == 0 ? "g^" :  "^"', { expr = true })
map("n", "$", 'v:count == 0 ? "g$" : "$"', { expr = true })

--map("v", "<C-[>", "y'<pgv")
--map("v", "<C-]>", "y'>pgv")
