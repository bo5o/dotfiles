-- Detect `<name>.<ext>.j2` jinja templates as `<inner ft>.jinja` so the file behaves
-- like its regular filetype while treesitter uses the jinja parser (the inner language
-- is injected back into jinja `(content)` nodes, see
-- after/queries/jinja/injections.scm)
local function jinja_template_filetype(path)
  local inner_name = path:match("^(.*%.%w+)%.j2$")
  if not inner_name then
    return nil
  end
  local inner = vim.filetype.match({ filename = inner_name })
  if not inner then
    return nil
  end
  local compound = inner .. ".jinja"
  vim.treesitter.language.register("jinja", compound)
  return compound
end

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
    [".*%.%w+%.j2"] = jinja_template_filetype,
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
