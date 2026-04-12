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
            "lsp_status",
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
    "echasnovski/mini.notify",
    version = false,
    event = "VeryLazy",
    keys = {
      {
        "<leader>nh",
        function()
          require("mini.notify").show_history()
        end,
        desc = "Notification history",
      },
    },
    opts = {
      lsp_progress = {
        enable = true,
        duration_last = 5000,
      },
      window = {
        config = function()
          local has_statusline = vim.o.laststatus > 0
          local pad = vim.o.cmdheight + (has_statusline and 1 or 0)
          return {
            anchor = "SE",
            col = vim.o.columns - 2,
            row = vim.o.lines - pad,
            border = "none",
            title = "",
          }
        end,
        winblend = 25,
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
