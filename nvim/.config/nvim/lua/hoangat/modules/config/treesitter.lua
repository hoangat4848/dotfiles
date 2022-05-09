local treesitter = safe_require "nvim-treesitter.configs"
if not treesitter then
  return
end

local rainbow_colors = {
  ["rose-pine"] = { "#eb6f92", "#31748f", "#f6c177", "#ebbcba", "#9ccfd8", "#c4a7e7" },
  nord = { "#8fbcbb", "#88c0d0", "#81a1c1", "#5e81ac" },
  solarized = { "#eee8d5", "#cb4b16", "#b58900", "#fdf6e3", "#2aa198", "#268bd2", "#6c71c4" },
}

treesitter.setup {
  ensure_installed = { "html", "lua", "typescript", "javascript", "python", "json", "jsonc", "pug" },
  sync_install = true,
  ignore_install = { "" }, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true, disable = { "yaml" } },
  -- Extensions
  rainbow = {
    enable = false,
    -- colors = { "#eee8d5", "#cb4b16", "#b58900", "#fdf6e3", "#2aa198", "#268bd2", "#6c71c4" },
    -- colors = rainbow_colors[vim.g.colors_name] or {}, -- table of hex strings
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = 2000, -- Do not enable for files with more than n lines, int
    -- termcolors = {} -- table of colour name strings
  },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        ["ir"] = "@parameter.inner",
        ["ar"] = "@parameter.outer",
      },
    },

    swap = {
      enable = true,
      swap_next = {
        ["<leader>a"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>A"] = "@parameter.inner",
      },
    },

    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]r"] = "@parameter.outer",
        ["]b"] = "@block.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]R"] = "@parameter.outer",
        ["]B"] = "@block.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[r"] = "@parameter.outer",
        ["[b"] = "@block.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["]R"] = "@parameter.outer",
        ["]B"] = "@block.outer",
      },
    },

    lsp_interop = {
      enable = true,
      border = "none",
      peek_definition_code = {
        ["<leader>pf"] = "@function.outer",
        ["<leader>pF"] = "@class.outer",
      },
    },
  },
  refactor = {
    highlight_definitions = {
      enable = false,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },

    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
  },
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.glimmer = {
  install_info = {
    url = "~/treesitter/tree-sitter-glimmer",
    files = {
      "src/parser.c",
      "src/scanner.c",
    },
  },
  filetype = "hbs",
  used_by = {
    "handlebars",
    "html.handlebars",
  },
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.ejs = {
  install_info = {
    url = "~/treesitter/tree-sitter-embedded-template",
    files = { "src/parser.c" },
    requires_generate_from_grammar = true,
  },
  filetype = "ejs",
}
