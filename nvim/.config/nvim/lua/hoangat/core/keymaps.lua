local map = function(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts or { noremap = true, silent = true })
end

vim.g.mapleader = " "
vim.g.maplocalleader = " "

--[[ Reset keymap for leader ]]
map("n", "<leader>", "<Nop>")
map("x", "<leader>", "<Nop>")

--[[ NORMAL ]]

map("n", "q:", "<Nop>")
map("n", "<C-c>", "<Esc>")
map("n", "<CR>", '{->v:hlsearch ? ":nohl\\<CR>" : "\\<CR>"}()', { expr = true })
map("n", "x", '"_x')
map("n", "X", '"_X')
map("n", "<C-s>", "<cmd>w<CR>")
map("n", "<leader>q", "<CMD>q<cr>")
-- map("n", "<leader>w", "<CMD>w<cr>")
map("n", "<leader>E", "<CMD>e ~/.config/nvim/init.lua<cr>")
map("n", "<F9>", '<cmd>lua require"core.compiler".compile_and_run()<CR>')

-- Buffer
map("n", "<Tab>", "<cmd>bn<CR>")
map("n", "<S-Tab>", "<cmd>bp<CR>")
map("n", "<space>x", "<cmd>bd<CR>")

-- Window
map("n", "<C-h>", "<cmd>wincmd h<CR>")
map("n", "<C-j>", "<cmd>wincmd j<CR>")
map("n", "<C-k>", "<cmd>wincmd k<CR>")
map("n", "<C-l>", "<cmd>wincmd l<CR>")
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
  "<leader>fp",
  '<cmd>let @*=fnamemodify(expand("%"), ":~:.") | echo( \'"\' . (fnamemodify(expand("%"), ":~:.")) . \'" copied to clipboard\')<CR>'
)

-- Add new line(below and above) without leaving normal mode
map("n", "<leader>o", ':<C-u>call append(line("."),   repeat([""], v:count1))<CR>')
map("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>')

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
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")
map("i", "<S-CR>", "<Esc>O")
map("i", "<C-CR>", "<Esc>o")

--[[ VISUAL ]]
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

-- Yank and then move cursor back
map("v", "y", "ygv<Esc>")

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
  map("n", "<C-p>", '<cmd>lua require"telescope.builtin".git_files()<CR>')
else
  map("n", "<C-p>", '<cmd>lua require"telescope.builtin".find_files()<CR>')
end

-- map("n", "<space>fb", "<cmd>Telescope buffers theme=get_dropdown<CR>")
-- map("n", "<space>fh", '<cmd>lua require"telescope.builtin".help_tags()<CR>')
-- map("n", "<space>fo", '<cmd>lua require"telescope.builtin".oldfiles()<CR>')
-- map("n", "<space>fw", '<cmd>lua require"telescope.builtin".live_grep()<CR>')
--map("n", "<space>fd", '<cmd>lua require"telescope.builtin".git_files({cwd = "$HOME/.dotfiles" })<CR>')

--[[ Tree ]]
-- map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>")

-- Vim surround ( noremap need to be false to work)
-- map("n", "ds", "<Plug>Dsurround", { noremap = false })
-- map("n", "cs", "<Plug>Csurround", { noremap = false })
-- map("n", "cS", "<Plug>CSurround", { noremap = false })
-- map("n", "ys", "<Plug>Ysurround", { noremap = false })
-- map("n", "yS", "<Plug>YSurround", { noremap = false })
-- map("n", "ss", "<Plug>Yssurround", { noremap = false })
-- map("n", "SS", "<Plug>YSsurround", { noremap = false })
-- map("x", "vs", "<Plug>VSurround", { noremap = false })
-- map("x", "vS", "<Plug>VgSurround", { noremap = false })

--[[ Git signs ]]
-- map("n", "]g", '&diff ? "]g" : "<cmd>Gitsigns next_hunk<CR>"', { expr = true })
-- map("n", "[g", '&diff ? "[g" : "<cmd>Gitsigns prev_hunk<CR>"', { expr = true })
-- map('n', '', 'Gitsigns blame_line')

--[[ Zen mode ]]
-- map("n", "<space>z", "<cmd>ZenMode<CR>")
--vim.cmd([[command! WipeReg for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor]])
