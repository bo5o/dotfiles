local M = {}

function M.setup()
  require("lspconfig").rust_analyzer.setup({
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },
      },
    },
  })
end

return M
