local pounce = safe_require "pounce"
if not pounce then
  return
end

-- Highlights~
--     * `PounceMatch`: Characters that match the fuzzy search pattern.
--     * `PounceGap`: Characters inside a match that are not part of the pattern.
--     * `PounceAccept`: "Accept keys" that can be used to jump to the match.
--     * `PounceAcceptBest`: Highlights the accept key for the best match.

pounce.setup {
  accept_keys = "JFKDLSAHGNUVRBYTMICEOXWPQZ",
  accept_best_key = "<enter>",
  multi_window = true,
  debug = false,
}

vim.cmd [[
  hi PounceMatch guifg=#1f1f28 guibg=#DCD7BA
  hi PounceGap guifg=#1f1f28 guibg=#727169
  hi PounceAccept guifg=#1f1f28 guibg=#658594
  hi PounceAcceptBest guifg=#1f1f28 guibg=#FF9E3B

  nmap s <cmd>Pounce<CR>
  nmap S <cmd>PounceRepeat<CR>
  vmap s <cmd>Pounce<CR>
  omap gs <cmd>Pounce<CR>  " 's' is used by vim-surround
]]
