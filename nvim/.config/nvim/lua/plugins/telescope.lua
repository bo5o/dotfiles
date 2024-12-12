return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "benfowler/telescope-luasnip.nvim" },
      -- project management
      {
        "ahmedkhalf/project.nvim",
        event = "VeryLazy",
        opts = {
          silent_chdir = true,
          scope_chdir = "win",
          patterns = {
            "!^.direnv",
            "!^site-packages",
            "!^node_modules",
            ".git",
            "_darcs",
            ".hg",
            ".bzr",
            ".svn",
            "Makefile",
            "justfile",
            "Justfile",
            "manage.py",
            "pyproject.toml",
            "setup.py",
            "requirements.txt",
            "package.json",
            "Cargo.toml",
          },
        },
        config = function(opts)
          require("project_nvim").setup(opts)
        end,
      },
    },
    cmd = "Telescope",
    keys = {
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
      {
        "<leader>fm",
        "<cmd>Telescope oldfiles<cr>",
        desc = "Find most recently used files",
      },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Find keymaps" },
      {
        "<leader>fs",
        function()
          local builtin = require("telescope.builtin")
          return builtin.lsp_document_symbols() or builtin.treesitter()
        end,
        desc = "Find symbols",
      },
      {
        "<leader>fS",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        desc = "Find workspace symbols",
      },
      {
        "<leader>fc",
        "<cmd>Telescope git_bcommits<cr>",
        desc = "Find git commits (file)",
      },
      {
        "<leader>fC",
        "<cmd>Telescope git_commits<cr>",
        desc = "Find git commits (repo)",
      },
      { "<leader>fg", "<cmd>Telescope git_status<cr>", desc = "Find changed files" },
      { "<leader>fu", "<cmd>Telescope ultisnips<cr>", desc = "Find snippets" },
      {
        "<leader>fl",
        "<cmd>Telescope resume<cr>",
        desc = "Resume last telescope search",
      },
      {
        "<leader>fq",
        "<cmd>Telescope quickfix<cr>",
        desc = "List items in the quickfix list",
      },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
      {
        "<leader>f/",
        "<cmd>Telescope current_buffer_fuzzy_find<cr>",
        desc = "Live fuzzy search inside of the currently open buffer",
      },
      { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find projects" },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local builtin = require("telescope.builtin")
      local previewers = require("telescope.previewers")

      telescope.setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
        defaults = {
          find_command = {
            "rg",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "descending",
          layout_strategy = "horizontal",
          prompt_prefix = "> ",
          layout_config = {
            prompt_position = "bottom",
            horizontal = {
              mirror = false,
              preview_width = 0.6,
            },
          },
          file_ignore_patterns = {},
          winblend = 0,
          scroll_strategy = "cycle",
          border = {},
          borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
          color_devicons = true,
          use_less = true,
          set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
          file_previewer = previewers.vim_buffer_cat.new,
          grep_previewer = previewers.vim_buffer_vimgrep.new,
          qflist_previewer = previewers.vim_buffer_qflist.new,

          -- Developer configurations: Not meant for general override
          buffer_previewer_maker = previewers.buffer_previewer_maker,
          mappings = {
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.smart_send_to_loclist + actions.open_loclist,
              ["<CR>"] = actions.select_default + actions.center,
            },
            n = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            },
          },
        },
      })

      vim.keymap.set("n", "<leader>fr", function()
        builtin.live_grep({
          additional_args = { "--hidden", "--ignore", "--glob=!.git/" },
        })
      end, { silent = true, desc = "Live grep (incl. hidden)" })

      local function find_files()
        local ok =
          pcall(builtin.git_files, { use_git_root = false, show_untracked = true })
        if not ok then
          builtin.find_files()
        end
      end

      vim.keymap.set(
        "n",
        "<leader>ff",
        find_files,
        { silent = true, desc = "Find files" }
      )

      telescope.load_extension("fzf")
      telescope.load_extension("luasnip")
      telescope.load_extension("projects")
    end,
  },
}
