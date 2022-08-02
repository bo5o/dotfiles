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
    pre_hook = function(ctx)
      local U = require("Comment.utils")

      local location = nil
      if ctx.ctype == U.ctype.block then
        location = require("ts_context_commentstring.utils").get_cursor_location()
      elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
        location = require("ts_context_commentstring.utils").get_visual_start_location()
      end

      return require("ts_context_commentstring.internal").calculate_commentstring({
        key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
        location = location,
      })
    end,
  })
end

return M
