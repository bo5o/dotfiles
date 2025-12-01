return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs_staged_enable = false,
      numhl = false,
      current_line_blame_opts = {
        virt_text_pos = "eol",
        delay = 300,
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        -- Mappings
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Next hunk
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, { desc = "Next hunk" })

        -- Previous hunk
        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, { desc = "Previous hunk" })

        -- Stage hunk
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk" })
        map("v", "<leader>hs", function()
          gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage hunk" })

        -- Reset hunk
        map("n", "<leader>hu", gitsigns.reset_hunk, { desc = "Reset hunk" })
        map("v", "<leader>hu", function()
          gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset hunk" })

        -- Preview hunk
        map(
          "n",
          "<leader>hp",
          gitsigns.preview_hunk_inline,
          { desc = "Preview hunk (inline)" }
        )
        map("n", "<leader>hP", gitsigns.preview_hunk, { desc = "Preview hunk" })

        -- Toggle line-wise git blame
        map(
          "n",
          "<leader>gb",
          gitsigns.toggle_current_line_blame,
          { desc = "Toggle line-wise git blame" }
        )

        -- Text object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },

  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gwrite", "Gedit", "Gdiffsplit", "Gvdiffsplit", "Gvsplit" },
    keys = {
      { "<leader>gco", "<cmd>Git checkout<cr>", desc = "Checkout" },
      { "<leader>gcc", "<cmd>Git commit -v -q<cr>", desc = "Commit" },
      { "<leader>gca", "<cmd>Git absorb<cr>", desc = "Absorb" },
      { "<leader>gcm", "<cmd>Git commit --amend<cr>", desc = "Amend" },
      { "<leader>gw", "<cmd>Gwrite<cr>", desc = "Stage" },
      { "<leader>gB", "<cmd>Git blame<cr>", desc = "Blame" },
      { "<leader>ge", "<cmd>Gedit<cr>", desc = "Edit" },
      { "<leader>gp", "<cmd>Git pull<cr>", desc = "Pull" },
      { "<leader>gP", "<cmd>Git push<cr>", desc = "Push" },
      { "<leader>gs", "<cmd>Git<cr>", desc = "Status" },
      { "<leader>g<space>", ":Git<space>", desc = "Enter git command", silent = false },
    },
  },

  -- Github integration
  { "tpope/vim-rhubarb", cmd = { "GBrowse" }, dependencies = "vim-fugitive" },

  -- Bitbucket integration
  { "tommcdo/vim-fubitive", cmd = { "GBrowse" }, dependencies = "vim-fugitive" },

  -- Show git commit under cursor
  {
    "rhysd/git-messenger.vim",
    cmd = "GitMessenger",
    keys = {
      { "<leader>gm", desc = "Line history" },
    },
    config = function()
      vim.api.nvim_set_hl(
        0,
        "gitmessengerPopupNormal",
        { term = nil, fg = "#ebdbb2", bg = "#32302f", ctermfg = nil, ctermbg = nil }
      )
    end,
  },

  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      {
        "<leader>gl",
        function()
          if next(require("diffview.lib").views) == nil then
            vim.cmd("DiffviewFileHistory --follow %")
          else
            vim.cmd("DiffviewClose")
          end
        end,
        desc = "File history",
        mode = { "n", "v" },
      },
      {
        "<leader>gL",
        ":DiffviewFileHistory --follow<space>",
        desc = "File history (with options)",
        silent = false,
      },
      {
        "<leader>gd",
        function()
          if next(require("diffview.lib").views) == nil then
            vim.cmd("DiffviewOpen")
          else
            vim.cmd("DiffviewClose")
          end
        end,
        desc = "Diff",
      },
      {
        "<leader>gD",
        ":DiffviewOpen<space>",
        desc = "Diff (with options)",
        silent = false,
      },
    },
    opts = {
      diff_binaries = false, -- Show diffs for binaries
      enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
      git_cmd = { "git" }, -- The git executable followed by default args.
      use_icons = true, -- Requires nvim-web-devicons
      show_help_hints = true, -- Show hints for how to open the help panel
      watch_index = true, -- Update views and index buffers when the git index changes.
      icons = { -- Only applies when use_icons is true.
        folder_closed = "",
        folder_open = "",
      },
      signs = {
        fold_closed = "",
        fold_open = "",
        done = "✓",
      },
      view = {
        -- Configure the layout and behavior of different types of views.
        -- Available layouts:
        --  'diff1_plain'
        --    |'diff2_horizontal'
        --    |'diff2_vertical'
        --    |'diff3_horizontal'
        --    |'diff3_vertical'
        --    |'diff3_mixed'
        --    |'diff4_mixed'
        -- For more info, see |diffview-config-view.x.layout|.
        default = {
          -- Config for changed files, and staged files in diff views.
          layout = "diff2_horizontal",
          winbar_info = false, -- See |diffview-config-view.x.winbar_info|
        },
        merge_tool = {
          -- Config for conflicted files in diff views during a merge or rebase.
          layout = "diff4_mixed",
          disable_diagnostics = true, -- Temporarily disable diagnostics for conflict buffers while in the view.
          winbar_info = true, -- See |diffview-config-view.x.winbar_info|
        },
        file_history = {
          -- Config for changed files in file history views.
          layout = "diff2_horizontal",
          winbar_info = false, -- See |diffview-config-view.x.winbar_info|
        },
      },
      file_panel = {
        listing_style = "tree", -- One of 'list' or 'tree'
        tree_options = { -- Only applies when listing_style is 'tree'
          flatten_dirs = true, -- Flatten dirs that only contain one single dir
          folder_statuses = "only_folded", -- One of 'never', 'only_folded' or 'always'.
        },
        win_config = { -- See ':h diffview-config-win_config'
          position = "left",
          width = 35,
          win_opts = {},
        },
      },
      file_history_panel = {
        log_options = {
          git = {
            single_file = {
              max_count = 256, -- Limit the number of commits
              follow = true, -- Follow renames (only for single file)
              all = false, -- Include all refs under 'refs/' including HEAD
              merges = false, -- List only merge commits
              no_merges = false, -- List no merge commits
              reverse = false, -- List commits in reverse order
              diff_merges = "combined",
            },
            multi_file = {
              max_count = 256, -- Limit the number of commits
              all = false, -- Include all refs under 'refs/' including HEAD
              merges = false, -- List only merge commits
              no_merges = false, -- List no merge commits
              reverse = false, -- List commits in reverse order
              diff_merges = "first-parent",
            },
          },
        },
        win_config = { -- See ':h diffview-config-win_config'
          position = "bottom",
          height = 16,
          win_opts = {},
        },
      },
      commit_log_panel = {
        win_config = {}, -- See ':h diffview-config-win_config'
      },
      default_args = { -- Default args prepended to the arg-list for the listed commands
        DiffviewOpen = {},
        DiffviewFileHistory = {},
      },
      hooks = {}, -- See ':h diffview-config-hooks'
    },
  },
}
