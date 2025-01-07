local M = {}

function M.setup()
  require("lspconfig").eslint.setup({
    on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        command = "EslintFixAll",
      })
    end,
  })
  require("lspconfig").biome.setup({})
end

return M
