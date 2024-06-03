vim.filetype.add({
  filename = {
    ["sxhkdrc"] = "sxhkd",
    [".sqlfluff"] = "cfg",
    [".flake8"] = "cfg",
  },
  extension = {
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
  },
  pattern = {
    [".*/transforms/.*%.sql"] = "sql.jinja",
    [".*/models/.*%.sql"] = "sql.jinja",
    [".*/macros/.*%.sql"] = "sql.jinja",
    [".*/tests/.*%.sql"] = "sql.jinja",
    ["%.env%.(%a+)"] = function(path, bufnr)
      return require("vim.filetype.detect").shell(path, vim.filetype._getlines(bufnr))
    end,
    ["/tmp/psql%.edit.*"] = "sql",
    ["/tmp/vim-anywhere.*"] = "text",
    ["/tmp/calcurse.*"] = "markdown",
    [".*/%.calcurse/notes/.*"] = "markdown",
    [".*pass.*%.txt"] = "secret",
  },
})
