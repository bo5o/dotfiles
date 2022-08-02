local M = {}

function M.config()
  require("nvim-autopairs").setup({
    check_ts = true,
    enable_afterquote = true,
    enable_moveright = true,
    enable_check_bracket_line = true,
  })

  local cmp = require("cmp")
  local cmp_autopairs = require("nvim-autopairs.completion.cmp")

  cmp.event:on(
    "confirm_done",
    cmp_autopairs.on_confirm_done({
      map_char = {
        all = "(",
        tex = "{",
      },
    })
  )
end

return M
