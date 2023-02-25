local M = {}

function M.config()
  require("Comment").setup({
    opleader = {
      line = "gc",
      block = "gC",
    },
    toggler = {
      line = "gcc",
      block = "gcb",
    },
    mappings = {
      basic = true,
      ---Extra mapping
      ---Includes `gco`, `gcO`, `gcA`
      extra = false,
      ---Extended mapping
      ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extended = false,
    },
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  })
end

return M
