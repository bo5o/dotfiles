require("indent_blankline").setup({
  char = "┊",
  use_treesitter = true,
  show_trailing_blankline_indent = true,
  filetype_exclude = {
    "help",
    "vimwiki",
    "markdown",
    "startify",
    "NvimTree",
    "mason.nvim",
  },
  buftype_exclude = { "terminal" },
  show_current_context = false,
})
