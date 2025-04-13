return {
  settings = {
    parser_install_directories = {
      vim.fs.joinpath(vim.fn.stdpath("data"), "/lazy/nvim-treesitter/parser/"),
    },
    language_retrieval_patterns = {
      "languages/src/([^/]+)/[^/]+\\.scm$",
    },
  },
}
