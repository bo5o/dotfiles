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
    ["Jenkinsfile"] = "groovy",
  },
  extension = {
    jinja = "jinja",
    jinja2 = "jinja",
    j2 = "jinja",
    jenkins = "groovy",
    crontab = "crontab",
    hujson = "hujson",
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
    [".*%.md%.j2"] = "markdown.jinja",
    ["%.env%.(%a+)"] = function(path, bufnr)
      return require("vim.filetype.detect").shell(path, vim.filetype._getlines(bufnr))
    end,
    ["/tmp/psql%.edit.*"] = "sql",
    ["/tmp/vim-anywhere.*"] = "text",
    ["/tmp/calcurse.*"] = "markdown",
    [".*/%.calcurse/notes/.*"] = "markdown",
    [".*pass.*%.txt"] = "secret",
    [".*%.py%.lock"] = "toml",
    ["Jenkinsfile%.(%a+)"] = "groovy",
  },
})

-- Vim-Jinja2-Syntax re-runs filetype detection when it is lazy-loaded and its
-- ftdetect unconditionally sets `jinja`, clobbering compound filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("markdown_jinja", { clear = true }),
  pattern = "jinja",
  callback = function(args)
    if vim.bo[args.buf].filetype == "jinja" and args.file:match("%.md%.j2$") then
      vim.bo[args.buf].filetype = "markdown.jinja"
    end
  end,
  desc = "Keep markdown.jinja filetype for *.md.j2 files",
})
