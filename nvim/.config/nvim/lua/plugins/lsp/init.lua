return {
  { "jose-elias-alvarez/typescript.nvim", lazy = true },
  { "mrcjkb/rustaceanvim", version = "^4", ft = { "rust" } },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {},
  },

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
      { "b0o/schemastore.nvim", version = false },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(args)
          local map = function(lhs, rhs, desc, mode)
            local opts = { desc = desc, buffer = args.buf, silent = true }
            vim.keymap.set(mode or "n", lhs, rhs, opts)
          end

          map("<leader>hi", function()
            vim.lsp.inlay_hint.enable(
              not vim.lsp.inlay_hint.is_enabled({ bufnr = args.buf }),
              { bufnr = args.buf }
            )
          end, "Toggle inlay hints")

          map("gd", "<cmd>Lspsaga goto_definition<cr>", "Go to definition")
          map("<leader>pd", "<cmd>Lspsaga peek_definition<cr>", "Peek definition")
          map("gD", vim.lsp.buf.declaration, "Go to declaration")
          map("<c-s>", vim.lsp.buf.signature_help, "Display signature help", { "i" })
          map("gI", vim.lsp.buf.implementation, "List implementations")
          map("gr", "<cmd>TroubleToggle lsp_references<cr>", "List all references")
          map("gy", "<cmd>Lspsaga goto_type_definition<cr>", "Go to t[y]pe definition")
          map(
            "<leader>py",
            "<cmd>Lspsaga peek_type_definition<cr>",
            "Peek type definition"
          )
          map("crn", "<cmd>Lspsaga rename<cr>", "Rename all references")
          map("crr", "<cmd>Lspsaga code_action<cr>", "Select code action")
          map(
            "<c-r><c-r>",
            "<cmd>Lspsaga code_action<cr>",
            "Select code action",
            { "v" }
          )
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
        end,
      })

      local diagnostic = vim.diagnostic
      diagnostic.config({
        virtual_text = {
          source = true,
        },
        float = {
          border = "rounded",
          source = true,
        },
      })

      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc, silent = true })
      end
      map("<leader><space>l", diagnostic.setloclist, "Add diagnostics to location list")

      local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
      )

      local lspconfig = require("lspconfig")
      lspconfig.util.default_config =
        vim.tbl_extend("force", lspconfig.util.default_config, {
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 300,
          },
        })

      require("plugins.lsp.python").setup()
      require("plugins.lsp.lua").setup()
      require("plugins.lsp.rust").setup()
      require("plugins.lsp.json").setup()
      require("plugins.lsp.yaml").setup()
      require("plugins.lsp.toml").setup()
      require("plugins.lsp.docker").setup()
      require("plugins.lsp.xml").setup()
      require("plugins.lsp.vue").setup()
      require("plugins.lsp.typescript").setup(capabilities)
      require("plugins.lsp.eslint").setup()
      require("plugins.lsp.php").setup()
      require("plugins.lsp.markdown").setup()
      require("plugins.lsp.sh").setup()

      for type, icon in pairs({
        Error = "󰅚 ",
        Warn = "󰀪 ",
        Hint = "󰌶 ",
        Info = " ",
      }) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
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
          python = function(bufnr)
            if
              require("conform").get_formatter_info("ruff_format", bufnr).available
            then
              return { "ruff_organize_imports", "ruff_format" }
            else
              return { "isort", "black" }
            end
          end,
          html = { "djlint" },
          jinja = { "djlint" },
          markdown = { "mdformat" },
          sh = { "shfmt" },
          bash = { "shfmt" },
          just = { "just" },
          css = { "prettierd" },
          toml = { "taplo" },
          ["*"] = { "injected" },
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
