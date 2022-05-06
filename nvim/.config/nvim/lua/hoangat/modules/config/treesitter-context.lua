local context = safe_require "treesitter-context"

context.setup {
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  throttle = true, -- Throttles plugin updates (may improve performance)
  max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
  patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
    -- For all filetypes
    -- Note that setting an entry here replaces all other patterns for this entry.
    -- By setting the 'default' entry below, you can control which nodes you want to
    -- appear in the context window.
    -- default = {
    --     'class',
    --     'function',
    --     'method',
    --     -- 'for', -- These won't appear in the context
    --     -- 'while',
    --     -- 'if',
    --     -- 'switch',
    --     -- 'case',
    -- },
    -- Example for a specific filetype.
    -- If a pattern is missing, *open a PR* so everyone can benefit.
    --   rust = {
    --       'impl_item',
    --   },
  },
}
-- Commands
-- TSContextEnable, TSContextDisable and TSContextToggle.
--
-- Appearance
-- Use the highlight group TreesitterContext to change the colors of the context. Per default it links to NormalFloat.
