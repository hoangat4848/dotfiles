--[[ Plugins manager ]]

local function get_config(plugin_name)
  return string.format('require("hoangat.modules.config.%s")', plugin_name)
end

local plugins = {
  --==========================================================

  { -- Markdown
    "preservim/vim-markdown",
  },

  { -- Zenmode
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        window = {
          width = 100, -- width of the Zen window
          height = 1, -- height of the Zen window
        },
      }
    end,
  },

  { -- Copilot
    "github/copilot.vim",
    config = function()
      vim.cmd [[imap <silent><script><expr> <C-L> copilot#Accept("\<CR>")]]
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_filetypes = {
        ["*"] = true,
        gitcommit = false,
        NeogitCommitMessage = false,
      }
    end,
  },
  { -- Git related
    { -- Like magit
      "TimUntersberger/neogit",
      config = get_config "neogit",
      requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    },
  },
}

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
      },
    }
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
        { "folke/trouble.nvim", config = get_config "lsp.trouble" }, -- A pretty list for showing diagnostics, references..
        -- { "filipdutescu/renamer.nvim", config = get_config("lsp.renamer") },
        --{ "ray-x/navigator.lua", requires = { "ray-x/guihua.lua", run = "cd lua/fzy && make" } },
      },
    }

    --use({ -- Lsp
    --	"neovim/nvim-lspconfig",
    --	config = get_config("lsp"),
    --	--config = "require 'hoangat.lsp'",
    --	requires = {
    --		"williamboman/nvim-lsp-installer",
    --		"jose-elias-alvarez/null-ls.nvim", -- Formatter
    --		"b0o/schemastore.nvim", -- JSON schema for jsonls
    --		--"ray-x/lsp_signature.nvim",
    --		--"RRethy/vim-illuminate",
    --		--"jose-elias-alvarez/nvim-lsp-ts-utils",
    --	},
    --})

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
          requires = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
          },
        },
      },
    }

    use { -- Telescope
      "nvim-telescope/telescope.nvim",
      config = get_config "telescope",
      requires = {
        "nvim-lua/plenary.nvim",
        "jvgrootveld/telescope-zoxide",
      },
    }

    use { "ThePrimeagen/harpoon", config = get_config "harpoon" }

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

    --[[ Appearance ]]

    use { -- Colorschemes
      --"Mofiqul/vscode.nvim",
      "rose-pine/neovim",
      as = "rose-pine",
      tag = "v1.*",
      config = get_config "colorscheme",
    }

    use {
      "shaunsingh/nord.nvim",
      config = get_config "colorscheme",
    }

    use {
      "Mofiqul/vscode.nvim",
      config = get_config "colorscheme",
    }

    use { "rebelot/kanagawa.nvim", config = get_config "colorscheme" }

    use { "ishan9299/nvim-solarized-lua", config = get_config "colorscheme" }

    --Which key
    use { "folke/which-key.nvim", config = get_config "which-key" }

    use { -- Nvim Tree
      "kyazdani42/nvim-tree.lua",
      config = get_config "nvim-tree",
    }

    use { -- Colorizer
      "norcalli/nvim-colorizer.lua",
      config = get_config "nvim-colorizer",
    }

    use { -- Indent guides
      "lukas-reineke/indent-blankline.nvim",
      config = get_config "indent-blankline",
    }

    use { -- Statusbar
      "nvim-lualine/lualine.nvim",
      config = get_config "lualine",
    }

    use {
      "kdheepak/tabline.nvim",
      config = get_config "tabline",
    }

    -- use { -- Bufferline
    --   "akinsho/bufferline.nvim",
    --   config = get_config "bufferline",
    -- }

    use { "rcarriga/nvim-notify", config = get_config "notify" } -- Better notifications

    use { -- Icons
      "kyazdani42/nvim-web-devicons",
      config = get_config "nvim-web-devicons",
    }

    use { -- Dashboard
      "goolord/alpha-nvim",
      config = function()
        require("alpha").setup(require("alpha.themes.dashboard").config)
      end,
    }

    use { -- Stabilize windows when splits
      "luukvbaal/stabilize.nvim",
      config = function()
        require("stabilize").setup()
      end,
    }

    use { -- TODO comments highlight
      "folke/todo-comments.nvim",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("todo-comments").setup {}
      end,
    }

    use { -- Smooth scrolling
      "karb94/neoscroll.nvim",
      config = get_config "neoscroll",
    }
    use { -- Zenmode
      "folke/zen-mode.nvim",
      config = get_config "zenmode",
    }

    use { "folke/twilight.nvim", config = get_config "twilight" }

    --[[ Editing support ]]
    use { "numToStr/Comment.nvim", config = get_config "comment" } -- comment things easily

    use { "tpope/vim-surround", requires = { "tpope/vim-repeat" } }

    use { -- Autopairs
      "windwp/nvim-autopairs",
      config = get_config "nvim-autopairs",
    }

    use { "phaazon/hop.nvim", config = get_config "hop" } -- easymotion

    use { -- Sneak
      "rlane/pounce.nvim",
      config = get_config "pounce",
    }

    use {
      "SmiteshP/nvim-gps",
      requires = "nvim-treesitter/nvim-treesitter",
      config = get_config "nvim-gps",
    }

    use { "akinsho/toggleterm.nvim", config = get_config "toggleterm" }

    use { -- Markdown
      "preservim/vim-markdown",
    }

    --use({ "mizlan/iswap.nvim", config = get_config("iswap") })
  end)
end
