local snippet_augroup = vim.api.nvim_create_augroup("my_snippets", { clear = true })

local function create_snippet(ft, lhs, rhs)
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { ft },
    group = snippet_augroup,
    callback = function()
      vim.keymap.set("i", lhs, rhs, { buffer = true })
    end,
  })
end

-- bibtex
create_snippet(
  "bib",
  ";a",
  [[@article{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>journaltitle<Space>=<Space>"<++>",<Enter>volume<Space>=<Space>"<++>",<Enter>pages<Space>=<Space>"<++>",<Enter>}<Enter><backspace><++><Esc>8kA,<Esc>i]]
)
create_snippet(
  "bib",
  ";b",
  [[@book{<Enter>author<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><backspace><++><Esc>6kA,<Esc>i]]
)
create_snippet(
  "bib",
  ";c",
  [[@incollection{<Enter>author<Space>=<Space>"<++>",<Enter>title<Space>=<Space>"<++>",<Enter>booktitle<Space>=<Space>"<++>",<Enter>editor<Space>=<Space>"<++>",<Enter>year<Space>=<Space>"<++>",<Enter>publisher<Space>=<Space>"<++>",<Enter>}<Enter><backspace><++><Esc>8kA,<Esc>i]]
)

-- Markdown
create_snippet("markdown", ";n", [[---<Enter><Enter>]])
create_snippet("markdown", ";b", [[****<Space><++><Esc>F*hi]])
create_snippet("markdown", ";s", [[~~~~<Space><++><Esc>F~hi]])
create_snippet("markdown", ";e", [[**<Space><++><Esc>F*i]])
create_snippet("markdown", ";h", [[====<Space><++><Esc>F=hi]])
create_snippet("markdown", ";i", [[![](<++>)<Space><++><Esc>F[a]])
create_snippet("markdown", ";a", [[[](<++>)<Space><++><Esc>F[a]])
create_snippet("markdown", ";1", [[#<Space><Enter><++><Esc>kA]])
create_snippet("markdown", ";2", [[##<Space><Enter><++><Esc>kA]])
create_snippet("markdown", ";3", [[###<Space><Enter><++><Esc>kA]])
create_snippet("markdown", ";l", [[--------<Enter>]])
create_snippet(
  "markdown",
  ";bib",
  [[<Esc>Go<Enter><++><Enter><Enter>#<Space>References<Enter><Enter>---<Enter>bibliography:<Space><c-r>=$HOME<Enter>/latex/.bibfiles/<Enter>csl:<Space><c-r>=$HOME<Enter>/.config/csl/ieee.csl<Enter>---<Esc>2kA]]
)
create_snippet("markdown", ";t", [[\todo{}<Enter><Enter><++><Esc>2k$i]])
create_snippet(
  "markdown",
  ";y",
  [[---<Enter>title:<Space>""<Enter>author:<Space>[Christian<Space>Bosdorf]<Enter>date:<Space><C-R>=strftime('%Y-%m-%d')<CR><Enter>...<Esc>3k$i]]
)
create_snippet(
  "markdown",
  ";;e",
  [[\begin{equation}<Enter>\end{equation}<Enter><++><Esc>kko]]
)

-- latex
create_snippet(
  "tex",
  ";fig",
  [[\begin{figure}[ht]<Enter>\centering<Enter>\includegraphics[width=0.8\linewidth]{images/}<Enter>\caption{<++>}\label{fig:<++>}<Enter>\end{figure}<Enter><Enter><++><Esc>4kf}i<C-x><C-f>]]
)
create_snippet(
  "tex",
  ";tikz",
  [[\begin{figure}[ht]<Enter>\centering<Enter>\input{tikz/}<Enter>\caption{<++>}\label{fig:<++>}<Enter>\end{figure}<Enter><Enter><++><Esc>4kf}i<C-x><C-f>]]
)
create_snippet(
  "tex",
  ";plot",
  [[\begin{figure}[ht]<Enter>\centering<Enter>\input{plots/}<Enter>\caption{<++>}\label{fig:<++>}<Enter>\end{figure}<Enter><Enter><++><Esc>4kf}i<C-x><C-f>]]
)
create_snippet(
  "tex",
  ";gle",
  [[\newglossaryentry{}<enter>{%<enter>name={<++>},<enter>description={<++>}<enter>}<enter><enter><++><Esc>6kf}i]]
)
create_snippet(
  "tex",
  ";sym",
  [[\newglossaryentry{sym:}<enter>{%<enter>type=symbols,<enter>name={\ensuremath{<++>}},<enter>description={<++>},<enter>symbol=\si{<++>},<enter>sort={<++>},<enter>}<enter><enter><++><Esc>9kf}i]]
)
create_snippet(
  "tex",
  ";not",
  [[\newglossaryentry{not:}<enter>{%<enter>type=notation,<enter>name={<++>},<enter>description={<++>},<enter>sort={<++>},<enter>}<enter><enter><++><Esc>8kf}i]]
)
create_snippet("tex", ";acr", [[\newacronym{acr:}{<++>}{<++>}<enter><++><Esc>kf}i]])
create_snippet("tex", ";acs", [[\acrshort{acr:}<space><++><Esc>F}i]])
create_snippet("tex", ";gls", [[\gls{}<space><++><Esc>F}i]])
create_snippet("tex", ";Gls", [[\Gls{}<space><++><Esc>F}i]])
create_snippet("tex", ";m", [[\(\)<++><Esc>F\i]])

-- restructured text
create_snippet("rst", ";1", [[<Esc>YpVr=o]])
create_snippet("rst", ";2", [[<Esc>YpVr-o]])
create_snippet("rst", ";3", [[<Esc>YpVr~o]])
create_snippet("rst", ";b", [[****<Space><++><Esc>F*hi]])
create_snippet("rst", ";c", [[````<Space><++><Esc>F`hi]])
create_snippet("rst", ";e", [[**<Space><++><Esc>F*i]])
create_snippet("rst", ";i", [[`<Space><<++>>`__<++><Esc>2F`a]])
create_snippet("rst", ";a", [[::`<++><Space><<++>>`__<++><Esc>2F:a]])
create_snippet("rst", "..c", [[..<Space>code::<CR><CR><Tab><++><Esc>2kA<Space>]])
create_snippet("rst", "..i", [[..<Space>image::<CR><Tab><++><Esc>kA<Space>]])

-- tikz
create_snippet(
  "tex",
  ";tp",
  [[\begin{tikzpicture}[]<enter><++><enter>\end{tikzpicture}<Esc>2kf]i]]
)
create_snippet(
  "tex",
  ";node",
  [[\node[]<space>(<++>)<space>at<space>(<++>)<space>{<++>};<Esc>F]i]]
)
create_snippet(
  "tex",
  ";draw",
  [[\draw[]<space>(<++>)<space><++><space>(<++>);<Esc>F]i]]
)
create_snippet("tex", ";linu", [[\linunit[]{<++>}{<++>}<Esc>F]i]])
create_snippet("tex", ";tanh", [[\tanhunit[]{<++>}{<++>}<Esc>F]i]])
create_snippet("tex", ";sigm", [[\sigmunit[]{<++>}{<++>}<Esc>F]i]])
create_snippet("tex", ";sum", [[\sumunit[]{<++>}{<++>}<Esc>F]i]])
create_snippet("tex", ";isec", [[\intersec[]{<++>}<Esc>F]i]])

-- python
create_snippet("python", ";-", [[<Esc>Ypviwr-o]])
