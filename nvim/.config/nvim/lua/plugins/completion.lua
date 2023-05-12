return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "onsails/lspkind-nvim" }, -- nice symbols for completion menu
      { "lukas-reineke/cmp-under-comparator" }, -- better sorting of dunder methods
      { "hrsh7th/cmp-nvim-lsp" }, -- lsp completions
      { "hrsh7th/cmp-buffer" }, -- buffer completions
      { "hrsh7th/cmp-path" }, -- file path completions
      { "quangnguyen30192/cmp-nvim-ultisnips" }, -- snippet completions
      { "hrsh7th/cmp-cmdline" }, -- completions on cmdline
      { "andersevenrud/cmp-tmux" }, -- completions from tmux pane content
    },
    config = function()
      local cmp = require("cmp")
      local cmp_under_comparator = require("cmp-under-comparator")
      local lspkind = require("lspkind")

      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },

        mapping = {
          ["<C-n>"] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                vim.api.nvim_feedkeys(t("<Down>"), "n", true)
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end,
          }),

          ["<C-p>"] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                vim.api.nvim_feedkeys(t("<Up>"), "n", true)
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
              else
                fallback()
              end
            end,
          }),

          ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
          ["<CR>"] = cmp.mapping({
            i = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = false,
            }),
            c = function(fallback)
              if cmp.visible() then
                cmp.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = false,
                })
              else
                fallback()
              end
            end,
          }),

          ["<Tab>"] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
              else
                cmp.complete()
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
              elseif vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
              else
                fallback()
              end
            end,
            s = function(fallback)
              if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
                vim.api.nvim_feedkeys(t("<Plug>(ultisnips_jump_forward)"), "m", true)
              else
                fallback()
              end
            end,
          }),

          ["<S-Tab>"] = cmp.mapping({
            c = function()
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
              else
                cmp.complete()
              end
            end,
            i = function(fallback)
              if cmp.visible() then
                cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
              elseif vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                return vim.api.nvim_feedkeys(
                  t("<Plug>(ultisnips_jump_backward)"),
                  "m",
                  true
                )
              else
                fallback()
              end
            end,
            s = function(fallback)
              if vim.fn["UltiSnips#CanJumpBackwards"]() == 1 then
                return vim.api.nvim_feedkeys(
                  t("<Plug>(ultisnips_jump_backward)"),
                  "m",
                  true
                )
              else
                fallback()
              end
            end,
          }),
        },

        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "ultisnips" },
          {
            name = "buffer",
            keyword_length = 4,
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end,
            },
          },
          {
            name = "tmux",
            keyword_length = 5,
            option = {
              all_panes = true,
              trigger_characters = {},
            },
          },
        },

        sorting = {
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp_under_comparator.under,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },

        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            menu = {
              nvim_lsp = "[lsp]",
              path = "[path]",
              ultisnips = "[snip]",
              buffer = "[buf]",
              tmux = "[tmux]",
            },
          }),
        },

        experimental = {
          native_menu = false,
          ghost_text = { hl_group = "Comment" },
        },
      })

      -- Use buffer source for `/`
      cmp.setup.cmdline("/", {
        completion = { autocomplete = false },
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':'
      cmp.setup.cmdline(":", {
        completion = { autocomplete = false },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      local augroup = vim.api.nvim_create_augroup("DadbodSql", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "sql", " mysql", "plsql" },
        callback = function()
          cmp.setup.buffer({
            sources = {
              { name = "vim-dadbod-completion" },
            },
          })
        end,
        group = augroup,
        desc = "Add vim-dadbod-completion in sql files",
      })
    end,
  },

  {
    "SirVer/ultisnips",
    dependencies = {
      {
        "honza/vim-snippets",
        event = "InsertCharPre",
        config = function()
          vim.opt.rtp:append(".")
        end,
      },
    },
    init = function()
      vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
      vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
      vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
      vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
      vim.g.UltiSnipsRemoveSelectModeMappings = 0
      vim.g.ultisnips_python_style = "numpy"
    end,
  },

  {
    "brennier/quicktex",
    event = "InsertCharPre",
    init = function()
      local jump = [[:call search('<+.*+>')
"_c/+>/e
]]
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

      vim.g.quicktex_jinja = {
        [" "] = jump,
        [";;"] = "{{ <+++> }}",
        [";p"] = "{%- <+++> -%}",
        [";b"] = "{%- <+++> -%}<++>{%- end<++> -%}",
        [";set"] = "{%- set <+++> = <++> -%}",
        [";ref"] = "{{ ref('<+++>') }}",
        [";src"] = "{{ source('<+++>') }}",
        [";conf"] = "{{ config(<+++>) }}",
        [";for"] = "{%- for <+++> in <++> -%}<++>{%- endfor -%}",
        [";if"] = "{%- if <+++> -%}<++>{%- endif -%}",
        [";logg"] = "{%- do log(<+++>) -%}",
        [";util"] = "{{ dbt_utils.<+++> }}",
        [";logi"] = "{{ dbt_utils.log_info(<+++>) }}",
        [";logp"] = "{{ dbt_utils.pretty_log_format(<+++>) }}",
        [";get"] = "{%- set <+++> = config.get('<++>') -%}",
        [";require"] = "{%- set <+++> = config.require('<++>') -%}",
        [";run"] = "{% set <+++> = run_query(<++>) %}",
        [";dict"] = "{{ dbt_utils.get_query_results_as_dict(<+++>) }}",
      }

      vim.g.quicktex_python = {
        [" "] = jump,
        -- docstrings
        [";doc"] = '"""<+++>"""',
        [";arg"] = "<+++> : <++>",
        [";tod"] = "# TODO: <+++>",
        [";todo"] = "# TODO: <+++>",
        [";noqa"] = "# noqa: <+++>",
        [";par"] = [[Parameters
----------
]],
        [";params"] = [[Parameters
----------
]],
        [";args"] = [[Parameters
----------
]],
        [";ret"] = [[Returns
-------
]],
        [";rai"] = [[Raises
------
]],
        [";err"] = [[Raises
------
]],
        [";yie"] = [[Yields
------
]],
        [";att"] = [[Attributes
----------
]],
        [";catt"] = [[Class Attributes
----------------
]],
        [";exa"] = [[Examples
--------
]],
        [";not"] = [[Notes
-----
]],
        [";see"] = [[See Also
--------
]],
        [";key"] = [[Keyword
-------
]],
        [";Ref"] = [[References
----------
]],
        [";war"] = [[Warning
-------
]],
        [";oth"] = [[Other
-----
]],
        [";met"] = [[Methods
-------
]],
        [";exp"] = [[Examples
--------
]],
        [";obj"] = ":obj:`<+++>`<++>",
        -- cross referencing
        [";ref"] = ":ref:`<+++>`<++>",
        -- classes and functons
        [";cls"] = [[class <+++>(<++>):
<++>]],
        [";class"] = [[class <+++>(<++>):
<++>]],
        [";dclass"] = [[@dataclasses.dataclass
class <+++>:
<++>]],
        [";defi"] = [[def __init__(self, <+++>):
<++>]],
        [";defc"] = [[@classmethod
def <+++>(cls, <++>):
<++>]],
        [";defs"] = [[@staticmethod
def <+++>(<++>):
<++>]],
        [";def@"] = [[@<+++>
def <++>(<++>):
<++>]],
        [";defm"] = [[def <+++>(self, <++>):
<++>]],
        [";defm@"] = [[@<+++>
def <++>(self, <++>):
<++>]],
        [";defp"] = [[@property
def <+++>(self):
<++>]],
        [";defd"] = [[def __<+++>__(self, <++>):
<++>]],
        [";def"] = [[def <+++>(<++>):
<++>]],
        [";deft"] = [[def test_<+++>(<++>):
<++>]],
        [";adef"] = [[async def <+++>(<++>):
<++>]],
        [";fun"] = [[def <+++>(<++>):
<++>]],
        [";get"] = [[@property
def <+++>(self):
<++>]],
        [";prop"] = [[@property
def <+++>(self):
<++>]],
        [";set"] = [[@<+++>.setter
def <++>(self, value):
<++>]],
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
        ["env"] = [[Bvedi\begin{pa}
<+++>
\end{pa}]],
        ["ol"] = [[\begin{enumerate}
\item <+++>
\end{enumerate}]],
        ["ul"] = [[\begin{itemize}
\item <+++>
\end{itemize}]],
        ["eqn"] = [[\begin{equation*}
<+++>
\end{equation*}
<++>]],
        ["Eqn"] = [[\begin{equation}\label{<+++>}
<++>
\end{equation}
<++>]],
        ["frm"] = [[\begin{frame}
\frametitle{<+++>}
<++>
\end{frame}]],
        -- Other commands
        ["itm"] = "item ",
        ["chap"] = [[\chapter{<+++>}
<++>]],
        ["sec"] = [[\section{<+++>}
<++>]],
        ["ssec"] = [[\subsection{<+++>}
<++>]],
        ["sssec"] = [[\subsubsection{<+++>}
<++>]],
        ["para"] = "(<+++>) <++>",
        ["todo"] = [[\todo{<+++>}
<++>]],
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
        ["matrix"] = [[
\begin{bmatrix}
<+++>
\end{bmatrix}
<++>]],
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
    end,
  },
}