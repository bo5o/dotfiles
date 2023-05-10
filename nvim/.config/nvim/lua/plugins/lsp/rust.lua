local M = {}

function M.setup()
  require("lspconfig").rust_analyzer.setup({
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  })
end

return M
