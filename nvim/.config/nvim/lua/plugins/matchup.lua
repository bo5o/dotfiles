local M = {}

function M.setup()
  vim.g.matchup_transmute_enabled = 0 -- covered by nvim-ts-autotag
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
end

return M
