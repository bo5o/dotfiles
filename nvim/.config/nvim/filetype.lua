vim.filetype.add({
  filename = {
    ["sxhkdrc"] = "sxhkd",
    [".sqlfluff"] = "cfg",
    [".sqruff"] = "cfg",
    [".flake8"] = "cfg",
    [".yamlfmt"] = "yaml",
    ["requirements.lock"] = "requirements",
    ["requirements-dev.lock"] = "requirements",
    ["uv.lock"] = "toml",
    [".markdownlintrc"] = "json",
    ["Caddyfile"] = "caddy",
  },
  extension = {
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
  },
  pattern = {
    ["docker-compose%.ya?ml"] = "yaml.docker-compose",
    ["docker-compose%.(%a+)%.ya?ml"] = "yaml.docker-compose",
    ["compose%.ya?ml"] = "yaml.docker-compose",
    ["compose%.(%a+)%.ya?ml"] = "yaml.docker-compose",
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
    [".*%.py%.lock"] = "toml",
  },
})
