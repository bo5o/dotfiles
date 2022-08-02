local M = {}

function M.config()
  vim.api.nvim_set_hl(
    0,
    "gitmessengerPopupNormal",
    { term = nil, fg = "#ebdbb2", bg = "#32302f", ctermfg = nil, ctermbg = nil }
  )
end

return M
