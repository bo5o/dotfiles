local M = {}

function M.setup()
  require("lspconfig").ts_query_ls.setup({
    settings = {
      parser_install_directories = {
        vim.fs.joinpath(vim.fn.stdpath("data"), "/lazy/nvim-treesitter/parser/"),
      },
      language_retrieval_patterns = {
        "languages/src/([^/]+)/[^/]+\\.scm$",
      },
    },
  })
end

return M
