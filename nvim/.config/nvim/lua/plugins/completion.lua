return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind-nvim",
      "lukas-reineke/cmp-under-comparator",
      "hrsh7th/cmp-nvim-lsp",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-cmdline",
      "andersevenrud/cmp-tmux",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_under_comparator = require("cmp-under-comparator")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0
          and vim.api
              .nvim_buf_get_lines(0, line - 1, line, true)[1]
              :sub(col, col)
              :match("%s")
            == nil
      end

      cmp.setup({
        preselect = cmp.PreselectMode.None,

        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
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
          ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          ["<C-e>"] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
          }),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        },

        sources = {
          { name = "nvim_lsp" },
          { name = "treesitter" },
          { name = "luasnip" },
          {
            name = "buffer",
            option = {
              get_bufnrs = function()
                return vim.tbl_filter(function(buf)
                  local byte_size =
                    vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                  return byte_size < 1024 * 1024 -- 1 megabyte max
                end, vim.api.nvim_list_bufs())
              end,
            },
          },
          { name = "path" },
          {
            name = "tmux",
            keyword_length = 3,
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

        ---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = function(entry, vim_item)
            local item = lspkind.cmp_format({
              preset = "codicons",
              symbol_map = {
                String = "",
                Spell = "",
              },
              mode = "symbol_text",
              maxwidth = {
                abbr = 35,
                menu = 35,
              },
              menu = vim.tbl_map(function(s)
                return s .. " "
              end, {
                nvim_lsp = "[lsp]",
                treesitter = "[ts]",
                path = "[path]",
                luasnip = "[snip]",
                buffer = "[buf]",
                tmux = "[tmux]",
              }),
              show_labelDetails = true,
            })(entry, vim_item)

            local kind = vim.split(item.kind, "%s", { trimempty = true })
            local icon, type = kind[1] or "", kind[2] or ""
            item.kind = icon .. "  " .. "(" .. type .. ")"

            local menu = vim.split(item.menu, "%s", { trimempty = true })
            local source, details = menu[1] or "", menu[2] or ""
            if source == "[tmux]" then
              item.menu = source
            else
              item.menu = vim.trim(string.format("%-6s %s", source, details))
            end

            return item
          end,
        },

        window = {
          documentation = cmp.config.window.bordered(),
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
        mapping = cmp.mapping.preset.cmdline(),
        completion = { autocomplete = false },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
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
      local jump = [[:call search('<+.*+>')
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
