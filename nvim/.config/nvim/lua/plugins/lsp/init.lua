return {
  { "jose-elias-alvarez/typescript.nvim", lazy = true },
  { "mrcjkb/rustaceanvim", version = "^4", ft = { "rust" } },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      { "<leader>cI", "<cmd>LspInfo<cr>", desc = "Lsp info" },
      { "<leader>cS", "<cmd>LspRestart<cr>", desc = "Restart LSP servers" },
    },
    dependencies = {
      "typescript.nvim",
      "mason.nvim",
      "aerial.nvim",
      {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "mason.nvim",
        opts = {
          automatic_installation = false,
        },
      },
      { "ray-x/lsp_signature.nvim" },
      {
        "j-hui/fidget.nvim",
        opts = {
          notification = {
            window = {
              winblend = 10,
              border = "single",
            },
          },
        },
      },
      { "b0o/schemastore.nvim", version = false },
      { "folke/neodev.nvim" },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local lsp = vim.lsp.buf
          local map = function(lhs, rhs, desc, mode)
            local opts = { desc = desc, buffer = args.buf, silent = true }
            vim.keymap.set(mode or "n", lhs, rhs, opts)
          end

          if vim.lsp.inlay_hint then
            map("<leader>ch", function()
              vim.lsp.inlay_hint.enable(args.buf, not vim.lsp.inlay_hint.is_enabled())
            end, "Toggle inlay hints")
          end

          map("gd", "<cmd>Lspsaga goto_definition<cr>", "Go to definition")
          map("<leader>pd", "<cmd>Lspsaga peek_definition<cr>", "Peek definition")
          map("gD", lsp.declaration, "Go to declaration")
          map("K", lsp.hover, "Display hover information")
          map("<leader>k", lsp.signature_help, "Display signature help")
          map("gI", lsp.implementation, "List implementations")
          map("gr", function()
            require("trouble").toggle("lsp_references")
          end, "List all references")
          map("gy", "<cmd>Lspsaga goto_type_definition<cr>", "Go to t[y]pe definition")
          map(
            "<leader>py",
            "<cmd>Lspsaga peek_type_definition<cr>",
            "Peek type definition"
          )
          map("<leader>cr", "<cmd>Lspsaga rename<cr>", "Rename all references")
          map(
            "<leader>ca",
            "<cmd>Lspsaga code_action<cr>",
            "Select code action",
            { "n", "v" }
          )
          map("<leader>cwa", lsp.add_workspace_folder, "Add workspace folder")
          map("<leader>cwr", lsp.remove_workspace_folder, "Remove workspace folder")
          map("<leader>cwl", function()
            print(vim.inspect(lsp.list_workspace_folders()))
          end, "List workspace folders")
        end,
      })

      local diagnostic = vim.diagnostic
      diagnostic.config({
        virtual_text = {
          source = "always",
        },
        float = {
          border = "rounded",
          source = "always",
        },
      })

      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
      end
      map("[d", diagnostic.goto_prev, "Go to previous diagnostic")
      map("]d", diagnostic.goto_next, "Go to next diagnostic")
      map("<leader><space>l", diagnostic.setloclist, "Add diagnostics to location list")
      map("<leader><space>d", diagnostic.open_float, "Show diagnostics")

      ---@diagnostic disable-next-line: unused-local
      local on_attach = function(client, bufnr)
        -- Configure signature help for completion
        require("lsp_signature").on_attach({
          bind = true,
          hint_enable = false,
          hi_parameter = "Search",
        })
      end

      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      local lspconfig = require("lspconfig")
      lspconfig.util.default_config =
        vim.tbl_extend("force", lspconfig.util.default_config, {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 300,
          },
        })

      require("plugins.lsp.python").setup()
      require("plugins.lsp.lua").setup()
      require("plugins.lsp.rust").setup(on_attach)
      require("plugins.lsp.json").setup()
      require("plugins.lsp.yaml").setup()
      require("plugins.lsp.toml").setup()
      require("plugins.lsp.docker").setup()
      require("plugins.lsp.xml").setup()
      require("plugins.lsp.vue").setup(on_attach)
      require("plugins.lsp.typescript").setup(on_attach, capabilities)
      require("plugins.lsp.eslint").setup()
      require("plugins.lsp.php").setup()
      require("plugins.lsp.markdown").setup()
      require("plugins.lsp.sh").setup()

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })

      vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, {
          border = "rounded",
        })

      for type, icon in pairs({
        Error = "󰅚 ",
        Warn = "󰀪 ",
        Hint = "󰌶 ",
        Info = " ",
      }) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      require("fidget").setup({})
    end,
  },

  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
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
          code_action = " ",
        },
      })
    end,
  },

  {
    "mfussenegger/nvim-lint",
    config = function()
      require("lint").linters_by_ft = {
        sql = { "sqlfluff" },
        ["sql.jinja"] = { "sqlfluff" },
        ["html.jinja"] = { "djlint" },
        ["jinja"] = { "djlint" },
        gitcommit = { "gitlint" },
        yaml = { "yamllint" },
        markdown = { "markdownlint" },
        vimwiki = { "markdownlint" },
        dockerfile = { "hadolint" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    config = function()
      local slow_format_filetypes = {}

      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          sql = { { "sqlfluff", "sqlfmt", "sql_formatter" } },
          ["sql.jinja"] = { { "sqlfluff", "sqlfmt" } },
          ["html.jinja"] = { "djlint" },
          htmldjango = { "djlint" },
          html = { "djlint" },
          jinja = { "djlint" },
          markdown = { "mdformat" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          just = { "just" },
          ["_"] = { "trim_whitespace" },
        },
        format_on_save = function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          if slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end

          local function on_format(err)
            if err and err:match("timeout$") then
              slow_format_filetypes[vim.bo[bufnr].filetype] = true
            end
          end

          return { timeout_ms = 500, lsp_fallback = true }, on_format
        end,
        format_after_save = function(bufnr)
          if not slow_format_filetypes[vim.bo[bufnr].filetype] then
            return
          end
          return { lsp_fallback = true }
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
        require("conform").format({ async = true, lsp_fallback = true, range = range })
      end, {
        desc = "Format buffer",
        range = true,
      })
    end,
  },

  {
    "williamboman/mason.nvim",
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
    },
  },
}
