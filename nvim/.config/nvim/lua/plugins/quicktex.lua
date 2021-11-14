local jump = [[:call search('<+.*+>')"_c/+>/e]]
vim.g.quicktex_rst = {
	[" "] = jump,
	-- cross referencing
	[":mod"] = ":mod:`<+++>` <++>",
	[":class"] = ":class:`<+++>` <++>",
	[":meth"] = ":meth:`<+++>` <++>",
	[":func"] = ":func:`<+++>` <++>",
	[":math"] = ":math:`<+++>` <++>",
	[":data"] = ":data:`<+++>` <++>",
	[":const"] = ":const:`<+++>` <++>",
	[":attr"] = ":attr:`<+++>` <++>",
	[":exc"] = ":exc:`<+++>` <++>",
	[":obj"] = ":obj:`<+++>` <++>",
	[":program"] = ":program:`<+++>` <++>",
	[":ref"] = ":ref:`<+++>` <++>",
	[":doc"] = ":doc:`<+++>` <++>",
	[":download"] = ":download:`<+++>` <++>",
	[":file"] = ":file:`<+++>` <++>",
}

vim.g.quicktex_markdown = {
	[" "] = jump,
}

vim.g.quicktex_python = {
	[" "] = jump,
	-- docstrings
	[";doc"] = '"""<+++>"""',
	[";arg"] = "<+++> : <++>",
	[";tod"] = "# TODO: <+++>",
	[";todo"] = "# TODO: <+++>",
	[";noqa"] = "# noqa: <+++>",
	[";par"] = [[Parameters----------]],
	[";params"] = [[Parameters----------]],
	[";args"] = [[Parameters----------]],
	[";ret"] = [[Returns-------]],
	[";rai"] = [[Raises------]],
	[";err"] = [[Raises------]],
	[";yie"] = [[Yields------]],
	[";att"] = [[Attributes----------]],
	[";catt"] = [[Class Attributes----------------]],
	[";exa"] = [[Examples--------]],
	[";not"] = [[Notes-----]],
	[";see"] = [[See Also--------]],
	[";key"] = [[Keyword-------]],
	[";Ref"] = [[References----------]],
	[";war"] = [[Warning-------]],
	[";oth"] = [[Other-----]],
	[";met"] = [[Methods-------]],
	[";exp"] = [[Examples--------]],
	[";obj"] = ":obj:`<+++>`<++>",
	-- cross referencing
	[";ref"] = ":ref:`<+++>`<++>",
	-- classes and functons
	[";cls"] = [[class <+++>(<++>):<++>]],
	[";class"] = [[class <+++>(<++>):<++>]],
	[";defi"] = [[def __init__(self, <+++>):<++>]],
	[";defc"] = [[@classmethoddef <+++>(cls, <++>):<++>]],
	[";defs"] = [[@staticmethoddef <+++>(<++>):<++>]],
	[";def@"] = [[@<+++>def <++>(<++>):<++>]],
	[";defm"] = [[def <+++>(self, <++>):<++>]],
	[";defm@"] = [[@<+++>def <++>(self, <++>):<++>]],
	[";defp"] = [[@propertydef <+++>(self):<++>]],
	[";defd"] = [[def __<+++>__(self, <++>):<++>]],
	[";def"] = [[def <+++>(<++>):<++>]],
	[";fun"] = [[def <+++>(<++>):<++>]],
	[";get"] = [[@propertydef <+++>(self):<++>]],
	[";prop"] = [[@propertydef <+++>(self):<++>]],
	[";set"] = [[@<+++>.setterdef <++>(self, value):<++>]],
	-- keywords
	[";im"] = "import <+++>",
	[";bp"] = "breakpoint()<+++>",
	[";debug"] = "breakpoint()<+++>",
	[";rt"] = "reveal_type(<+++>)",
	-- general
	[";pd"] = "import pandas as pd",
	[";plt"] = "import matplotlib.pyplot as plt",
	[";np"] = "import numpy as np",
	[";#"] = " # ",
	[";c"] = "# %%",
}

vim.g.quicktex_javascript = {
	[" "] = jump,
	-- docstrings
	[";tod"] = "// TODO: <+++>",
	-- functions
	[";af"] = "(<+++>) => {<++>}",
	-- keywords
	[";im"] = 'import {<++>} from "<+++>"',
}

vim.g.quicktex_javascript = {
	[" "] = jump,
	-- docstrings
	[";tod"] = "// TODO: <+++>",
	-- functions
	[";af"] = "(<+++>) => {<++>}",
	[";taf"] = "<<++>>(<+++>): <<++>> => {<++>}",
	-- keywords
	[";im"] = 'import {<++>} from "<+++>"',
}

vim.g.quicktex_tex = {
	[" "] = jump,
	["m"] = "( <+++> ) <++>",
	-- Environments
	["env"] = [[Bvedi\begin{pa}<+++>\end{pa}]],
	["ol"] = [[\begin{enumerate}\item <+++>\end{enumerate}]],
	["ul"] = [[\begin{itemize}\item <+++>\end{itemize}]],
	["eqn"] = [[\begin{equation*}<+++>\end{equation*}<++>]],
	["Eqn"] = [[\begin{equation}\label{<+++>}<++>\end{equation}<++>]],
	["frm"] = [[\begin{frame}\frametitle{<+++>}<++>\end{frame}]],
	-- Other commands
	["itm"] = "item ",
	["chap"] = [[\chapter{<+++>}<++>]],
	["sec"] = [[\section{<+++>}<++>]],
	["ssec"] = [[\subsection{<+++>}<++>]],
	["sssec"] = [[\subsubsection{<+++>}<++>]],
	["para"] = "(<+++>) <++>",
	["todo"] = [[\todo{<+++>}<++>]],
	["cmd"] = [[Bi\Ea{<+++>}<++>]],
	["texroot"] = "%! TEX root = .",
	-- Citing and referencing
	["cref"] = [[\cref{<+++>}<++>]],
	["(cref"] = [[(\cref{<+++>}<++>]],
	["Cref"] = [[\Cref{<+++>}<++>]],
	["eqref"] = [[\eqref{eq:<+++>}<++>]],
	["ref"] = [[\ref{<+++>}<++>]],
	["cite"] = [[<BS>~\autocite{<+++>}<++>]],
	["enq"] = [[\enquote{<+++>} <++>]],
	-- Greek letters
	["alpha"] = [[\(\alpha\) ]],
	["ga"] = [[\(\alpha\) ]],
	["beta"] = [[\(\beta\) ]],
	["gamma"] = [[\(\gamma\) ]],
	["delta"] = [[\(\delta\) ]],
	["epsilon"] = [[\(\varepsilon\) ]],
	["ge"] = [[\(\varepsilon\) ]],
	["zeta"] = [[\(\zeta\) ]],
	["eta"] = [[\(\eta\) ]],
	["theta"] = [[\(\theta\) ]],
	["iota"] = [[\(\iota\) ]],
	["kappa"] = [[\(\kappa\) ]],
	["lambda"] = [[\(\lambda\) ]],
	["gl"] = [[\(\lambda\) ]],
	["mu"] = [[\(\mu\) ]],
	["nu"] = [[\(\nu\) ]],
	["xi"] = [[\(\xi\) ]],
	["omega"] = [[\(\omega\) ]],
	["pi"] = [[\(\pi\) ]],
	["rho"] = [[\(\rho\) ]],
	["sigma"] = [[\(\sigma\) ]],
	["tau"] = [[\(\tau\) ]],
	["upsilon"] = [[\(\upsilon\) ]],
	["gu"] = [[\(\upsilon\) ]],
	["phi"] = [[\(\varphi\) ]],
	["chi"] = [[\(\chi\) ]],
	["psi"] = [[\(\psi\) ]],
	-- Uppercase greek letters
	["Gamma"] = [[\(\Gamma\) ]],
	["Delta"] = [[\(\Delta\) ]],
	["Theta"] = [[\(\Theta\) ]],
	["Lambda"] = [[\(\Lambda\) ]],
	["Xi"] = [[\(\Xi\) ]],
	["Omega"] = [[\(\Omega\) ]],
	["Pi"] = [[\(\Pi\) ]],
	["Sigma"] = [[\(\Sigma\) ]],
	["Upsilon"] = [[\(\Upsilon\) ]],
	["Phi"] = [[\(\Phi\) ]],
	["Chi"] = [[\(\Chi\) ]],
	["Psi"] = [[\(\Psi\) ]],
	-- Text formatting
	["em"] = [[\emph{<+++>} <++>]],
	["sc"] = [[\textsc{<+++>} <++>]],
	["tt"] = [[\texttt{<+++>} <++>]],
	["bf"] = [[\textbf{<+++>} <++>]],
	[";it"] = [[\textit{<+++>} <++>]],
}

vim.g.quicktex_math = {
	[" "] = jump,
	-- lowercase greek letters
	["alpha"] = [[\alpha ]],
	["ga"] = [[\alpha ]],
	["beta"] = [[\beta ]],
	["gamma"] = [[\gamma ]],
	["delta"] = [[\delta ]],
	["epsilon"] = [[\epsilon ]],
	["ge"] = [[\varepsilon ]],
	["zeta"] = [[\zeta ]],
	["eta"] = [[\eta ]],
	["theta"] = [[\theta ]],
	["iota"] = [[\iota ]],
	["kappa"] = [[\kappa ]],
	["lambda"] = [[\lambda ]],
	["gl"] = [[\lambda ]],
	["mu"] = [[\mu ]],
	["nu"] = [[\nu ]],
	["xi"] = [[\xi ]],
	["omega"] = [[\omega ]],
	["pi"] = [[\pi ]],
	["rho"] = [[\rho ]],
	["sigma"] = [[\sigma ]],
	["tau"] = [[\tau ]],
	["upsilon"] = [[\upsilon ]],
	["gu"] = [[\upsilon ]],
	["phi"] = [[\phi ]],
	["vphi"] = [[\varphi ]],
	["chi"] = [[\chi ]],
	["psi"] = [[\psi ]],
	-- uppercase greek letters
	["Gamma"] = [[\Gamma ]],
	["Delta"] = [[\Delta ]],
	["Theta"] = [[\Theta ]],
	["Lambda"] = [[\Lambda ]],
	["Xi"] = [[\Xi ]],
	["Omega"] = [[\Omega ]],
	["Pi"] = [[\Pi ]],
	["Sigma"] = [[\Sigma ]],
	["Upsilon"] = [[\Upsilon ]],
	["Phi"] = [[\Phi ]],
	["Chi"] = [[\Chi ]],
	["Psi"] = [[\Psi ]],
	-- set theory
	["bn"] = [[\mathbb{N} ]],
	["bz"] = [[\mathbb{Z} ]],
	["bq"] = [[\mathbb{Q} ]],
	["br"] = [[\mathbb{R} ]],
	["bc"] = [[\mathbb{C} ]],
	["ba"] = [[\mathbb{A} ]],
	["bf"] = [[\mathbb{F} ]],
	["in"] = [[\in ]],
	["nin"] = [[\not\in ]],
	["cup"] = [[\cup ]],
	["cap"] = [[\cap ]],
	["union"] = [[\cup ]],
	["sect"] = [[\cap ]],
	["set"] = [[\{<+++>\} <++>]],
	["pair"] = [[(<+++>, <++>) <++>]],
	-- logic
	["exists"] = [[\exists ]],
	["nexists"] = [[\nexists ]],
	["forall"] = [[\forall ]],
	["implies"] = [[\implies ]],
	["iff"] = [[\iff ]],
	-- relations
	["lt"] = [[< ]],
	["gt"] = [[> ]],
	["gg"] = [[\gg ]],
	["ll"] = [[\ll ]],
	["leq"] = [[\leq ]],
	["geq"] = [[\geq ]],
	["eq"] = [[= ]],
	["aeq"] = [[&= ]],
	["nl"] = [[\nless ]],
	["ng"] = [[\ngtr ]],
	["nleq"] = [[\nleq ]],
	["ngeq"] = [[\ngeq ]],
	["neq"] = [[\neq ]],
	["neg"] = [[\neg ]],
	-- operations
	["plus"] = [[+ ]],
	["min"] = [[- ]],
	["frac"] = [[\frac{<+++>}{<++>} <++>]],
	["recip"] = [[\frac{1}{<+++>} <++>]],
	["dot"] = [[\cdot ]],
	["hada"] = [[\odot ]],
	["exp"] = [[<BS>^{<+++>} <++>]],
	["pow"] = [[<BS>^{<+++>} <++>]],
	["tp"] = [[<BS>^{\\top} ]],
	["sq"] = [[<BS>^2 ]],
	["inv"] = [[<BS>^{-1} ]],
	["cross"] = [[\times ]],
	-- delimiters
	["bpara"] = [[\left( <+++> \right) <++>]],
	["para"] = [[(<+++>) <++>]],
	["bsb"] = [[\left[ <+++> \right] <++>]],
	["sb"] = [[\[<+++>\] <++>]],
	["bbra"] = [[\left\{ <+++> \right\} <++>]],
	["bra"] = [[\{<+++>\} <++>]],
	-- functions
	["to"] = [[\to ]],
	["mapsto"] = [[\mapsto ]],
	["of"] = [[<BS>(<+++>) <++>]],
	["sin"] = [[\sin ]],
	["cos"] = [[\cos ]],
	["tan"] = [[\tan ]],
	["tanh"] = [[\tanh ]],
	["ln"] = [[\ln ]],
	["log"] = [[\log ]],
	["df"] = [[<+++> : <++> \to <++>]],
	["sqrt"] = [[\sqrt{<+++>} <++>]],
	["case"] = [[\begin{cases} <+++> \end{cases} <++>]],
	-- latex commands
	["sub"] = [[<BS>_{<+++>} <++>]],
	["sone"] = [[<BS>_1 ]],
	["stwo"] = [[<BS>_2 ]],
	["sthree"] = [[<BS>_3 ]],
	["sfour"] = [[<BS>_4 ]],
	["text"] = [[\text{<+++>} <++>]],
	-- fancy variables
	["fA"] = [[\mathcal{A} ]],
	["fo"] = [[\mathcal{O} ]],
	["fn"] = [[\mathcal{N} ]],
	["fp"] = [[\mathcal{P} ]],
	["ft"] = [[\mathcal{T} ]],
	["fc"] = [[\mathcal{C} ]],
	["fm"] = [[\mathcal{M} ]],
	["ff"] = [[\mathcal{F} ]],
	["fz"] = [[\mathcal{Z} ]],
	["fi"] = [[\mathcal{I} ]],
	["fb"] = [[\mathcal{B} ]],
	["fl"] = [[\mathcal{L} ]],
	["fv"] = [[\mathcal{V} ]],
	-- encapsulating keywords
	["hat"] = [[Bi\\hat{Els} ]],
	["bar"] = [[Bi\\overline{Els} ]],
	["tild"] = [[Bi\\tilde{Els} ]],
	["vec"] = [[Bi\\vect{Els} ]],
	["comp"] = [[Bi\\underline{Els} ]],
	["adj"] = [[Bi\\adj{Els} ]],
	["star"] = [[<BS>^* ]],
	-- linear algebra
	["matrix"] = [[\begin{bmatrix}<+++>\end{bmatrix}<++>]],
	["vdots"] = [[\vdots & ]],
	["ddots"] = [[\ddots & ]],
	["cdots"] = [[\cdots & ]],
	["ldots"] = [[\ldots ]],
	--constants
	["inf"] = [[\infty ]],
	["e"] = [[\e ]],
	["one"] = [[1 ]],
	["null"] = [[0 ]],
	["zero"] = [[0 ]],
	["two"] = [[2 ]],
	["three"] = [[3 ]],
	["four"] = [[4 ]],
	-- operators
	["int"] = [[\int <+++> \mathop{\dr <++>} <++>]],
	["diff"] = [[\frac{\mathrm{d}}{\mathrm{d} <+++>} <++>]],
	["partial"] = [[\frac{\partial <+++>}{\partial <++>} <++>]],
	["lim"] = [[\lim_{<+++>} <++>]],
	["norm"] = [[\norm{<+++>}_{<++>} <++>]],
	["nabla"] = [[\nabla ]],
	["sum"] = [[\sum ]],
	["prod"] = [[\prod ]],
	["limsup"] = [[\limsup ]],
	["liminf"] = [[\liminf ]],
	["sup"] = [[\sup ]],
	["sinf"] = [[\inf ]],
}
