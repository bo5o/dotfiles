local M = {}

function M.config()
  require("dressing").setup({
    input = {
      enabled = true,
      prompt_align = "left",
      border = "rounded",
    },
    select = {
      enabled = true,
      backend = { "telescope" },
      telescope = require("telescope.themes").get_cursor({}),
    },
  })
end

return M
