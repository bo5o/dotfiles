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
      },
    },
  },

  {
    "nvimtools/hydra.nvim",
    lazy = true,
  },

  {
    "MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>sr",
        function()
          require("grug-far").grug_far({
            prefills = { flags = vim.fn.expand("%") },
          })
        end,
        desc = "Search and replace in current file",
      },
      { "<leader>sR", "<cmd>GrugFar<cr>", desc = "Search and replace" },
    },
    config = function()
      require("grug-far").setup({})
    end,
  },

  {
    "nvim-pack/nvim-spectre",
    enabled = false,
    keys = {
      {
        "<leader>sr",
        function()
          require("spectre").open_file_search()
        end,
        desc = "Search and replace in current file",
      },
      {
        "<leader>sR",
        function()
          require("spectre").open()
        end,
        desc = "Search and replace",
      },
    },
  },

  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>ssr",
        function()
          require("ssr").open()
        end,
        desc = "Structural search and replace",
        mode = { "n", "x" },
      },
    },
    opts = {},
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
    opts = {},
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

  {
    "rafcamlet/nvim-luapad",
    cmd = "Luapad",
    opts = {
      count_limit = 200000,
    },
  },

  { "tpope/vim-repeat" },

  { "tpope/vim-surround", event = "BufRead" },

  { "tpope/vim-jdaddy", ft = "json" },

  { "AndrewRadev/splitjoin.vim", event = "CursorHold" },

  {
    "tommcdo/vim-lion",
    init = function()
      vim.g.lion_squeeze_spaces = 1
      vim.g.lion_map_right = "ga"
      vim.g.lion_map_left = "gA"
    end,
  },

  {
    "monaqa/dial.nvim",
    lazy = true,
    keys = {
      {
        "<C-b>",
        function()
          require("dial.map").manipulate("increment", "normal")
        end,
      },
      {
        "<C-x>",
        function()
          require("dial.map").manipulate("decrement", "normal")
        end,
      },
      {
        "g<C-b>",
        function()
          require("dial.map").manipulate("increment", "gnormal")
        end,
      },
      {
        "g<C-x>",
        function()
          require("dial.map").manipulate("decrement", "gnormal")
        end,
      },
      {
        "<C-b>",
        function()
          require("dial.map").manipulate("increment", "visual")
        end,
        mode = "v",
      },
      {
        "<C-x>",
        function()
          require("dial.map").manipulate("decrement", "visual")
        end,
        mode = "v",
      },
      {
        "g<C-b>",
        function()
          require("dial.map").manipulate("increment", "gvisual")
        end,
        mode = "v",
      },
      {
        "g<C-x>",
        function()
          require("dial.map").manipulate("decrement", "gvisual")
        end,
        mode = "v",
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%m/%d"],
          augend.date.alias["%H:%M"],
          augend.date.alias["%d.%m.%Y"],
          augend.date.alias["%d.%m.%y"],
          augend.date.alias["%H:%M:%S"],
          augend.semver.alias.semver,
        },
      })
    end,
  },

  {
    "dhruvasagar/vim-table-mode",
    init = function()
      vim.g.table_mode_map_prefix = "<localleader>t"
    end,
  },

  { "wellle/targets.vim", event = "BufRead" },

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
        desc = "Close current buffer (ignore unsaved changes)",
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

  { "tpope/vim-unimpaired" },

  { "zhimsel/vim-stay" },

  { "tpope/vim-obsession", cmd = "Obsession" },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
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
      { "<C-w>_", "<cmd>WindowsMaximizeVertically<cr>" },
      { "<C-w>|", "<cmd>WindowsMaximizeHorizontally<cr>" },
      { "<C-w>=", "<cmd>WindowsEqualize<cr>" },
    },
    config = true,
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
    "mattn/emmet-vim",
    ft = { "html", "htmldjango", "vue", "css" },
    init = function()
      vim.g.user_emmet_install_global = 0
    end,
    config = function()
      vim.api.nvim_command("EmmetInstall")
    end,
  },

  {
    "smoka7/hop.nvim",
    version = "*",
    event = "BufWinEnter",
    keys = {
      {
        "<leader><leader>",
        function()
          require("hop").hint_words()
        end,
        desc = "hop word",
      },
      {
        "S",
        function()
          require("hop").hint_char2()
        end,
        desc = "hop sneak",
      },
      {
        "s",
        function()
          require("hop").hint_char2()
        end,
        desc = "hop sneak",
      },
    },
    opts = {
      keys = "arsdheiqwfpgjluy;zxcvbkmtn",
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
    keys = {
      {
        "<BS><BS>",
        function()
          require("harpoon.ui").toggle_quick_menu()
        end,
        desc = "Toggle harpoon menu",
      },
      {
        "<BS>m",
        function()
          require("harpoon.mark").add_file()
        end,
        desc = "Mark file for harpoon",
      },
      {
        "<BS>n",
        function()
          require("harpoon.ui").nav_file(1)
        end,
        desc = "Navigate to first harpoon ",
      },
      {
        "<BS>e",
        function()
          require("harpoon.ui").nav_file(2)
        end,
        desc = "Navigate to second harpoon",
      },
      {
        "<BS>i",
        function()
          require("harpoon.ui").nav_file(3)
        end,
        desc = "Navigate to third harpoon",
      },
      {
        "<BS>o",
        function()
          require("harpoon.ui").nav_file(4)
        end,
        desc = "Navigate to fourth harpoon",
      },
    },
  },

  {
    "stevearc/oil.nvim",
    keys = {
      { "<leader>oo", "<cmd>Oil<cr>", desc = "Open parent directory in oil" },
    },
    opts = {
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-s>"] = "actions.select_vsplit",
        ["<C-h>"] = false,
        ["<C-t>"] = "actions.select_tab",
        ["<C-p>"] = "actions.preview",
        ["<C-q>"] = "actions.close",
        ["<C-l>"] = false,
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["`"] = "actions.cd",
        ["~"] = "actions.tcd",
        ["gs"] = "actions.change_sort",
        ["gx"] = "actions.open_external",
        ["g."] = "actions.toggle_hidden",
        ["g\\"] = "actions.toggle_trash",
      },
      delete_to_trash = true,
      lsp_file_methods = {
        autosave_changes = true,
      },
    },
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
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    cmd = "DogeGenerate",
    init = function()
      vim.g.doge_enable_mappings = 1
      vim.g.doge_mapping = "<Leader>rd"
      vim.g.doge_buffer_mappings = 1
      vim.g.doge_comment_interactive = 1
      vim.g.doge_comment_jump_modes = { "n", "s" }
      vim.g.doge_doc_standard_python = "numpy"
      vim.g.doge_python_settings = { single_quotes = 0 }
    end,
  },

  {
    "janko/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    keys = {
      {
        "<leader>tN",
        ":TestNearest<space>",
        desc = "Run nearest test (add flags)",
        silent = false,
      },
      {
        "<leader>tL",
        ":TestLast<space>",
        desc = "Run last test (add flags)",
        silent = false,
      },
      {
        "<leader>tg",
        "<cmd>TestVisit<cr>",
        desc = "Open last run test in current buffer",
      },
    },
    dependencies = { "vim-dispatch" },
    init = function()
      vim.cmd([[
        function! VimTestDefaultStrategy(cmd)
          execute 'Start -wait=always ' . a:cmd
        endfunction
      ]])

      vim.g["test#custom_strategies"] = { start = vim.fn["VimTestDefaultStrategy"] }
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
    },
    keys = {
      {
        "<leader>tn",
        function()
          require("neotest").run.run()
        end,
        desc = "Run nearest test",
      },
      {
        "<leader>tf",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Run test file",
      },
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run last test",
      },
      {
        "<leader>tt",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run last test",
      },
      {
        "<leader>ts",
        function()
          require("neotest").run.run({ suite = true })
        end,
        desc = "Run test suite",
      },
      {
        "<leader>tw",
        function()
          require("neotest").watch.toggle()
        end,
        "Watch nearest test",
      },
      {
        "<leader>tW",
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        "Watch test file",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Show test output (short)",
      },
      {
        "<leader>tO",
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
        "<leader>tp",
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
          require("neotest-vim-test")({
            ignore_file_types = { "rust", "python" },
          }),
        },
      })
    end,
  },

  {
    "tpope/vim-dispatch",
    cmd = { "Dispatch", "Make", "Focus", "Start" },
    dependencies = { "tpope/vim-tbone" },
    init = function()
      vim.g.tmux_session = "popup"
    end,
    config = function()
      local map = vim.keymap.set
      map("n", "t<cr>", "<cmd>Tmux send-keys -t " .. vim.g.tmux_session .. " Enter<cr>")
      map("n", "t<C-c>", "<cmd>Tmux send-keys -t " .. vim.g.tmux_session .. " C-c<cr>")
      map("n", "t<C-d>", "<cmd>Tmux send-keys -t " .. vim.g.tmux_session .. " C-d<cr>")
    end,
  },

  { "tpope/vim-tbone", cmd = "Tmux" },

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
      { "<leader>oD", "<cmd>DBUI<cr>", desc = "Open DBUI" },
    },
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
    "hanschen/vim-ipython-cell",
    dependencies = "vim-slime",
    ft = "python",
    keys = {
      { "<c-c><c-f>", "IPythonCellRun", desc = "Run current file" },
      { "<c-c><c-t>", "IPythonCellRunTime", desc = "Run and time current file" },
      {
        "<c-c><c-x>",
        "IPythonCellExecuteCellVerbose",
        desc = "Print and execute current cell",
      },
      {
        "<c-c><c-j>",
        "IPythonCellExecuteCellVerboseJump",
        desc = "Print and execute current cell",
      },
      { "<c-c><c-l>", "IPythonCellClear", desc = "Clear IPython screen" },
      { "[C", "IPythonCellPrevCell", desc = "Go to previous cell header" },
      { "]C", "IPythonCellNextCell", desc = "Go to next cell header" },
    },
    init = function()
      vim.g.ipython_cell_delimit_cells_by = "tags"
    end,
  },

  {
    "jupyter-vim/jupyter-vim",
    ft = "python",
    keys = {
      { "<localleader>R", "<cmd>JupyterRunFile<cr>", desc = "Run file" },
      { "<localleader>I", "<cmd>PythonImportThisFile<cr>", desc = "Import file" },
      { "<localleader>X", "<cmd>JupyterSendCell<cr>", desc = "Send cell" },
      { "<localleader>E", "<cmd>JupyterSendRange<cr>", desc = "Send range" },
      { "<localleader>e", "<Plug>JupyterRunTextObj", desc = "Run text object" },
      { "<localleader>e", "<Plug>JupyterRunVisual", desc = "Run selection" },
    },
    init = function()
      vim.g.jupyter_mapkeys = 1
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
        "<C-\\>g",
        "<cmd>FloatermNew lazygit<cr>",
        desc = "Open lazygit",
        mode = { "n", "t" },
      },
      {
        "<C-\\>m",
        "<cmd>FloatermNew btm -m<cr>",
        desc = "Open system monitor",
        mode = { "n", "t" },
      },
      {
        "<C-\\>r",
        "<cmd>FloatermNew ranger<cr>",
        desc = "Open file browser",
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
    "MeanderingProgrammer/markdown.nvim",
    main = "render-markdown",
    opts = {},
  },
}
