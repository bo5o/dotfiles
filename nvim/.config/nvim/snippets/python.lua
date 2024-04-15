local ls = require("luasnip")
local s = ls.s
local f = ls.function_node
local parse = require("luasnip.util.parser").parse_snippet
local fmt = require("luasnip.extras.fmt").fmt
local postfix = require("luasnip.extras.postfix").postfix

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

---@param trig string
---@param repl string
local function comment(trig, repl)
  return snippet(trig, "# " .. repl .. " ")
end

---@param trig string
---@param repl string
local function docstring_section(trig, repl)
  local underline = string.rep("-", repl:len())
  return snippet(trig, repl .. "\n" .. underline .. "\n$1")
end

---@param trig string
local function sphinx_xref(trig)
  return postfix(".x" .. trig .. " ", {
    f(function(_, parent)
      return ":" .. trig .. ":`" .. parent.snippet.env.POSTFIX_MATCH .. "` "
    end, {}),
  })
end

return {}, {
  snippet("doc", '"""$1"""\n$2'),
  snippet("arg", "$1 : $2"),
  comment("tod", "TODO:"),
  comment("todo", "TODO:"),
  comment("noqa", "noqa:"),
  snippet("#", " # "),
  snippet("c", "# %%"),
  docstring_section("par", "Parameters"),
  docstring_section("params", "Parameters"),
  docstring_section("args", "Parameters"),
  docstring_section("ret", "Returns"),
  docstring_section("rai", "Raises"),
  docstring_section("err", "Raises"),
  docstring_section("yie", "Yields"),
  docstring_section("att", "Attributes"),
  docstring_section("catt", "Class Attributes"),
  docstring_section("exa", "Examples"),
  docstring_section("exp", "Examples"),
  docstring_section("not", "Notes"),
  docstring_section("see", "See Also"),
  docstring_section("key", "Keyword"),
  docstring_section("Ref", "Reference"),
  docstring_section("war", "Warning"),
  docstring_section("oth", "Other"),
  docstring_section("met", "Methods"),
  snippet("cls", "class $1($2):\n\t$3"),
  snippet("class", "class $1($2):\n\t$3"),
  snippet("dclass", "@dataclasses.dataclass\nclass $1($2):\n\t$3"),
  snippet("def", "\ndef $1($2)$3:\n\t$4"),
  snippet("fun", "\ndef $1($2)$3:\n\t$4"),
  snippet("defa", "async def $1($2)$3:\n\t$4"),
  snippet("defm", "\ndef $1(self, $2)$3:\n\t$4"),
  snippet("defp", "@property\ndef $1($2)$3:\n\t$4"),
  snippet("prop", "@property\ndef $1($2)$3:\n\t$4"),
  snippet("get", "@property\ndef $1($2)$3:\n\t$4"),
  snippet("set", "@$1.setter\ndef $2(self, ${3:value}):\n\t$4"),
  snippet("def@", "@$1\ndef $2($3)$4:\n\t$5"),
  snippet("defm@", "@$1\ndef $2(self, $3)$4:\n\t$5"),
  snippet("defi", "def __init__(self, $1)$2:\n\t$3"),
  snippet("defd", "def __$1__(self, $2)$3:\n\t$4"),
  snippet("deft", "def test_$1($2):\n\t$3"),
  snippet("pd", "import pandas as pd"),
  snippet("plt", "from matplotlib import pyplot as plt"),
  snippet("np", "import numpy as np"),
  snippet("rt", "reveal_type($1)"),
  snippet("bp", "breakpoint()"),
  snippet("debug", "breakpoint()"),
  sphinx_xref("obj"),
  sphinx_xref("ref"),
}
