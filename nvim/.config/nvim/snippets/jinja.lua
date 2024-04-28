local ls = require("luasnip")
local s = ls.s
local parse = require("luasnip.util.parser").parse_snippet

---@param trig string
---@param repl string | table
local function snippet(trig, repl)
  trig = ";" .. trig .. " "
  if type(repl) == "string" then
    return parse(trig, repl)
  else
    return s(trig, repl)
  end
end

return {}, {
  snippet("macro", "{% macro $1($2) %}\n\t$3\n{% endmacro %}"),
  snippet("set", "{% set $1 %}\n\t$2{% endset %}"),
  snippet("block", "{% block $1 %}\n\t$2{% endblock %}"),
}
