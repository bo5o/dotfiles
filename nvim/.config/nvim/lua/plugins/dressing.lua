local M = {}

function M.config()
  require("dressing").setup({
    input = {
      enabled = true,
    },
    select = {
      enabled = true,
      backend = { "telescope", "builtin" },
    },
  })
end

return M
