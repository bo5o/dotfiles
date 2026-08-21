-- In fnox config files (`fnox.toml`, `fnox.<name>.toml`, `fnox/config.toml`, same names
-- as the json schema in plugins/lsp.lua) conceal the age-encrypted secret values,
-- keeping just their first few characters. Enabling `conceallevel` here is what
-- activates the conceal query in after/queries/toml/highlights.scm. `concealcursor` is
-- left empty so the full value shows while the cursor is on its line
local path = vim.api.nvim_buf_get_name(0)
local is_fnox = path:match("fnox%.toml$")
  or path:match("fnox%.[^./\\]+%.toml$")
  or path:match("fnox/config%.toml$")

if is_fnox then
  vim.wo[0][0].conceallevel = 2
  vim.wo[0][0].concealcursor = ""
end
