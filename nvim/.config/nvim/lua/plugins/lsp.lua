return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6",
    ft = { "rust" },
    init = function()
      vim.g.rustaceanvim = {
        -- Plugin configuration
        tools = {},
        -- LSP configuration
        server = {
          settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
                extraArgs = { "--no-deps" },
              },
            },
          },
        },
      }
    end,
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    dependencies = {
      "justinsgithub/wezterm-types",
    },
    opts = {
      library = {
        { path = "wezterm-types", mods = { "wezterm" } },
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "b0o/schemastore.nvim", version = false },
      { "Davidyz/inlayhint-filler.nvim" },
      { "antosha417/nvim-lsp-file-operations", opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local map = function(lhs, rhs, desc, mode)
            local opts = { desc = desc, buffer = args.buf, silent = true }
            vim.keymap.set(mode or "n", lhs, rhs, opts)
          end

          local client = vim.lsp.get_client_by_id(args.data.client_id) --[[@as vim.lsp.Client]]

          map("<leader>hi", function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }),
              { bufnr = args.buf }
            )
          end, "Toggle inlay hints")

          local goto_definition

          -- use vtsls special goto definition if it is active for given buffer
          if #vim.lsp.get_clients({ name = "vtsls", bufnr = args.buf }) == 1 then
            goto_definition = function()
              local params =
                vim.lsp.util.make_position_params(0, client.offset_encoding)
              require("trouble").open({
                mode = "lsp_command",
                params = {
                  command = "typescript.goToSourceDefinition",
                  arguments = { params.textDocument.uri, params.position },
                },
              })
            end
          else
            goto_definition = "<cmd>Lspsaga goto_definition<cr>"
          end

          map("K", "<cmd>Lspsaga hover_doc<cr>", "Hover")
          map("gd", goto_definition, "Go to definition")
          map("gp", "<cmd>Lspsaga peek_definition<cr>", "Peek definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map(
            "gI",
            "<cmd>Trouble lsp_implementations auto_refresh=false<cr>",
            "List implementations"
          )
          map("gr", function()
            require("trouble").toggle({ mode = "lsp_references", auto_refresh = false })
          end, "Show references")
          map("gY", "<cmd>Lspsaga goto_type_definition<cr>", "Go to t[y]pe definition")
          map("gy", "<cmd>Lspsaga peek_type_definition<cr>", "Peek type definition")
          map("crn", "<cmd>Lspsaga rename<cr>", "Rename all references")
          map("crr", "<cmd>Lspsaga code_action<cr>", "Select code action")
          map("cri", function()
            require("inlayhint-filler").fill()
          end, "Insert inlay-hint under cursor")
          map("<c-r>r", "<cmd>Lspsaga code_action<cr>", "Select code action", { "v" })
          map("<leader>cwa", vim.lsp.buf.add_workspace_folder, "Add workspace folder")
          map(
            "<leader>cwr",
            vim.lsp.buf.remove_workspace_folder,
            "Remove workspace folder"
          )
          map("<leader>cwl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, "List workspace folders")
          map("<leader>cS", "<cmd>LspRestart<cr>", "Restart LSP servers")
        end,
      })

      local eslint_on_attach = vim.lsp.config.eslint.on_attach

      ---@type { [string]: vim.lsp.Config }
      local servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              analysis = {
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        bashls = {},
        biome = {},
        cssls = {
          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = true,
                },
              },
            },
          },
        },
        dockerls = {},
        docker_compose_language_service = {},
        eslint = {
          on_attach = function(client, bufnr)
            if eslint_on_attach ~= nil then
              eslint_on_attach(client, bufnr)
            end
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "LspEslintFixAll",
            })
          end,
          workspace_required = true,
        },
        html = {
          capabilities = {
            textDocument = {
              completion = {
                completionItem = {
                  snippetSupport = true,
                },
              },
            },
          },
        },
        intelephense = {},
        jsonls = {},
        just = {},
        lemminx = {
          init_options = {
            settings = {
              xml = {
                format = {
                  splitAttributes = true,
                },
              },
            },
          },
        },
        lua_ls = {
          on_init = function(client)
            if client.workspace_folders then
              local path = client.workspace_folders[1].name
              if
                path ~= vim.fn.stdpath("config")
                and (
                  vim.uv.fs_stat(path .. "/.luarc.json")
                  or vim.uv.fs_stat(path .. "/.luarc.jsonc")
                )
              then
                return
              end
            end

            client.config.settings.Lua =
              vim.tbl_deep_extend("force", client.config.settings.Lua, {
                runtime = {
                  version = "LuaJIT",
                },
                workspace = {
                  checkThirdParty = false,
                  ignoreDir = { "undodir/**/*.lua" },
                  library = {
                    vim.env.VIMRUNTIME,
                  },
                },
                telemetry = { enable = false },
              })
          end,
          settings = {
            Lua = {},
          },
        },
        marksman = {},
        ocamllsp = {},
        postgres_lsp = {
          workspace_required = true,
        },
        pylsp = {
          -- expose mypy through pylsp
          settings = {
            pylsp = {
              plugins = {
                -- enable mypy daemon
                mypy = {
                  enabled = true,
                  dmypy = true,
                  strict = true,
                  report_progress = true,
                },

                -- disable all other plugins
                jedi_completion = { enabled = false },
                jedi_definition = { enabled = false },
                jedi_type_definition = { enabled = false },
                jedi_hover = { enabled = false },
                jedi_references = { enabled = false },
                jedi_signature_help = { enabled = false },
                jedi_symbols = { enabled = false },
                signature = { formatter = "ruff" },
                autopep8 = { enabled = false },
                flake8 = { enabled = false },
                mccabe = { enabled = false },
                preload = { enabled = false },
                pycodestyle = { enabled = false },
                pydocstyle = { enabled = false },
                pyflakes = { enabled = false },
                pylint = { enabled = false },
                rope_autoimport = { enabled = false },
                rope_completion = { enabled = false },
                yapf = { enabled = false },
              },
            },
          },
          on_attach = function(client)
            -- stop server if mypy is not available in the current virtual environment
            local mypy_available = vim.env.VIRTUAL_ENV
              and vim.uv.fs_stat(vim.fs.joinpath(vim.env.VIRTUAL_ENV, "bin", "mypy"))
            if not mypy_available then
              client:stop()
            end
          end,
        },
        ruff = {
          on_attach = function(client)
            -- disable hover in favor of pyright
            client.server_capabilities.hoverProvider = false
          end,
          capabilities = {
            general = {
              positionEncodings = { "utf-16" },
            },
          },
        },
        sqruff = {
          root_markers = { ".sqruff" },
          workspace_required = true,
        },
        tinymist = {
          settings = {
            formatterMode = "typstyle",
          },
        },
        taplo = {},
        ts_query_ls = {
          settings = {
            parser_install_directories = {
              vim.fs.joinpath(vim.fn.stdpath("data"), "/lazy/nvim-treesitter/parser/"),
            },
            language_retrieval_patterns = {
              "languages/src/([^/]+)/[^/]+\\.scm$",
            },
          },
        },
        vimls = {},
        vue_ls = {
          init_options = {
            vue = {
              hybridMode = true,
            },
          },
        },
        vtsls = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
              tsserver = {
                globalPlugins = {},
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
          before_init = function(params, config)
            local lib_path = vim.fs.find(
              "node_modules/@vue/language-server",
              { path = params.workspaceFolders[1].name, upward = true }
            )[1]
            if lib_path then
              table.insert(config.settings.vtsls.tsserver.globalPlugins, {
                name = "@vue/typescript-plugin",
                location = lib_path,
                languages = { "vue" },
                configNamespace = "typescript",
                enableForWorkspaceTypeScriptVersions = true,
              })
            end
          end,
          on_attach = function(client, bufnr)
            vim.api.nvim_buf_create_user_command(
              0,
              "LspTypescriptCodeAction",
              function()
                local code_actions =
                  client.server_capabilities.codeActionProvider.codeActionKinds
                require("lspsaga.codeaction"):code_action({
                  context = { only = code_actions },
                })
              end,
              {}
            )

            vim.keymap.set("n", "cro", function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.organizeImports" },
                  diagnostics = {},
                },
              })
            end, { desc = "Organize imports", buffer = bufnr, silent = true })
          end,
        },
        yamlls = {
          settings = {
            redhat = {
              telemetry = {
                enabled = false,
              },
            },
            yaml = {
              hover = true,
              completion = true,
              validate = true,
              schemaStore = {
                enable = false,
                url = "",
              },
              customTags = { "!reset sequence", "!override sequence" },
              schemas = require("schemastore").yaml.schemas(),
              format = {
                enable = false,
              },
            },
          },
        },
      }

      vim.lsp.config("*", {
        capabilities = vim.tbl_deep_extend(
          "error",
          require("cmp_nvim_lsp").default_capabilities(),
          require("lsp-file-operations").default_capabilities()
        ),
        flags = {
          debounce_text_changes = 300,
        },
      })

      for server, settings in pairs(servers) do
        vim.lsp.config(server, settings)
        vim.lsp.enable(server)
      end
    end,
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "powerline",
        options = {
          multiple_diag_under_cursor = true,
          multilines = false,
          format = function(diagnostic)
            local text = diagnostic.message
            if diagnostic.code ~= nil then
              text = text .. " (" .. diagnostic.code .. ")"
            end
            if diagnostic.source ~= nil then
              text = text .. " [" .. diagnostic.source .. "]"
            end
            return text
          end,
        },
      })
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    opts = {
      symbols_in_winbar = {
        enable = true,
      },
      lightbulb = {
        enable = true,
        sign = false,
        virtual_text = true,
      },
      implement = {
        enable = true,
      },
      ui = {
        code_action = "🗲",
        title = false,
      },
      definition = {
        keys = {
          edit = "<c-w>e",
          vsplit = "<c-w>v",
          split = "<c-w>s",
          close = "<c-w>q",
        },
      },
      finder = {
        keys = {
          toggle_or_open = "<cr>",
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        ["html.jinja"] = { "djlint" },
        ["jinja"] = { "djlint" },
        gitcommit = { "gitlint" },
        yaml = { "yamllint" },
        markdown = { "markdownlint" },
        vimwiki = { "markdownlint" },
        dockerfile = { "hadolint" },
        html = { "htmlhint" },
        css = { "stylelint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          local lint = require("lint")
          lint.try_lint()
          -- run sqlfluff only if config file exists
          if
            vim.startswith(vim.bo.filetype, "sql")
            and vim.fs.root(0, ".sqlfluff") ~= nil
          then
            lint.try_lint("sqlfluff")
          end
        end,
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    enabled = true,
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "crf",
        function()
          require("conform").format({ async = true })
        end,
        mode = "n",
        desc = "Format buffer",
      },
    },
    config = function()
      require("conform").setup({
        default_format_opts = {
          lsp_format = "fallback",
        },
        formatters_by_ft = {
          lua = { "stylua" },
          sql = function()
            if vim.fs.root(0, ".sqlfluff") ~= nil then
              return { "sqlfluff", lsp_format = "prefer" }
            else
              return { "sql_formatter", lsp_format = "prefer" }
            end
          end,
          ["sql.jinja"] = function()
            if vim.fs.root(0, ".sqlfluff") ~= nil then
              return { "sqlfluff", lsp_format = "prefer" }
            else
              return { lsp_format = "prefer" }
            end
          end,
          ["html.jinja"] = { "djlint" },
          htmldjango = { "djlint" },
          javascript = { "biome", "prettierd", lsp_format = "fallback" },
          typescript = { "biome", "prettierd", lsp_format = "fallback" },
          python = function(bufnr)
            if
              require("conform").get_formatter_info("ruff_format", bufnr).available
            then
              return { "ruff_organize_imports", "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          html = { "prettierd", "djlint", stop_after_first = true },
          jinja = { "djlint" },
          json = { "biome" },
          markdown = { "mdformat", "injected" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          just = { "just" },
          css = { "prettierd" },
          yaml = { "yamlfmt" },
          toml = { "taplo" },
          ocaml = { "ocamlformat" },
          query = { lsp_format = "prefer" },
          caddy = { "caddyfmt" },
          vue = { "prettierd" },
          ["_"] = { "trim_whitespace" },
        },
        formatters = {
          caddyfmt = {
            command = "caddy",
            args = { "fmt", "-" },
            stdin = true,
          },
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          local bufname = vim.api.nvim_buf_get_name(bufnr)
          if bufname:match("/node_modules/") then
            return
          end

          return { timeout_ms = 500, lsp_format = "fallback" }
        end,
        format_after_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          local slow_format_filetypes = {}
          if not slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end

          return { lsp_format = "fallback" }
        end,
      })
    end,
    init = function()
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })

      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })

      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line =
            vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, range = range })
      end, { desc = "Format buffer", range = true })

      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
    end,
  },

  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    cmd = "Mason",
    keys = {
      { "<leader>ol", "<cmd>Mason<cr>", desc = "Open Mason installer" },
    },
    opts = {
      ui = {
        height = 0.7,
        border = "rounded",
      },
    },
  },

  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter" },
    keys = {
      { "<leader>os", "<cmd>AerialToggle right<cr>", desc = "Toggle symbol tree" },
      { "<leader>on", "<cmd>AerialNavToggle<cr>", desc = "Toggle symbol navigator" },
      { "gO", "<cmd>AerialToggle right<cr>", desc = "Toggle symbol tree" },
    },
    opts = {
      backends = { "lsp", "treesitter", "markdown", "man" },
      filter_kind = {
        ["_"] = false,
        python = {
          -- "Array",
          -- "Boolean",
          "Class",
          -- "Constant",
          "Constructor",
          "Enum",
          "EnumMember",
          -- "Event",
          -- "Field",
          -- "File",
          "Function",
          "Interface",
          -- "Key",
          "Method",
          "Module",
          -- "Namespace",
          -- "Null",
          -- "Number",
          -- "Object",
          -- "Operator",
          -- "Package",
          "Property",
          -- "String",
          "Struct",
          -- "TypeParameter",
          -- "Variable",
        },
      },
      ignore = {
        filetypes = {
          "startify",
        },
      },
      show_guides = true,
    },
  },
}
