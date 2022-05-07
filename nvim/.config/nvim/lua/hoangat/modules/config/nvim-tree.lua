local nvim_tree = safe_require "nvim-tree"
if not nvim_tree then
  return
end

local g = vim.g

g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 0 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_root_folder_modifier = ":~" -- This is the default. See :help filename-modifiers for more options
g.nvim_tree_add_trailing = 1 -- 0 by default, append a trailing slash to folder names
g.nvim_tree_group_empty = 1 --  0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_icon_padding = " " -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
g.nvim_tree_symlink_arrow = " >> " --  defaults to ' ➛ '. used as a separator between symlinks' source and target.
g.nvim_tree_respect_buf_cwd = 1 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.

g.nvim_tree_show_icons = { git = 1, folders = 1, files = 1, folder_arrows = 1 }

g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}
local tree_cb = require("nvim-tree.config").nvim_tree_callback
nvim_tree.setup {
  -- disables netrw completely
  disable_netrw = true,
  -- hijack netrw window on startup
  hijack_netrw = true,
  -- open the tree when running this setup function
  open_on_setup = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup = {},
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab = true,
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor = true,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd = true,
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  -- show lsp diagnostics in the signcolumn
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = { ".git", "node_modules", ".cache" },
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd = nil,
    -- the command arguments as a list
    args = {},
  },

  trash = { cmd = "trash-put", require_confirm = true },

  actions = {
    change_dir = { enable = true, global = false },
    open_file = {
      quit_on_open = false,
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = {
            "notify",
            "packer",
            "qf",
            "diff",
            "fugitive",
            "fugitiveblame",
          },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  renderer = {
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
  },
  view = {
    hide_root_folder = true,
    number = false,
    relativenumber = false,
    width = 25,
    side = "left",
    mappings = {
      custom_only = true,
      list = {
        { key = { "<CR>", "o", "<2-LeftMouse>" }, cb = tree_cb "edit" },
        { key = { "<2-RightMouse>", "<C-]>" }, cb = tree_cb "cd" },
        { key = "<C-v>", cb = tree_cb "vsplit" },
        { key = "<C-x>", cb = tree_cb "split" },
        { key = "<C-t>", cb = tree_cb "tabnew" },
        { key = "<", cb = tree_cb "prev_sibling" },
        { key = ">", cb = tree_cb "next_sibling" },
        { key = "P", cb = tree_cb "parent_node" },
        { key = "<BS>", cb = tree_cb "close_node" },
        { key = "<S-CR>", cb = tree_cb "close_node" },
        { key = "<Tab>", cb = tree_cb "preview" },
        { key = "K", cb = tree_cb "first_sibling" },
        { key = "J", cb = tree_cb "last_sibling" },
        { key = "I", cb = tree_cb "toggle_ignored" },
        { key = "H", cb = tree_cb "toggle_dotfiles" },
        { key = "R", cb = tree_cb "refresh" },
        { key = "a", cb = tree_cb "create" },
        { key = "d", cb = tree_cb "remove" },
        { key = "r", cb = tree_cb "rename" },
        { key = "<C-r>", cb = tree_cb "full_rename" },
        { key = "x", cb = tree_cb "cut" },
        { key = "c", cb = tree_cb "copy" },
        { key = "p", cb = tree_cb "paste" },
        { key = "y", cb = tree_cb "copy_name" },
        { key = "Y", cb = tree_cb "copy_path" },
        { key = "gy", cb = tree_cb "copy_absolute_path" },
        { key = "[c", cb = tree_cb "prev_git_item" },
        { key = "]c", cb = tree_cb "next_git_item" },
        { key = "-", cb = tree_cb "dir_up" },
        { key = "s", cb = tree_cb "system_open" },
        { key = "q", cb = tree_cb "close" },
        { key = "g?", cb = tree_cb "toggle_help" },
      },
    },
  },
}

-- local present, nvimtree = pcall(require, "nvim-tree")
--
-- if not present then
--   return
-- end
--
-- -- globals must be set prior to requiring nvim-tree to function
-- local g = vim.g
--
-- g.nvim_tree_add_trailing = 0 -- append a trailing slash to folder names
-- g.nvim_tree_git_hl = 1
-- g.nvim_tree_highlight_opened_files = 0
--
-- g.nvim_tree_show_icons = {
--   folders = 1,
--   files = 1,
--   git = 1,
--   folder_arrows = 1,
-- }
--
-- g.nvim_tree_icons = {
--   default = "",
--   symlink = "",
--   git = {
--     deleted = "",
--     ignored = "◌",
--     renamed = "➜",
--     staged = "✓",
--     unmerged = "",
--     unstaged = "✗",
--     untracked = "★",
--   },
--   folder = {
--     default = "",
--     empty = "",
--     empty_open = "",
--     open = "",
--     symlink = "",
--     symlink_open = "",
--     arrow_open = "",
--     arrow_closed = "",
--   },
-- }
--
-- local options = {
--   filters = {
--     dotfiles = false,
--     exclude = { "custom" },
--   },
--   disable_netrw = true,
--   hijack_netrw = true,
--   ignore_ft_on_setup = { "dashboard" },
--   open_on_tab = false,
--   hijack_cursor = true,
--   hijack_unnamed_buffer_when_opening = false,
--   update_cwd = true,
--   update_focused_file = {
--     enable = true,
--     update_cwd = false,
--   },
--   view = {
--     side = "left",
--     width = 25,
--     hide_root_folder = true,
--   },
--   git = {
--     enable = false,
--     ignore = true,
--   },
--   actions = {
--     open_file = {
--       resize_window = true,
--     },
--   },
--   renderer = {
--     indent_markers = {
--       enable = false,
--     },
--   },
-- }
--
-- -- check for any override
-- -- options = require("core.utils").load_override(options, "kyazdani42/nvim-tree.lua")
--
-- nvimtree.setup(options)
