local parse = require("luasnip.util.parser").parse_snippet

---@param trig string
local function xref(trig)
  return parse(":" .. trig .. " ", ":" .. trig .. ":`$1` $2")
end

return {}, {
  xref("mod"),
  xref("class"),
  xref("meth"),
  xref("func"),
  xref("math"),
  xref("data"),
  xref("const"),
  xref("attr"),
  xref("exc"),
  xref("obj"),
  xref("program"),
  xref("ref"),
  xref("doc"),
  xref("download"),
  xref("file"),
}
