local M = {}

function M.setup()
  require("lspconfig").tinymist.setup({
    settings = {
      formatterMode = "typstyle",
    },
  })
end

return M
