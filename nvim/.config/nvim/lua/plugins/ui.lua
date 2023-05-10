return {
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      require("dressing").setup({
        input = {
          enabled = true,
          prompt_align = "left",
          border = "rounded",
        },
        select = {
          enabled = true,
          backend = { "telescope" },
          telescope = require("telescope.themes").get_cursor({}),
        },
      })
    end,
  },

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
            { "diff", colored = false },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              colored = false,
            },
          },
          lualine_c = { "filename" },
          lualine_x = { "encoding", "fileformat", "filetype" },
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
              text = "File Explorer",
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
              local seve = vim.diagnostic.severity
              local error = #vim.diagnostic.get(0, { severity = seve.ERROR })
              local warning = #vim.diagnostic.get(0, { severity = seve.WARN })
              local info = #vim.diagnostic.get(0, { severity = seve.INFO })
              local hint = #vim.diagnostic.get(0, { severity = seve.HINT })

              if error ~= 0 then
                table.insert(result, { text = "  " .. error, fg = "#EC5241" })
              end

              if warning ~= 0 then
                table.insert(result, { text = "  " .. warning, fg = "#EFB839" })
              end

              if hint ~= 0 then
                table.insert(result, { text = "  " .. hint, fg = "#A3BA5E" })
              end

              if info ~= 0 then
                table.insert(result, { text = "  " .. info, fg = "#7EA9A7" })
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
}
