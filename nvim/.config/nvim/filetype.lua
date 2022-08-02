vim.filetype.add({
  extension = {
    foo = "fooscript",
  },
  filename = {
    [".foorc"] = "foorc",
  },
  pattern = {
    [".*/models/.*%.sql"] = "jinja",
    [".*/macros/.*%.sql"] = "jinja",
    ["%.env%.(%a+)"] = function()
      vim.fn["dist#ft#SetFileTypeSH"](vim.fn.getline(1))
    end,
    ["/tmp/psql%.edit.*"] = "sql",
    ["/tmp/vim-anywhere.*"] = "text",
    ["/tmp/calcurse.*"] = "markdown",
    [".*/%.calcurse/notes/.*"] = "markdown",
    [".*pass.*%.txt"] = "secret",
  },
})
