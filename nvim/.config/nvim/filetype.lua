vim.filetype.add({
  filename = {
    ["sxhkdrc"] = "sxhkd",
    [".sqlfluff"] = "cfg",
    [".flake8"] = "cfg",
  },
  pattern = {
    [".*/transforms/.*%.sql"] = "sql.jinja",
    [".*/models/.*%.sql"] = "sql.jinja",
    [".*/macros/.*%.sql"] = "sql.jinja",
    [".*/tests/.*%.sql"] = "sql.jinja",
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
