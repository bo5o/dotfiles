return {
  { "folke/lazy.nvim", version = "*" },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      icons = {
        mappings = false,
        keys = {
          C = "^",
          Space = "␣",
        },
      },
      preset = "helix",
      spec = {
        { "<leader>a", group = "alternate" },
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>cw", group = "workspace" },
        { "<leader>e", group = "edit" },
        { "<leader>ev", group = "vertical" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>gc", group = "commit" },
        { "<leader>h", group = "hint/hunk/highlight" },
        { "<leader>n", group = "notification" },
        { "<leader>o", group = "open/toggle" },
        { "<leader>p", group = "peek" },
        { "<leader>q", group = "diagnostics" },
        { "<leader>s", group = "search/replace" },
        { "<leader>t", group = "test" },
        { "<leader>T", group = "test (neotest)" },
      },
    },
  },

  {
    "nvimtools/hydra.nvim",
    lazy = true,
  },

  {
    "folke/trouble.nvim", -- lsp errors and diagnostics in quickfix
    cmd = {
      "Trouble",
      "TroubleToggle",
      "TroubleRefresh",
      "TroubleClose",
    },
    keys = {
      {
        "<leader>qq",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "List diagnostics",
      },
      {
        "<leader>qQ",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "List document diagnostics",
      },
      {
        "<leader>qf",
        "<cmd>Trouble quickfix toggle<cr>",
        desc = "Toggle quickfix",
      },
      {
        "<leader>ql",
        "<cmd>Trouble loclist toggle<cr>",
        function()
          require("trouble").toggle("loclist")
        end,
        desc = "Toggle loclist",
      },
      {
        "]g",
        function()
          require("trouble").next({ skip_groups = true, jump = true })
        end,
        desc = "Jump to next trouble item",
      },
      {
        "[g",
        function()
          require("trouble").prev({ skip_groups = true, jump = true })
        end,
        desc = "Jump to previous trouble item",
      },
      {
        "]G",
        function()
          require("trouble").first({ skip_groups = true, jump = true })
        end,
        desc = "Jump to first trouble item",
      },
      {
        "[G",
        function()
          require("trouble").last({ skip_groups = true, jump = true })
        end,
        desc = "Jump to last trouble item",
      },
    },
    ---@ type trouble.Config
    opts = {
      preview = {
        type = "split",
        relative = "win",
        position = "right",
        size = 0.4,
      },
      modes = {
        lsp_base = {
          params = {
            -- include the current location in the results
            include_current = true,
          },
        },
      },
    },
  },

  {
    "folke/todo-comments.nvim",
    keys = {
      { "<leader>qt", "<cmd>TodoTrouble<cr>", desc = "List todos" },
    },
    opts = {
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#ea6962" },
        warning = { "DiagnosticWarn", "WarningMsg", "#d8a657" },
        info = { "DiagnosticInfo", "#7daea3" },
        hint = { "DiagnosticHint", "#a9b665" },
        default = { "Identifier", "#7daea3" },
        test = { "Identifier", "#7daea3" },
      },
    },
  },

  { "direnv/direnv.vim" },

  { "tpope/vim-repeat" },

  {
    "echasnovski/mini.ai",
    version = "*",
    event = "BufRead",
    opts = {
      custom_textobjects = { f = false, ["?"] = false },
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = function()
      Snacks.toggle.profiler():map("<leader>pp")
      Snacks.toggle.profiler_highlights():map("<leader>ph")

      return {
        input = { enabled = true },
        lazygit = { enabled = true },
        profiler = {
          filter_mod = {
            ["^vim%."] = true,
          },
        },
        picker = {
          win = {
            input = {
              keys = {
                ["<c-d>"] = { "preview_scroll_down", mode = { "i", "n" } },
                ["<c-u>"] = { "preview_scroll_up", mode = { "i", "n" } },
                ["<c-h>"] = { "toggle_hidden", mode = { "i", "n" } },
              },
            },
          },
          layout = { -- "telescope"
            layout = {
              box = "horizontal",
              backdrop = false,
              width = 0.8,
              height = 0.85,
              border = "none",
              {
                box = "vertical",
                {
                  win = "list",
                  title = " Results ",
                  title_pos = "center",
                  border = "rounded",
                },
                {
                  win = "input",
                  height = 1,
                  border = "rounded",
                  title = "{title} {live} {flags}",
                  title_pos = "center",
                },
              },
              {
                win = "preview",
                title = "{preview:Preview}",
                width = 0.60,
                border = "rounded",
                title_pos = "center",
              },
            },
          },
        },
      }
    end,
    keys = {
      {
        "<leader>ps",
        function()
          Snacks.profiler.scratch()
        end,
        desc = "Profiler Scratch Buffer",
      },
      {
        "<leader>fi",
        function()
          require("snacks").picker.icons()
        end,
        desc = "Find icons",
      },
      {
        "<leader>fn",
        function()
          require("snacks").picker.notifications()
        end,
        desc = "Find notifications",
      },
      {
        "<leader>fd",
        function()
          require("snacks").picker.diagnostics_buffer()
        end,
        desc = "Find diagnostics",
      },
      {
        "<leader>fu",
        function()
          require("snacks").picker.undo()
        end,
        desc = "Find in undo history",
      },
      {
        "<leader>gg",
        function()
          require("snacks").lazygit()
        end,
        desc = "Lazygit",
      },
    },
  },

  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        -- Open in the current working directory
        "<leader>or",
        "<cmd>Yazi<cr>",
        desc = "Open file manager",
      },
    },
    ---@type YaziConfig
    opts = {},
  },

  {
    "echasnovski/mini.bufremove",
    version = "*",
    keys = {
      {
        "<leader>bd",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Close current buffer (ignore unsaved changes)",
      },
      {
        "<leader>x",
        function()
          require("mini.bufremove").delete()
        end,
        desc = "Close current buffer",
      },
    },
    opts = {
      set_vim_settings = false,
    },
  },

  {
    "echasnovski/mini.indentscope",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.g.miniindentscope_disable = true
    end,
    opts = {
      mappings = {
        -- Textobjects
        object_scope = "ii",
        object_scope_with_border = "ai",

        -- Motions (jump to respective border line; if not present - body line)
        goto_top = "",
        goto_bottom = "",
      },
      options = {
        border = "none",
      },
    },
  },

  {
    "tpope/vim-unimpaired",
    config = function()
      vim.keymap.set("n", "yoD", "<cmd>diffoff!<cr>", {
        desc = "Switch off diff mode in all windows in the current tab page where 'diff' is set",
      })
    end,
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      indent = { char = "┊" },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
      whitespace = {
        remove_blankline_trail = false,
      },
      exclude = {
        filetypes = {
          "help",
          "vimwiki",
          "markdown",
          "startify",
          "NvimTree",
          "mason",
          "lspinfo",
          "packer",
          "checkhealth",
          "help",
          "man",
          "gitcommit",
          "TelescopePrompt",
          "TelescopeResults",
          "",
        },
        buftypes = {
          "terminal",
          "nofile",
          "prompt",
          "quickfix",
        },
      },
    },
  },

  {
    "mhinz/vim-startify",
    event = "VimEnter",
    init = function()
      vim.g.startify_list_order = { "files", "dir", "bookmarks", "commands" }
      vim.g.startify_bookmarks = {
        { c = "~/.config/nvim/init.lua" },
        { g = "~/.gitconfig" },
        { p = "~/.oh-my-zsh/custom/p10k.zsh" },
        { t = "~/.config/tmux/tmux.conf" },
        { z = "~/.zshrc" },
      }
      vim.g.startify_change_to_dir = 0
      vim.g.startify_change_to_vcs_root = 0
      vim.g.startify_fortune_use_unicode = 1
      vim.g.startify_files_number = 4
      vim.g.startify_custom_indices = { "1", "2", "3", "4", "7", "8", "9", "0" }
      vim.g.startify_commands = {
        { uu = { "Open lazy.nvim", ":Lazy" } },
        { up = { "Update plugins", ":Lazy sync" } },
      }
    end,
  },

  {
    "anuvyklack/windows.nvim",
    dependencies = "anuvyklack/middleclass",
    lazy = false,
    keys = {
      { "<C-w>z", "<cmd>WindowsMaximize<cr>" },
      { "<C-w>=", "<cmd>WindowsEqualize<cr>" },
    },
    opts = {
      autowidth = {
        enable = true,
        winwidth = 14, -- 80 + 14 = 94
      },
      animation = {
        enable = false,
      },
    },
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<a-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<a-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<a-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<a-l>", "<cmd>TmuxNavigateRight<cr>" },
    },
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
      vim.g.tmux_navigator_no_wrap = 1
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = "nvim-cmp",
    opts = {
      check_ts = true,
      enable_afterquote = true,
      enable_moveright = true,
      enable_check_bracket_line = true,
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      local cmp = require("cmp")
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")

      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done({
          map_char = {
            all = "(",
            tex = "{",
          },
        })
      )
    end,
  },

  {
    "tpope/vim-endwise",
    event = "BufWinEnter",
    init = function()
      vim.g.endwise_no_mappings = 1
    end,
  },

  {
    "NMAC427/guess-indent.nvim",
    event = "BufRead",
    config = true,
  },

  {
    "unblevable/quick-scope",
    event = "BufWinEnter",
    init = function()
      vim.g.qs_max_chars = 256
      vim.g.qs_buftype_blacklist = { "terminal", "nofile", "startify", "qf", "mason" }
      vim.g.qs_lazy_highlight = 1
    end,
  },

  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      providers = {
        "lsp",
        "treesitter",
        "regex",
      },
      delay = 200,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = { "o" },
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
    },
    ---@type Flash.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      labels = "arstdhneiqwfpgjluyozxcvbkm",
      modes = {
        char = {
          enabled = false,
        },
      },
    },
  },

  {
    "andymass/vim-matchup",
    init = function()
      vim.g.matchup_transmute_enabled = 0 -- covered by nvim-ts-autotag
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    keys = {
      {
        "<BS><BS>",
        function()
          local harpoon = require("harpoon")
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "Toggle harpoon menu",
      },
      {
        "<BS>m",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Mark file for harpoon",
      },
      {
        "<BS>n",
        function()
          require("harpoon"):list():select(1)
        end,
        desc = "Navigate to first harpoon ",
      },
      {
        "<BS>e",
        function()
          require("harpoon"):list():select(2)
        end,
        desc = "Navigate to second harpoon",
      },
      {
        "<BS>i",
        function()
          require("harpoon"):list():select(3)
        end,
        desc = "Navigate to third harpoon",
      },
      {
        "<BS>o",
        function()
          require("harpoon"):list():select(4)
        end,
        desc = "Navigate to fourth harpoon",
      },
    },
    config = function()
      require("harpoon"):setup()
    end,
  },

  {
    "kyazdani42/nvim-tree.lua",
    version = "*",
    lazy = false,
    keys = {
      {
        "<leader>of",
        "<cmd>NvimTreeToggle<cr>",
        desc = "Toggle file tree",
      },
      {
        "<leader>oF",
        "<cmd>NvimTreeFindFile<cr>",
        desc = "Find current file in file tree",
      },
    },
    init = function()
      vim.g.nvim_tree_auto_ignore_ft = { "startify", "dashboard" }
    end,
    config = function()
      local function on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function nmap(lhs, rhs, desc)
          local opts = {
            desc = "nvim-tree: " .. desc,
            buffer = bufnr,
            noremap = true,
            silent = true,
            nowait = true,
          }
          vim.keymap.set("n", lhs, rhs, opts)
        end

        api.config.mappings.default_on_attach(bufnr)

        nmap("o", api.node.open.edit, "Open")
        nmap("l", api.node.open.edit, "Open")
        nmap("h", api.node.navigate.parent_close, "Close Directory")
        nmap("zh", api.tree.toggle_hidden_filter, "Toggle Filter: Hidden")
        nmap("zi", api.tree.toggle_gitignore_filter, "Toggle Filter: Git Ignore")
        nmap("H", api.tree.change_root_to_parent, "Up")
        nmap("L", api.tree.change_root_to_node, "CD")
      end

      require("nvim-tree").setup({
        on_attach = on_attach,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        filters = {
          dotfiles = false,
          custom = { "^\\.git", "^node_modules", "^\\.cache", "__pycache__" },
        },
        view = {
          width = {},
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          add_trailing = true,
          indent_markers = {
            enable = true,
          },
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      })
    end,
  },

  {
    "lervag/vimtex",
    ft = "tex",
    dependencies = { "nvim-cmp" },
    init = function()
      vim.g.vimtex_view_method = "zathura"
      vim.g.tex_flavor = "latex"
      vim.g.vimtex_quickfix_latexlog = { overfull = 0, underfull = 0 }
    end,
    config = function()
      local vimtex_event_1 =
        vim.api.nvim_create_augroup("vimtex_event_1", { clear = true })

      vim.api.nvim_create_autocmd("User", {
        pattern = { "VimtexEventInitPost" },
        command = "VimtexCompile",
        group = vimtex_event_1,
        desc = "Compile on initialization",
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = { "VimtexEventQuit" },
        command = "VimtexClean",
        group = vimtex_event_1,
        desc = "Cleanup on quit",
      })

      local vimtex_latex_surround =
        vim.api.nvim_create_augroup("vimtex_latex_surround", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "tex" },
        callback = function()
          vim.b["surround_" .. vim.fn.char2nr("e")] =
            "\\begin{\1environment: \1}\n\t\r\n\\end{\1\1}"
          vim.b["surround_" .. vim.fn.char2nr("c")] = "\\\1command: \1{\r}"
        end,
        group = vimtex_latex_surround,
        desc = "Provide surround mappings",
      })
    end,
  },

  { "jamessan/vim-gnupg" },

  {
    "brenoprata10/nvim-highlight-colors",
    opts = {
      render = "virtual",
    },
  },

  {
    "danymat/neogen",
    keys = {
      { "crd", "<cmd>Neogen<cr>", desc = "Generate docstring" },
    },
    opts = {
      languages = {
        python = { template = { annotation_convention = "google_docstrings" } },
        javascript = { template = { annotation_convention = "jsdoc" } },
        typescript = { template = { annotation_convention = "tsdoc" } },
      },
    },
  },

  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    keys = {
      {
        "<leader>tf",
        "<cmd>TestFile<cr>",
        desc = "Run tests for the current file",
        silent = false,
      },
      {
        "<leader>ts",
        "<cmd>TestSuite<cr>",
        desc = "Run test suite of the current file",
      },
      {
        "<leader>tS",
        ":TestSuite<space>",
        desc = "Run test suite of the current file (add flags)",
      },
      {
        "<leader>tn",
        "<cmd>TestNearest<cr>",
        desc = "Run a test nearest to the cursor",
      },
      {
        "<leader>tN",
        ":TestNearest<space>",
        desc = "Run a test nearest to the cursor (add flags)",
        silent = false,
      },
      { "<leader>tt", "<cmd>TestLast<cr>", desc = "Run the last test" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "Run the last test" },
      {
        "<leader>tL",
        ":TestLast<space>",
        desc = "Run the last test (add flags)",
        silent = false,
      },
      {
        "<leader>ty",
        "<cmd>TestNearest -strategy=clipboard<cr>",
        desc = "Copy test command for nearest test",
      },
      {
        "<leader>tY",
        ":TestNearest -strategy=clipboard<space>",
        desc = "Copy test command for nearest test (add flags)",
        silent = false,
      },
    },
    dependencies = { "vim-dispatch" },
    init = function()
      vim.g["test#custom_strategies"] = {
        clipboard = function(cmd)
          vim.fn.setreg("+", cmd)
        end,
        start = function(cmd)
          vim.fn.execute("Start -wait=always " .. cmd)
        end,
      }
      vim.g["test#strategy"] = "start"

      -- :p causes problems with cargo test in rust
      -- vim.g["test#filename_modifier"] = ":p"
      vim.g["test#filename_modifier"] = ":."

      -- Python
      vim.g["test#python#pytest#file_pattern"] = "\\.py"
      vim.g["test#python#runner"] = "pytest"

      vim.g["test#python#pytest#options"] = {
        nearest = "--pdb --pdbcls=IPython.terminal.debugger:TerminalPdb --no-cov",
        file = "--no-cov",
      }

      -- JavaScript
      vim.g["test#javascript#runner"] = "jest"

      -- Rust
      vim.g["test#rust#runner"] = "cargotest"
    end,
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      -- plugins
      "mrcjkb/rustaceanvim",
      "nvim-neotest/neotest-python",
      "nvim-neotest/neotest-vim-test",
      "nvim-neotest/neotest-jest",
    },
    keys = {
      {
        "<leader>Ta",
        function()
          require("neotest").run.attach()
        end,
        desc = "Attach to the nearest test",
      },
      {
        "<leader>Tn",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },
      {
        "<leader>Tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run test file",
      },
      {
        "<leader>Tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run last test",
      },
      {
        "<leader>Tt",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run last test",
      },
      {
        "<leader>Ts",
        function()
          require("neotest").run.run({ suite = true })
        end,
        desc = "Run test suite",
      },
      {
        "<leader>Tw",
        function()
          require("neotest").watch.toggle()
        end,
        "Watch nearest test",
      },
      {
        "<leader>TW",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        "Watch test file",
      },
      {
        "<leader>To",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Show test output (short)",
      },
      {
        "<leader>TO",
        function()
          require("neotest").output.open({ enter = true, last_run = true })
        end,
        desc = "Show test output",
      },
      {
        "<leader>ot",
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Open test file summary",
      },
      {
        "<leader>Tp",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Open test output panel",
      },
      {
        "]w",
        function()
          require("neotest").jump.next({ status = "failed" })
        end,
        desc = "Jump to next failed test",
      },
      {
        "[w",
        function()
          require("neotest").jump.prev({ status = "failed" })
        end,
        desc = "Jump to previous failed test",
      },
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("rustaceanvim/neotest"),
          require("neotest-python"),
          require("neotest-jest"),
          require("neotest-vim-test")({
            ignore_file_types = {
              "rust",
              "python",
              "javascript",
              "typescript",
            },
          }),
        },
      })
    end,
  },

  {
    "tpope/vim-dispatch",
    cmd = { "Dispatch", "Make", "Focus", "Start" },
    keys = {
      {
        "'<space>",
        ":Start -wait=always<space>",
        desc = "Start a process in the tmux popup session",
      },
    },
    init = function()
      vim.g.dispatch_no_maps = 1
      vim.g.tmux_session = "popup"
    end,
  },

  {
    "tpope/vim-tbone",
    keys = {
      { "t<cr>", "<cmd>Tmux send-keys -t popup Enter<cr>" },
      { "t<C-c>", "<cmd>Tmux send-keys -t popup C-c<cr>" },
      { "t<C-d>", "<cmd>Tmux send-keys -t popup C-d<cr>" },
      { "t<C-l>", "<cmd>Tmux send-keys -t popup C-l<cr>" },
    },
    cmd = "Tmux",
  },

  {
    "tpope/vim-eunuch",
    cmd = {
      "Delete",
      "Unlink",
      "Remove",
      "Move",
      "Rename",
      "Chmod",
      "Mkdir",
      "Cfind",
      "Lfind",
      "Clocate",
      "Llocate",
      "SudoEdit",
      "SudoWrite",
      "Wall",
      "W",
    },
  },

  {
    "tpope/vim-projectionist",
    keys = {
      { "<leader>aa", "<cmd>A<cr>", desc = "Open alternate file" },
      { "<leader>av", "<cmd>AV<cr>", desc = "Open alternate file in vertical split" },
      { "<leader>et", "<cmd>Etest<cr>", desc = "Edit test" },
      { "<leader>evt", "<cmd>Vtest<cr>", desc = "Edit test in vertical split" },
      { "<leader>es", "<cmd>Esource<cr>", desc = "Edit source" },
      { "<leader>evs", "<cmd>Vsource<cr>", desc = "Edit source in vertical split" },
    },
    init = function()
      vim.g.projectionist_heuristics = {
        ["setup.py|requirements.txt|pyproject.toml"] = {
          ["scripts/*.py"] = {
            type = "script",
            start = "-wait=always ipython --pdb {file}",
          },
          ["src/*.py"] = {
            type = "source",
            alternate = "tests/unit/{dirname|basename}/test_{basename}.py",
            start = "-wait=always ipython --pdb -m {dot}",
          },
          ["tests/unit/**/test_*.py"] = {
            type = "test",
            start = "{project}",
            alternate = "src/{project|basename}/{dirname}/{basename}.py",
          },
          ["README.md"] = {
            type = "readme",
          },
          [".env"] = {
            type = "env",
          },
        },
      }
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    event = "VeryLazy",
    main = "project_nvim",
    opts = {
      silent_chdir = true,
      scope_chdir = "win",
      detection_methods = { "pattern", "lsp" },
      patterns = {
        "!^.direnv",
        "!^site-packages",
        "!^node_modules",
        "!=src",
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
  },

  { "tpope/vim-dadbod", dependencies = "vim-dadbod-ui" },

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = "tpope/vim-dadbod",
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
      "DBUIRenameBuffer",
      "DBUILastQueryInfo",
      "DBUIHideNotifications",
    },
    keys = {
      { "<leader>oD", "<cmd>tab DBUI<cr>", desc = "Open DBUI" },
    },
    init = function()
      vim.g.db_ui_auto_execute_table_helpers = 0
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_use_nvim_notify = 1
      vim.g.db_ui_win_position = "left"
      vim.g.db_ui_execute_on_save = 0
    end,
  },

  {
    "kristijanhusak/vim-dadbod-completion",
    dependencies = { "nvim-cmp", "vim-dadbod-ui" },
  },

  {
    "jpalardy/vim-slime",
    cmd = {
      "SlimeConfig",
      "SlimeSend",
      "SlimeSend1",
    },
    keys = {
      { "<c-c><c-c>", desc = "Send current paragraph to REPL" },
      { "<c-c><c-c>", mode = "v", desc = "Send selected region to REPL" },
      { "<c-c>v", desc = "Configure REPL" },
    },
    init = function()
      vim.g.slime_target = "tmux"
      vim.g.slime_python_ipython = 0
      vim.g.slime_bracketed_paste = 1

      -- always send text to the top-right pane in the current tmux tab
      -- without asking
      local socket_name = "default"
      local tmux_env = os.getenv("TMUX")
      if tmux_env ~= nil then
        socket_name = vim.split(tmux_env, ",")[1]
      end
      vim.g.slime_default_config = {
        socket_name = socket_name,
        target_pane = "{bottom-right}",
      }
    end,
  },

  {
    "voldikss/vim-floaterm",
    cmd = {
      "FloatermToggle",
      "FloatermNew",
      "FloatermSend",
    },
    keys = {
      {
        "<C-\\>d",
        "<cmd>FloatermNew lazydocker<cr>",
        desc = "Open lazydocker",
        mode = { "n", "t" },
      },
      {
        "<C-\\>m",
        "<cmd>FloatermNew btm -m<cr>",
        desc = "Open system monitor",
        mode = { "n", "t" },
      },
      {
        "<C-\\>u",
        "<cmd>FloatermNew ncdu<cr>",
        desc = "Open disk usage analyzer",
        mode = { "n", "t" },
      },
      {
        "<c-\\><c-\\>",
        "<cmd>FloatermToggle<cr>",
        desc = "Toggle floaterm",
        mode = { "n", "t", "i" },
      },
      {
        "<c-\\>N",
        "<cmd>FloatTermNew<cr>",
        desc = "New floaterm",
        mode = { "n", "t" },
      },
    },
    init = function()
      vim.g.floaterm_keymap_toggle = [[<c-\><c-\>]]
      vim.g.floaterm_keymap_prev = "<c-\\>]"
      vim.g.floaterm_keymap_next = "<c-\\>["
      vim.g.floaterm_keymap_new = [[<c-\>N]]
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
      vim.g.floaterm_wintitle = 0
      vim.g.floaterm_autoclose = 1
      vim.g.floaterm_opener = "edit"
    end,
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion", "mcphub" },
    opts = {
      heading = {
        width = "block",
        min_width = 88,
      },
      code = {
        width = "block",
        min_width = 88,
        position = "right",
        right_pad = 10,
      },
      dash = { width = 88 },
    },
  },

  { "stevearc/profile.nvim" },
}
