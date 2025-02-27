return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "gruvbox-material",
          component_separators = "",
          section_separators = "",
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            { "diff", colored = true },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              colored = true,
              symbols = { error = "● ", warn = "● ", info = "● ", hint = "⦿ " },
            },
          },
          lualine_c = { "filename" },
          lualine_x = {
            "encoding",
            "fileformat",
            {
              "filetype",
              colored = false,
              icon = { align = "right" },
            },
          },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        extensions = {},
      })
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      -- "rcarriga/nvim-notify",
    },
    keys = {
      {
        "<leader>nh",
        "<cmd>Noice history<cr>",
        desc = "Notification history",
      },
      {
        "<c-f>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end,
        mode = { "n", "i", "s" },
        desc = "Scroll hover down",
        silent = true,
        expr = true,
      },
      {
        "<c-b>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end,
        mode = { "n", "i", "s" },
        desc = "Scroll hover up",
        silent = true,
        expr = true,
      },
    },
    opts = {
      cmdline = {
        enabled = false,
      },
      messages = {
        enabled = false,
      },
      popupmenu = {
        enabled = false,
      },
      notify = {
        enabled = false,
      },
      lsp = {
        hover = {
          enabled = false,
        },
        signature = {
          enabled = false,
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          ["vim.lsp.util.stylize_markdown"] = false,
          ["cmp.entry.get_documentation"] = false,
        },
      },
      presets = {
        lsp_doc_border = true,
      },
      views = {
        mini = {
          position = {
            row = -2,
          },
        },
      },
    },
  },

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("bufferline").setup({
        options = {
          always_show_bufferline = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "Files",
              text_align = "center",
            },
            {
              filetype = "aerial",
              text = "Symbols",
              text_align = "center",
            },
          },
          custom_areas = {
            right = function()
              local result = {}
              local severity = vim.diagnostic.severity
              local error = #vim.diagnostic.get(0, { severity = severity.ERROR })
              local warning = #vim.diagnostic.get(0, { severity = severity.WARN })
              local info = #vim.diagnostic.get(0, { severity = severity.INFO })
              local hint = #vim.diagnostic.get(0, { severity = severity.HINT })

              if error ~= 0 then
                table.insert(
                  result,
                  { text = " ● " .. error, link = "DiagnosticError" }
                )
              end

              if warning ~= 0 then
                table.insert(
                  result,
                  { text = " ● " .. warning, link = "DiagnosticWarn" }
                )
              end

              if hint ~= 0 then
                table.insert(
                  result,
                  { text = " ⦿ " .. hint, link = "DiagnosticHint" }
                )
              end

              if info ~= 0 then
                table.insert(
                  result,
                  { text = " ● " .. info, link = "DiagnosticInfo" }
                )
              end
              return result
            end,
          },
        },
        highlights = {
          fill = {
            bg = "#32302f",
          },
        },
      })
    end,
  },

  {
    "dstein64/nvim-scrollview",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("scrollview").setup({
        excluded_filetypes = {
          "NvimTree",
          "aerial",
          "mason",
          "floaterm",
        },
        signs_on_startup = { "cursor", "search" },
        current_only = true,
        column = 1,
        signs_column = 0,
      })
    end,
  },
}
