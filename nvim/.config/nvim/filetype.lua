vim.filetype.add({
  filename = {
    ["sxhkdrc"] = "sxhkd",
    [".sqlfluff"] = "cfg",
    [".flake8"] = "cfg",
  },
  pattern = {
    [".*/models/.*%.sql"] = "jinja",
    [".*/macros/.*%.sql"] = "jinja",
    [".*/tests/.*%.sql"] = "jinja",
    ["%.env%.(%a+)"] = function(path, bufnr)
      return require("vim.filetype.detect").sh(path, vim.filetype.getlines(bufnr))
    end,
    ["/tmp/psql%.edit.*"] = "sql",
    ["/tmp/vim-anywhere.*"] = "text",
    ["/tmp/calcurse.*"] = "markdown",
    [".*/%.calcurse/notes/.*"] = "markdown",
    [".*pass.*%.txt"] = "secret",
  },
})
