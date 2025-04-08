local M = {}

function M.setup()
  require("lspconfig").ts_query_ls.setup({
    settings = {
      parser_install_directories = {
        vim.fs.joinpath(vim.fn.stdpath("data"), "/lazy/nvim-treesitter/parser/"),
      },
    },
  })
end

return M
