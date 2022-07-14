--[[ Plugins manager ]]

local function get_config(plugin_name)
  return string.format('require("hoangat.modules.config.%s")', plugin_name)
end

-- Automatically install packer
local fn = vim.fn
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

local packer = safe_require "packer"
if packer then
  packer.init {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  return packer.startup(function(use)
    use "wbthomason/packer.nvim" -- Packer manage itself
    use {
      "lewis6991/impatient.nvim", -- Performance
      config = get_config "impatient",
    }

    use {
      "goolord/alpha-nvim",
      after = "base46",
      config = get_config "alpha",
    }

    use { -- Treesiter
      "nvim-treesitter/nvim-treesitter",
      config = get_config "treesitter",
      run = ":TSUpdate",
      requires = {
        "p00f/nvim-ts-rainbow",
        "windwp/nvim-ts-autotag",
        "JoosepAlviste/nvim-ts-context-commentstring",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/nvim-treesitter-refactor",
        -- { "mfussenegger/nvim-treehopper", config = get_config "nvim-treehopper" },
        { "hoangat4848/nvim-treehopper", config = get_config "nvim-treehopper" },
        "andymass/vim-matchup",
      },
    }

    use "ziontee113/syntax-tree-surfer" -- Moving between treesitter nodes

    use { -- Show current context
      "romgrk/nvim-treesitter-context",
      config = get_config "treesitter-context",
    }

    use { -- Show current scope in statusbar
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      config = get_config "nvim-gps",
    }

    use { -- Virtual text for current context
      "haringsrob/nvim_context_vt",
      after = "base46",
      config = get_config "nvim-context-vt",
    }

    -- ──────────────────────────────────────────────────────────────────────

    use { -- Lsp
      "neovim/nvim-lspconfig",
      config = get_config "lsp",
      requires = {
        "williamboman/nvim-lsp-installer",
        "jose-elias-alvarez/null-ls.nvim", -- Formatter
        "b0o/schemastore.nvim", -- JSON schema for jsonls
        "ray-x/lsp_signature.nvim",
        "RRethy/vim-illuminate",
        "simrat39/symbols-outline.nvim",
        "jose-elias-alvarez/nvim-lsp-ts-utils",
        "nvim-lua/lsp-status.nvim",
        { "folke/trouble.nvim", config = get_config "lsp.trouble" }, -- A pretty list for showing diagnostics, references..
        {
          "tami5/lspsaga.nvim",
          config = function()
            require "lspsaga"
          end,
        },
      },
    }

    use {
      "rmagatti/goto-preview",
      config = function()
        require("goto-preview").setup {}

        vim.keymap.set("n", "gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
        vim.keymap.set("n", "gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
        vim.keymap.set("n", "gP", "<cmd>lua require('goto-preview').close_all_win()<CR>")
        -- Only set if you have telescopeplugins
        vim.keymap.set("n", "gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>")
      end,
    }

    use { -- Autocompletion plugin
      "hrsh7th/nvim-cmp",
      config = get_config "nvim-cmp",
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "onsails/lspkind-nvim", -- Enables icons on completions
        { -- Snippets
          "L3MON4D3/LuaSnip",
          config = get_config "luasnip",
          requires = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
          },
        },
      },
    }

    use { "nvim-lua/plenary.nvim" }

    use { -- Telescope
      "nvim-telescope/telescope.nvim",
      cmd = "Telescope",
      config = get_config "telescope",
      requires = {
        -- "nvim-lua/plenary.nvim",
        "jvgrootveld/telescope-zoxide",
        { "ahmedkhalf/project.nvim", config = get_config "project" },
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-node-modules.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
      },
    }

    -- use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    use {
      "ThePrimeagen/harpoon",
      config = get_config "harpoon",
    }

    -- ============================================================================

    --[[ Git related ]]

    use { -- Git signs
      "lewis6991/gitsigns.nvim",
      config = get_config "gitsigns",
      requires = { "nvim-lua/plenary.nvim" },
    }

    use { -- requirement for Neogit
      "sindrets/diffview.nvim",
      cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
      },
      config = get_config "diffview",
    }

    use {
      "TimUntersberger/neogit",
      requires = { "nvim-lua/plenary.nvim" },
      cmd = "Neogit",
      config = get_config "neogit",
    }

    use { "tpope/vim-fugitive" }

    use {
      "akinsho/git-conflict.nvim",
      config = function()
        require("git-conflict").setup()
      end,
    }

    --[[ Appearance ]]
    -- Colorscheme───────────────────────────────────────────────────────────
    -- use { "ishan9299/nvim-solarized-lua", config = get_config "colorscheme" }

    use {
      "NvChad/base46",
      -- commit = "6689ebc11e658f5094fe40f12d492e8f568a166f",
      commit = "674d6bb3c41ec3c0068e7d94b21596133b15998f",
      after = "plenary.nvim",
      config = function()
        local ok, base46 = pcall(require, "base46")

        if ok then
          base46.load_theme()
        else
          print(base46)
        end
      end,
    }

    -- use { "sainnhe/gruvbox-material", config = get_config "colorscheme" }
    -- use {
    --   "RRethy/nvim-base16",
    --   config = function()
    --     vim.cmd "colorscheme base16-solarized-dark"
    --   end,
    -- }
    -- use { "sainnhe/everforest", config = get_config "colorscheme" }
    --
    -- use {
    --   "andersevenrud/nordic.nvim",
    --   config = get_config "colorscheme",
    -- }
    --
    -- use { "projekt0n/github-nvim-theme", config = get_config "colorscheme" }
    --
    -- use { "lourenci/github-colors", config = get_config "colorscheme" }
    --
    -- use { "lunarvim/darkplus.nvim", config = get_config "colorscheme" }
    --
    -- use { "rose-pine/neovim", config = get_config "colorscheme" }
    --
    -- use { "rebelot/kanagawa.nvim", config = get_config "colorscheme" }
    --
    -- use {
    --   "catppuccin/nvim",
    --   as = "catppuccin",
    --   config = get_config "colorscheme",
    -- }
    --
    -- use {
    --   "EdenEast/nightfox.nvim",
    --   config = get_config "colorscheme",
    -- }
    --
    -- use {
    --   "tiagovla/tokyodark.nvim",
    --   config = get_config "colorscheme",
    -- }
    --
    -- use {
    --   "folke/tokyonight.nvim",
    --   config = get_config "colorscheme",
    -- }

    -- use {
    --   "kdheepak/monochrome.nvim",
    --   config = function()
    --     vim.cmd "colorscheme monochrome"
    --   end,
    -- }
    use {
      "xiyaowong/nvim-transparent",
      config = function()
        require("transparent").setup {
          enable = false, -- boolean: enable transparent
          extra_groups = { -- table/string: additional groups that should be cleared
            -- In particular, when you set it to 'all', that means all available groups

            -- example of akinsho/nvim-bufferline.lua
            "FloatBorder",
            "WinSeparator",
            "TelescopeBorder",
            "BufferLineTabClose",
            "BufferlineBufferSelected",
            "BufferLineFill",
            "BufferLineBackground",
            "BufferLineSeparator",
            "BufferLineIndicatorSelected",
            "Twilight",
          },
          exclude = {}, -- table: groups you don't want to clear
        }
      end,
    }

    -- ──────────────────────────────────────────────────────────────────────

    --Which key
    use { "folke/which-key.nvim", config = get_config "which-key" }

    use { -- Nvim Tree
      "kyazdani42/nvim-tree.lua",
      config = get_config "nvim-tree",
      after = "nvim-web-devicons",
    }

    use {
      "matbme/JABS.nvim",
      config = get_config "jabs",
      requires = { "kyazdani42/nvim-web-devicons" },
    }

    use { -- Colorizer
      "norcalli/nvim-colorizer.lua",
      config = get_config "nvim-colorizer",
    }

    use { "Pocco81/HighStr.nvim", config = get_config "HightStr" }

    use { -- Indent guides
      "lukas-reineke/indent-blankline.nvim",
      config = get_config "indent-blankline",
    }

    -- use { -- Statusbar
    --   "nvim-lualine/lualine.nvim",
    --   config = get_config "lualine-vscode",
    -- }

    -- use { -- Statusbar
    --   "feline-nvim/feline.nvim",
    --   after = "nvim-web-devicons",
    --   config = get_config "feline",
    -- }

    use { "akinsho/toggleterm.nvim", config = get_config "toggleterm" }

    use { -- Bufferline
      "akinsho/bufferline.nvim",
      config = get_config "bufferline",
    }

    use { "famiu/bufdelete.nvim" } -- Delete buffer keep window stay in place.

    use { "rcarriga/nvim-notify", config = get_config "notify" } -- Better notifications

    use { -- Icons
      "kyazdani42/nvim-web-devicons",
      after = "base46",
      config = get_config "nvim-web-devicons",
    }

    -- use { -- Dashboard
    --   "glepnir/dashboard-nvim",
    --   config = get_config "dashboard",
    -- }

    use { -- TODO comments highlight
      "folke/todo-comments.nvim",
      config = get_config "todo-comments",
    }

    use {
      "LudoPinelli/comment-box.nvim",
      config = get_config "comment-box",
    }

    use { -- Better looking quickfix list
      "kevinhwang91/nvim-bqf",
      ft = "qf",
    }

    use { -- Stabilize windows when splits
      "luukvbaal/stabilize.nvim",
      config = function()
        require("stabilize").setup()
      end,
    }

    use { -- Zenmode
      "folke/zen-mode.nvim",
      config = get_config "zenmode",
    }

    use { "folke/twilight.nvim", config = get_config "twilight" }

    use { -- Smooth scrolling
      "karb94/neoscroll.nvim",
      config = get_config "neoscroll",
    }

    -- use { -- Easily see cursor movement
    --   "edluffy/specs.nvim",
    --   config = get_config "specs",
    -- }

    use { "danilamihailov/beacon.nvim", config = get_config "beacon" }

    --[[ Editing support ]]
    use { "numToStr/Comment.nvim", config = get_config "comment" } -- comment things easily

    use { "tpope/vim-surround", requires = { "tpope/vim-repeat" } }

    use { -- Autopairs
      "windwp/nvim-autopairs",
      config = get_config "nvim-autopairs",
    }

    use { -- Like Easymotion
      "phaazon/hop.nvim",
      config = get_config "hop",
    }

    -- use { -- Like Sneak
    --   "rlane/pounce.nvim",
    --   config = get_config "pounce",
    -- }

    use { -- Like Sneak
      "ggandor/lightspeed.nvim",
      config = get_config "lightspeed",
    }

    -- use { -- Like sneak
    --   "ggandor/leap.nvim",
    --   config = function()
    --     require("leap").setup {
    --       case_insensitive = true,
    --       -- These keys are captured directly by the plugin at runtime.
    --       special_keys = {
    --         repeat_search = "<enter>",
    --         next_match = "<enter>",
    --         prev_match = "<tab>",
    --         next_group = "<space>",
    --         prev_group = "<tab>",
    --         eol = "<space>",
    --       },
    --     }
    --     require("leap").set_default_keymaps()
    --   end,
    -- }

    use { -- Markdown
      "preservim/vim-markdown",
    }

    use { "junegunn/vim-easy-align" } -- No lua alternative :(

    use { -- Moving between windows better
      "https://gitlab.com/yorickpeterse/nvim-window",
      config = get_config "nvim-window",
    }

    use {
      "nyngwang/NeoZoom.lua",
      branch = "neo-zoom-original", -- UNCOMMENT THIS, if you prefer the old one
      cmd = "NeoZoomToggle",
    }

    -- use {
    --   "beauwilliams/focus.nvim",
    --   event = "WinNew",
    --   config = get_config "focus",
    -- }

    --[[ Misc ]]
    use { -- Extract react component to different file
      "napmn/react-extract.nvim",
      config = function()
        require("react-extract").setup()
        vim.keymap.set({ "v" }, "<Leader>re", require("react-extract").extract_to_new_file)
        vim.keymap.set({ "v" }, "<Leader>rc", require("react-extract").extract_to_current_file)
      end,
    }

    use { -- Working with node modules
      "vuki656/package-info.nvim",
      requires = "MunifTanjim/nui.nvim",
      config = get_config "package-info",
    }

    use { -- Better looking fold
      "anuvyklack/pretty-fold.nvim",
      config = get_config "pretty-fold",
      requires = "anuvyklack/nvim-keymap-amend",
    }

    use { -- Better looking UI for input and select
      "stevearc/dressing.nvim",
      config = get_config "dressing",
    }

    use { -- Generate annotation comment
      "danymat/neogen",
      config = get_config "neogen",
    }

    use { -- Handlebars filetype support
      "mustache/vim-mustache-handlebars",
      ft = { "hbs", "html.handlebars", "handlebars" },
    }

    use {
      "AckslD/nvim-trevJ.lua",
      config = 'require("trevj").setup()',
      -- optional call for configurating non-default filetypes etc
      -- uncomment if you want to lazy load
      module = "trevj",
      -- an example for configuring a keybind, can also be done by filetype
      setup = function()
        vim.keymap.set("n", "<leader>j", function()
          require("trevj").format_at_cursor()
        end)
      end,
    }

    use { "mattn/emmet-vim" }

    use { "mg979/vim-visual-multi" }

    use { "antoinemadec/FixCursorHold.nvim" } -- Needed while issue https://github.com/neovim/neovim/issues/12587 is still open

    -- use {
    --   "Shatur/neovim-session-manager",
    --   requires = { "nvim-lua/plenary.nvim" },
    --   config = get_config "session-manager",
    -- }
  end)
end
