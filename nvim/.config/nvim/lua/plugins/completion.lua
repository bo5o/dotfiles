return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "L3MON4D3/LuaSnip",
      "mgalliou/blink-cmp-tmux",
    },

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "none",

        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<CR>"] = { "accept", "fallback" },

        ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

        ["<C-s>"] = { "show_signature", "hide_signature", "fallback" },
        ["<C-f>"] = { "scroll_signature_down", "scroll_documentation_down", "fallback" },
        ["<C-b>"] = { "scroll_signature_up", "scroll_documentation_up", "fallback" },
      },

      appearance = {
        nerd_font_variant = "normal",
      },

      completion = {
        keyword = { range = "full" },

        list = {
          selection = { preselect = false, auto_insert = true },
        },

        menu = {
          border = "rounded",
          winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None,PmenuKind:BlinkCmpMenu,PmenuExtra:BlinkCmpMenu",
          draw = {
            treesitter = { "lsp" },
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_icon" },
            },
            components = {
              source_icon = {
                ellipsis = false,
                text = function(ctx)
                  local icons = {
                    lsp = "",
                    path = "",
                    snippets = "󰩫",
                    buffer = "",
                    tmux = "",
                    dadbod = "󰆼",
                  }
                  return icons[ctx.source_id] or ctx.source_id
                end,
                highlight = "BlinkCmpSource",
              },
            },
          },
        },

        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = { border = "rounded" },
        },

        ghost_text = { enabled = true },
      },

      snippets = { preset = "luasnip" },

      sources = {
        default = { "lsp", "path", "snippets", "buffer", "tmux" },

        per_filetype = {
          sql = { "dadbod", "buffer" },
          mysql = { "dadbod", "buffer" },
          plsql = { "dadbod", "buffer" },
        },

        providers = {
          lsp = {
            fallbacks = {},
          },
          buffer = {
            opts = {
              get_bufnrs = function()
                return vim.tbl_filter(function(buf)
                  local byte_size =
                    vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                  return byte_size < 1024 * 1024 -- 1 megabyte max
                end, vim.api.nvim_list_bufs())
              end,
            },
          },
          tmux = {
            module = "blink-cmp-tmux",
            name = "tmux",
            score_offset = -3,
            opts = {
              panes = "all",
            },
          },
          dadbod = {
            module = "vim_dadbod_completion.blink",
            name = "Dadbod",
          },
        },
      },

      cmdline = {
        keymap = {
          preset = "cmdline",
          ["<C-n>"] = { "fallback" },
          ["<C-p>"] = { "fallback" },
        },
        completion = {
          menu = { auto_show = false },
          ghost_text = { enabled = true },
        },
      },

      signature = {
        enabled = true,
        window = {
          show_documentation = true,
          border = "rounded",
        },
      },

      fuzzy = {
        implementation = "prefer_rust",
        sorts = { "exact", "score", "sort_text" },
      },
    },
    opts_extend = { "sources.default" },
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_lua").lazy_load({ paths = "./snippets" })

      local ls = require("luasnip")

      ls.config.setup({
        keep_roots = true,
        link_roots = true,
        link_children = true,
        update_events = "TextChanged,TextChangedI",
        delete_check_events = "TextChanged",
        enable_autosnippets = true,
      })

      ls.filetype_extend("python", { "django" })
      ls.filetype_extend("python", { "django-rest" })
      ls.filetype_extend("djangohtml", { "djangohtml" })
      ls.filetype_extend("vue", { "vue" })
    end,
  },

  {
    "brennier/quicktex",
    event = "InsertCharPre",
    init = function()
      local jump = [[:call search('<+.*+>')
"_c/+>/e
]]
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
        ["env"] = [[Bvedi\begin{pa}
<+++>
\end{pa}]],
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
        ["cmd"] = [[Bi\Ea{<+++>}<++>]],
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
        ["hat"] = [[Bi\\hat{Els} ]],
        ["bar"] = [[Bi\\overline{Els} ]],
        ["tild"] = [[Bi\\tilde{Els} ]],
        ["vec"] = [[Bi\\vect{Els} ]],
        ["comp"] = [[Bi\\underline{Els} ]],
        ["adj"] = [[Bi\\adj{Els} ]],
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
