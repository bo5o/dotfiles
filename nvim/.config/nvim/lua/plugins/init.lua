return {
  { "folke/lazy.nvim", version = "*" },

  {
    "folke/which-key.nvim",
    lazy = true,
    config = true,
  },

  {
    "nvim-pack/nvim-spectre",
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
      { "<leader>qq", "<cmd>TroubleToggle<cr>", desc = "List diagnostics" },
      { "<leader>qf", "<cmd>TroubleToggle quickfix<cr>", desc = "Toggle quickfix" },
      { "<leader>ql", "<cmd>TroubleToggle loclist<cr>", desc = "Toggle loclist" },
      {
        "<leader>qw",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "Toggle loclist",
      },
      {
        "<leader>qd",
        "<cmd>TroubleToggle document_diagnostics<cr>",
        desc = "Toggle loclist",
      },
    },
    opts = {
      position = "bottom", -- position of the list can be: bottom, top, left, right
      height = 10, -- height of the trouble list when position is top or bottom
      width = 50, -- width of the list when position is left or right
      icons = true, -- use devicons for filenames
      mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
      fold_open = "", -- icon used for open folds
      fold_closed = "", -- icon used for closed folds
      group = true, -- group results by file
      padding = true, -- add an extra new line on top of the list
      action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = { "o" }, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = { "zM", "zm" }, -- close all folds
        open_folds = { "zR", "zr" }, -- open all folds
        toggle_fold = { "zA", "za" }, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j", -- next item
      },
      indent_lines = true, -- add an indent guide below the fold icons
      auto_open = false, -- automatically open the list when you have diagnostics
      auto_close = false, -- automatically close the list when you have no diagnostics
      auto_preview = false, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      auto_fold = false, -- automatically fold a file trouble list at creation
      auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
      signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠",
      },
      use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
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
    "AndrewRadev/switch.vim",
    init = function()
      vim.g.switch_mapping = "-"
    end,
  },

  {
    "tommcdo/vim-lion",
    init = function()
      vim.g.lion_squeeze_spaces = 1
      vim.g.lion_map_right = "ga"
      vim.g.lion_map_left = "gA"
    end,
  },

  {
    "dhruvasagar/vim-table-mode",
    init = function()
      vim.g.table_mode_map_prefix = "<localleader>t"
    end,
  },

  { "machakann/vim-swap" },

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
    "ojroques/nvim-osc52",
    cond = function()
      -- Check if connection is ssh
      return os.getenv("SSH_CLIENT") ~= nil
    end,
    keys = {
      {
        "<leader>C",
        function()
          require("osc52").copy_operator()
        end,
        expr = true,
        desc = "OSC52 copy",
      },
      { "<leader>CC", "<leader>C_", "n", remap = true },
      {
        "<leader>C",
        function()
          require("osc52").copy_visual()
        end,
        mode = "x",
        desc = "OSC52 copy",
      },
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      char = "┊",
      use_treesitter = true,
      show_trailing_blankline_indent = true,
      filetype_exclude = {
        "help",
        "vimwiki",
        "markdown",
        "startify",
        "NvimTree",
        "mason",
      },
      buftype_exclude = { "terminal", "nofile", "prompt" },
      show_current_context = false,
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
        { t = "~/.tmux.conf" },
        { z = "~/.zshrc" },
      }
      vim.g.startify_change_to_dir = 0
      vim.g.startify_change_to_vcs_root = 0
      vim.g.startify_fortune_use_unicode = 1
      vim.g.startify_files_number = 4
      vim.g.startify_custom_indices = { "1", "2", "3", "4", "7", "8", "9", "0" }
      vim.g.startify_commands = {
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
    "phaazon/hop.nvim",
    branch = "v2",
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
    "kyazdani42/nvim-tree.lua",
    version = "nightly",
    cmd = {
      "NvimTreeClipboard",
      "NvimTreeClose",
      "NvimTreeFindFile",
      "NvimTreeOpen",
      "NvimTreeRefresh",
      "NvimTreeToggle",
    },
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
      local tree_cb = require("nvim-tree.config").nvim_tree_callback

      require("nvim-tree").setup({
        view = {
          adaptive_size = true,
          mappings = {
            list = {
              { key = { "<CR>", "o", "<2-LeftMouse>", "l" }, cb = tree_cb("edit") },
              { key = { "<BS>", "h" }, cb = tree_cb("close_node") },
              { key = "zh", cb = tree_cb("toggle_dotfiles") },
              { key = "zi", cb = tree_cb("toggle_custom") },
              { key = "zg", cb = tree_cb("toggle_git_ignored") },
              { key = { "-", "H" }, cb = tree_cb("dir_up") },
              { key = { "<2-RightMouse>", "<C-]>", "L" }, cb = tree_cb("cd") },
            },
          },
        },
        filters = {
          dotfiles = true,
          custom = { "^\\.git", "^node_modules", "^\\.cache", "__pycache__" },
        },
        renderer = {
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
    "NvChad/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "vim",
        "css",
        "html",
        "javascript",
        "typescript",
        "lua",
        html = {
          mode = "background",
        },
      },
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
      { "<leader>tn", "<cmd>TestNearest<cr>", desc = "Run nearest test" },
      {
        "<leader>tN",
        ":TestNearest<space>",
        desc = "Run nearest test (add flags)",
        silent = false,
      },
      { "<leader>tf", "<cmd>TestFile<cr>", desc = "Run test file" },
      { "<leader>ts", "<cmd>TestSuite<cr>", desc = "Run test suite" },
      { "<leader>tl", "<cmd>TestLast<cr>", desc = "Run last test" },
      {
        "<leader>tL",
        ":TestLast<space>",
        desc = "Run last test (add flags)",
        silent = false,
      },
      { "<leader>tt", "<cmd>TestLast<cr>", desc = "Run last test" },
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

  {
    "airblade/vim-rooter",
    init = function()
      vim.g.rooter_silent_chdir = 1
      vim.g.rooter_cd_cmd = "lcd"
      vim.g.rooter_patterns = {
        "!^.direnv",
        "!^site-packages",
        "!^node_modules",
        "!../.project-root",
        ".project-root",
        "package.json",
        "requirements.txt",
        "setup.py",
        "manage.py",
        "pyproject.toml",
        "Cargo.toml",
        ".git",
      }
    end,
  },

  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    config = function()
      require("Comment").setup({
        opleader = {
          line = "gc",
          block = "gC",
        },
        toggler = {
          line = "gcc",
          block = "gcb",
        },
        mappings = {
          basic = true,
          ---Extra mapping
          ---Includes `gco`, `gcO`, `gcA`
          extra = false,
          ---Extended mapping
          ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
          extended = false,
        },
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      })
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
      { "<leader>od", "<cmd>FloatermNew lazydocker<cr>", desc = "Open lazydocker" },
      { "<leader>og", "<cmd>FloatermNew lazygit<cr>", desc = "Open lazygit" },
      { "<leader>om", "<cmd>FloatermNew btm -m<cr>", desc = "Open system monitor" },
      { "<leader>or", "<cmd>FloatermNew ranger<cr>", desc = "Open file browser" },
      { "<leader>ou", "<cmd>FloatermNew ncdu<cr>", desc = "Open disk usage analyzer" },
    },
    init = function()
      vim.g.floaterm_keymap_toggle = "<leader>ot"
      vim.g.floaterm_keymap_prev = "<F2>"
      vim.g.floaterm_keymap_next = "<F3>"
      vim.g.floaterm_keymap_new = "<leader>oT"
      vim.g.floaterm_width = 0.8
      vim.g.floaterm_height = 0.8
      vim.g.floaterm_wintitle = 0
      vim.g.floaterm_autoclose = 1
      vim.g.floaterm_opener = "edit"
    end,
  },
}
