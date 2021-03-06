-- local cmp = safe_require "cmp"
-- local luasnip = safe_require "luasnip"
-- local lspkind = safe_require "lspkind"
--
-- if not cmp or not luasnip or not lspkind then
--   return
-- end
--
-- -- Load vscode-like snippets
-- -- require("luasnip.loaders.from_vscode").lazy_load()
--
-- local check_backspace = function() -- Helps SUPER TAB
--   local col = vim.fn.col "." - 1
--   return col == 0 or vim.fn.getline("."):sub(col, col):match "%s"
-- end
--
-- --require("base46").load_highlight "cmp"
--
-- local function border(hl_name)
--   return {
--     { "╭", hl_name },
--     { "─", hl_name },
--     { "╮", hl_name },
--     { "│", hl_name },
--     { "╯", hl_name },
--     { "─", hl_name },
--     { "╰", hl_name },
--     { "│", hl_name },
--   }
-- end
--
-- -- local function border(hl_name)
-- --   return {
-- --     { " ", hl_name },
-- --     { " ", hl_name },
-- --     { " ", hl_name },
-- --     { " ", hl_name },
-- --     { " ", hl_name },
-- --     { " ", hl_name },
-- --     { " ", hl_name },
-- --     { " ", hl_name },
-- --   }
-- -- end
--
-- local cmp_window = require "cmp.utils.window"
--
-- function cmp_window:has_scrollbar()
--   return false
-- end
--
-- cmp.setup {
--   -- window = {
--   --   completion = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
--   --   documentation = { border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" } },
--   -- },
--   window = {
--     completion = {
--       border = border "CmpBorder",
--       winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
--     },
--     documentation = { border = border "CmpDocBorder" },
--   },
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body) -- For `luasnip` users.
--     end,
--   },
--   -- This is important
--   sources = {
--     { name = "nvim_lsp" },
--     { name = "nvim_lua" },
--     { name = "luasnip" },
--     { name = "buffer" },
--     { name = "path" },
--   },
--   mapping = cmp.mapping.preset.insert {
--     ["<C-k>"] = cmp.mapping.select_prev_item(),
--     ["<C-j>"] = cmp.mapping.select_next_item(),
--     ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
--     ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
--     ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
--     ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
--     ["<C-e>"] = cmp.mapping {
--       i = cmp.mapping.abort(),
--       c = cmp.mapping.close(),
--     },
--     -- Accept currently selected item. If none selected, `select` first item.
--     -- Set `select` to `false` to only confirm explicitly selected items.
--     ["<CR>"] = cmp.mapping.confirm { select = true },
--     -- ["<Tab>"] = cmp.mapping(function(fallback)
--     --   if cmp.visible() then
--     --     cmp.select_next_item()
--     --     -- SUPER TAB behavior
--     --   elseif luasnip.expandable() then
--     --     luasnip.expand()
--     --   elseif luasnip.expand_or_jumpable() then
--     --     luasnip.expand_or_jump()
--     --   elseif check_backspace() then
--     --     fallback()
--     --   else
--     --     fallback()
--     --   end
--     -- end, {
--     --   "i",
--     --   "s",
--     -- }),
--     -- ["<S-Tab>"] = cmp.mapping(function(fallback)
--     --   if cmp.visible() then
--     --     cmp.select_prev_item()
--     --
--     --     -- SUPER TAB behavior
--     --   elseif luasnip.jumpable(-1) then
--     --     luasnip.jump(-1)
--     --   else
--     --     fallback()
--     --   end
--     -- end, {
--     --   "i",
--     --   "s",
--     -- }),
--   },
--
--   formatting = {
--     fields = { "kind", "abbr", "menu" },
--     format = lspkind.cmp_format {
--       mode = "symbol", -- show only symbol annotations -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
--       preset = "codicons", -- https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf
--       maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
--       symbol_map = {
--         Text = "",
--         Method = "",
--         Function = "",
--         Constructor = "",
--         Field = "ﰠ",
--         Variable = "",
--         Class = "ﴯ",
--         Interface = "",
--         Module = "",
--         Property = "ﰠ",
--         Unit = "塞",
--         Value = "",
--         Enum = "",
--         Keyword = "",
--         Snippet = "",
--         Color = "",
--         File = "",
--         Reference = "",
--         Folder = "",
--         EnumMember = "",
--         Constant = "",
--         Struct = "פּ",
--         Event = "",
--         Operator = "",
--         TypeParameter = "",
--       },
--       menu = {
--         buffer = "BUF",
--         rg = "RG",
--         nvim_lsp = "LSP",
--         nvim_lua = "Lua",
--         path = "PATH",
--         luasnip = "SNIP",
--         calc = "CALC",
--         spell = "SPELL",
--         emoji = "EMOJI",
--       },
--     },
--   },
--   confirm_opts = {
--     behavior = cmp.ConfirmBehavior.Replace,
--     select = false,
--   },
--   experimental = {
--     ghost_text = false,
--     native_menu = false,
--   },
-- }
--
-- -- Use buffer source for `/`.
-- cmp.setup.cmdline("/", { sources = { { name = "buffer" } } })
--
-- -- Use cmdline & path source for ':'.
-- cmp.setup.cmdline(":", {
--   sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
-- })
--
-- vim.cmd [[
--   hi CmpItemAbbrMatch gui=bold
--   hi CmpItemAbbrMatchFuzzy gui=bold
-- ]]
local present, cmp = pcall(require, "cmp")

if not present then
  return
end

--require("base46").load_highlight "cmp"

vim.opt.completeopt = "menuone,noselect"

local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local cmp_window = require "cmp.utils.window"

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
  local info = self:info_()
  info.scrollable = false
  return info
end

local options = {
  window = {
    completion = {
      border = border "CmpBorder",
      winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = border "CmpDocBorder",
    },
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function(_, vim_item)
      local icons = require("ui.icons").lspkind
      vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
      return vim_item
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif require("luasnip").expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif require("luasnip").jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  },
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
  },
}

-- check for any override
options = require("core.utils").load_override(options, "hrsh7th/nvim-cmp")

cmp.setup(options)
