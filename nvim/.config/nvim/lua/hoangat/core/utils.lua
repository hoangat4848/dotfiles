function P(v)
  print(vim.inspect(v))
  return v
end

function _G.safe_require(module)
  local status_ok, result = pcall(require, module)
  if not status_ok then
    vim.notify(string.format("Error requiring: %s", module), vim.log.levels.ERROR)
    return status_ok
  end
  return result
end

CONFIG_PATH = "hoangat.modules.config."

-- Override vim input with fancy float window. Cre: https://www.reddit.com/r/neovim/comments/ua6826/3_lua_override_vimuiinput_in_40_lines/
local function wininput(opts, on_confirm, win_opts)
  -- create a "prompt" buffer that will be deleted once focus is lost
  local buf = vim.api.nvim_create_buf(false, false)
  vim.bo[buf].buftype = "prompt"
  vim.bo[buf].bufhidden = "wipe"

  local prompt = opts.prompt or ""
  local default_text = opts.default or ""

  -- defer the on_confirm callback so that it is
  -- executed after the prompt window is closed
  local deferred_callback = function(input)
    vim.defer_fn(function()
      on_confirm(input)
    end, 10)
  end

  -- set prompt and callback (CR) for prompt buffer
  vim.fn.prompt_setprompt(buf, prompt)
  vim.fn.prompt_setcallback(buf, deferred_callback)

  -- set some keymaps: CR confirm and exit, ESC in normal mode to abort
  vim.keymap.set({ "i", "n" }, "<CR>", "<CR><Esc>:close!<CR>:stopinsert<CR>", {
    silent = true,
    buffer = buf,
  })
  vim.keymap.set("n", "<esc>", "<cmd>close!<CR>", {
    silent = true,
    buffer = buf,
  })

  local default_win_opts = {
    relative = "editor",
    row = vim.o.lines / 2 - 1,
    col = vim.o.columns / 2 - 25,
    width = 50,
    height = 1,
    focusable = true,
    style = "minimal",
    border = "rounded",
  }

  win_opts = vim.tbl_deep_extend("force", default_win_opts, win_opts)

  -- adjust window width so that there is always space
  -- for prompt + default text plus a little bit
  win_opts.width = #default_text + #prompt + 5 < win_opts.width and win_opts.width or #default_text + #prompt + 5

  -- open the floating window pointing to our buffer and show the prompt
  local win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.api.nvim_win_set_option(win, "winhighlight", "Search:None")

  vim.cmd "startinsert"

  -- set the default text (needs to be deferred after the prompt is drawn)
  vim.defer_fn(function()
    vim.api.nvim_buf_set_text(buf, 0, #prompt, 0, #prompt, { default_text })
    vim.cmd "startinsert!" -- bang: go to end of line
  end, 5)
end

-- override vim.ui.input ( telescope rename/create, lsp rename, etc )
vim.ui.input = function(opts, on_confirm)
  -- intercept opts and on_confirm,
  -- check buffer options, filetype, etc and set window options accordingly.
  wininput(opts, on_confirm, { border = "rounded", relative = "cursor", row = 1, col = 0, width = 0 })
end

local M = {}
local cmd = vim.cmd
-- Highlights functions

-- Define bg color
-- @param group Group
-- @param color Color

M.bg = function(group, col)
  cmd("hi " .. group .. " guibg=" .. col)
end

-- Define fg color
-- @param group Group
-- @param color Color
M.fg = function(group, col)
  cmd("hi " .. group .. " guifg=" .. col)
end

-- Define bg and fg color
-- @param group Group
-- @param fgcol Fg Color
-- @param bgcol Bg Color
M.fg_bg = function(group, fgcol, bgcol)
  cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

return M
