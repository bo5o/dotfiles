local M = {}

function M.setup()
  require("lspconfig").lemminx.setup({
    init_options = {
      settings = {
        xml = {
          format = {
            splitAttributes = true,
          },
        },
      },
    },
  })
end

return M
