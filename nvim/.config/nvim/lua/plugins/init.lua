local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  Packer_bootstrap = vim.fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
end

require("packer").init({
  display = {
    keybindings = { -- Keybindings for the display window
      quit = "q",
      toggle_info = "-",
      diff = "<CR>",
      prompt_revert = "r",
    },
  },
})

local augroup = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = { "**/nvim/lua/plugins/*.lua" },
  command = "source <afile> | PackerCompile",
  group = augroup,
  desc = "Re-compile packer plugins",
})

return require("packer").startup(function(use)
  --------------------
  -- Plugin management
  --------------------

  -- Package manager
  use("wbthomason/packer.nvim")

  -- Faster startup
  use("lewis6991/impatient.nvim")

  ---------------
  -- UI and style
  ---------------

  -- Colorscheme
  use({
    "sainnhe/gruvbox-material",
    setup = function()
      require("plugins.gruvbox").setup()
    end,
    config = function()
      require("plugins.gruvbox").config()
    end,
  })

  -- Indentation guides
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("plugins.indent_blankline").config()
    end,
  })

  -- Status line
  use({
    "nvim-lualine/lualine.nvim",
    after = "gruvbox-material",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.statusline").config()
    end,
  })

  -- Buffer line
  use({
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    event = "BufWinEnter",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("plugins.bufferline").config()
    end,
  })

  -- Git signs
  use({
    "airblade/vim-gitgutter",
    event = "BufRead",
    config = function()
      require("plugins.gitgutter").config()
    end,
  })

  -- Start screen
  use({
    "mhinz/vim-startify",
    config = function()
      require("plugins.startify").config()
    end,
  })

  -------------
  -- Navigation
  -------------

  -- File tree
  use({
    "kyazdani42/nvim-tree.lua",
    tag = "nightly",
    requires = "kyazdani42/nvim-web-devicons",
    cmd = {
      "NvimTreeClipboard",
      "NvimTreeClose",
      "NvimTreeFindFile",
      "NvimTreeOpen",
      "NvimTreeRefresh",
      "NvimTreeToggle",
    },
    config = function()
      require("plugins.nvim_tree").config()
    end,
  })

  -- LSP symbol tree
  use({
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    config = function()
      require("plugins.symbols_outline").config()
    end,
  })

  use({
    "stevearc/dressing.nvim",
    config = function()
      require("plugins.dressing").config()
    end,
  })

  -- Fuzzy finder
  use({
    {
      "nvim-telescope/telescope.nvim",
      keys = "<leader>f",
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
      },
      config = function()
        require("plugins.telescope").config()
      end,
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      after = "telescope.nvim",
      run = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    {
      "fhill2/telescope-ultisnips.nvim",
      after = "telescope.nvim",
      config = function()
        require("telescope").load_extension("ultisnips")
      end,
    },
  })

  -- Quick jump bookmarks
  use({ "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" })

  -- Jump between match pairs
  use({
    "andymass/vim-matchup",
    setup = function()
      require("plugins.matchup").setup()
    end,
  })

  use({
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("plugins.hop").config()
    end,
  })

  -- Always highlight the quickest movement to any word on the current line
  use({
    "unblevable/quick-scope",
    setup = function()
      require("plugins.quickscope").setup()
    end,
  })

  -------------------------------
  -- Auto-completion and snippets
  -------------------------------

  -- Autocompletion
  use({
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      requires = {
        "onsails/lspkind-nvim", -- nice symbols for completion menu
        "lukas-reineke/cmp-under-comparator", -- better sorting of dunder methods
      },
      config = function()
        require("plugins.nvim_cmp").config()
      end,
    },
    { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }, -- lsp
    { "hrsh7th/cmp-buffer", after = "nvim-cmp" }, -- buffer contents
    { "hrsh7th/cmp-path", after = "nvim-cmp" }, -- path
    { "quangnguyen30192/cmp-nvim-ultisnips", after = "nvim-cmp" }, -- snippets
    { "hrsh7th/cmp-cmdline", after = "nvim-cmp" }, -- cmdline
    { "andersevenrud/cmp-tmux", after = "nvim-cmp" }, -- tmux pane contents
  })

  -- Auto-close brackets, parentheses etc.
  use({
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("plugins.autopairs").config()
    end,
  })

  -- Auto-close more things like end/endfunction/endif etc.
  use({
    "tpope/vim-endwise",
    setup = function()
      require("plugins.endwise").setup()
    end,
  })

  -- Snippets
  use({
    "SirVer/ultisnips",
    requires = {
      {
        "honza/vim-snippets",
        rtp = ".",
        event = "InsertCharPre",
      },
    },
    setup = function()
      require("plugins.ultisnips").setup()
    end,
  })

  -- Lightweight snippet alternative (mostly used for LaTeX)
  use({
    "brennier/quicktex",
    setup = function()
      require("plugins.quicktex").setup()
    end,
  })

  -- Expand HTML/CSS abbreviations
  use({
    "mattn/emmet-vim",
    ft = { "html", "htmldjango", "vue", "css" },
    setup = function()
      require("plugins.emmet").setup()
    end,
    config = function()
      require("plugins.emmet").config()
    end,
  })

  -----------------------
  -- Language integration
  -----------------------

  -- Treesitter
  use({
    {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("plugins.treesitter").config()
      end,
    },
    -- Advanced text objects
    { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
    -- Context-aware text objects
    { "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" },
    -- Always show treesitter context
    { "lewis6991/nvim-treesitter-context", after = "nvim-treesitter" },
    -- Colorize nested parentheses
    { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
    -- Auto-close and -rename html tags
    { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
    -- Auto-set 'commentstring'
    { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
    -- Explore treesitter
    { "nvim-treesitter/playground", after = "nvim-treesitter" },
  })

  -- LSP
  use({
    -- Language server installation
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- Show signature help while typing
    "ray-x/lsp_signature.nvim",
    -- JSON schema support
    "b0o/schemastore.nvim",
    -- Better typescript lsp support
    "jose-elias-alvarez/typescript.nvim",
    -- Progress display
    "j-hui/fidget.nvim",
    -- Lua development
    "folke/lua-dev.nvim",
    {
      -- Language server configuration
      "neovim/nvim-lspconfig",
      after = {
        "mason.nvim",
        "mason-lspconfig.nvim",
        "lsp_signature.nvim",
        "schemastore.nvim",
        "typescript.nvim",
        "fidget.nvim",
        "lua-dev.nvim",
      },
      config = function()
        require("plugins.lspconfig").config()
      end,
    },
  })

  -- LaTeX
  use({
    "lervag/vimtex",
    ft = "tex",
    setup = function()
      require("plugins.vimtex").setup()
    end,
    config = function()
      require("plugins.vimtex").config()
    end,
  })

  -- Transparent editing of GPG encrypted files
  use("jamessan/vim-gnupg")

  ----------------------
  -- Syntax highlighting
  ----------------------

  -- Highlight color codes (eg. #42AFFE)
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("plugins.colorizer").config()
    end,
  })

  -- Semantic syntax highlighting for Python
  -- Let's wait for https://github.com/nvim-treesitter/nvim-treesitter/issues/81
  -- and then switch to Treesitter for semantic syntax highlighting
  use({
    "numirias/semshi",
    setup = function()
      require("plugins.semshi").setup()
    end,
    config = function()
      require("plugins.semshi").config()
    end,
  })

  -- Better Python indenting
  use("Vimjas/vim-python-pep8-indent")

  -- requirements.txt (Python)
  use("raimon49/requirements.txt.vim")

  -- jinja2 (Python)
  use("Glench/Vim-Jinja2-Syntax")

  -- .sxhkdrc
  use("kovetskiy/sxhkd-vim")

  -- .tmux.conf
  use("ericpruitt/tmux.vim")

  -- Dockerfile
  use("ekalinin/Dockerfile.vim")

  -- nginx.conf
  use("chr4/nginx.vim")

  ------------------
  -- Developer tools
  ------------------

  -- Linting (for everything language servers can't do yet)
  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("plugins.null_ls").config()
    end,
  })

  -- Linting and fixing (for everything that null-ls can't do yet)
  use({
    "dense-analysis/ale", -- linting and fixing
    setup = function()
      require("plugins.ale").setup()
    end,
  })

  -- Docstring generator
  use({
    "kkoomen/vim-doge",
    run = function()
      vim.fn["doge#install"]()
    end,
    cmd = "DogeGenerate",
    setup = function()
      require("plugins.doge").setup()
    end,
  })

  -- Git
  use({
    {
      "tpope/vim-fugitive",
      cmd = { "Git", "Gwrite", "Gblame", "Gedit", "Gdiffsplit" },
    },
    -- Github integration
    { "tpope/vim-rhubarb", after = "vim-fugitive" },
    -- Bitbucket integration
    { "tommcdo/vim-fubitive", after = "vim-fugitive" },
    -- Show git commit under cursor
    {
      "rhysd/git-messenger.vim",
      cmd = "GitMessenger",
      keys = "<leader>gm",
      config = function()
        require("plugins.git_messenger").config()
      end,
    },
    -- Diff view for changes of any git rev
    use({
      "sindrets/diffview.nvim",
      requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
      cmd = { "DiffviewOpen", "DiffviewFileHistory" },
      config = function()
        require("plugins.diffview").config()
      end,
    }),
  })

  -- Convenient test invocation
  use({
    "janko/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    setup = function()
      require("plugins.vim_test").setup()
    end,
  })

  -- Run jobs in background (builds, tests, runs etc.)
  use({
    "tpope/vim-dispatch",
    cmd = { "Dispatch", "Make", "Focus", "Start" },
    setup = function()
      require("plugins.vim_dispatch").setup()
    end,
    config = function()
      require("plugins.vim_dispatch").config()
    end,
  })

  -- Tmux interaction
  use({ "tpope/vim-tbone", cmd = "Tmux" })

  -- Unix helpers
  use({
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
  })

  -- Project helpers
  use({
    "tpope/vim-projectionist",
    setup = function()
      require("plugins.projectionist").setup()
    end,
  })

  -- automatically change to project directory when opening files
  use({
    "airblade/vim-rooter",
    setup = function()
      require("plugins.vim_rooter").setup()
    end,
  })

  -- Comment stuff out
  use({
    "numToStr/Comment.nvim",
    event = "BufWinEnter",
    config = function()
      require("plugins.comment").config()
    end,
  })

  -- Interact with databases
  use({
    { "tpope/vim-dadbod", after = "vim-dadbod-ui" },
    {
      "kristijanhusak/vim-dadbod-ui",
      requires = "tpope/vim-dadbod",
      cmd = {
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
        "DBUIRenameBuffer",
        "DBUILastQueryInfo",
        "DBUIHideNotifications",
      },
    },
    {
      "kristijanhusak/vim-dadbod-completion",
      after = { "nvim-cmp", "vim-dadbod-ui" },
    },
  })

  -- Use tmux as REPL
  use({
    "jpalardy/vim-slime",
    cmd = {
      "SlimeConfig",
      "SlimeSend",
      "SlimeSend1",
    },
    keys = {
      { "n", "<c-c><c-c>" },
      { "v", "<c-c><c-c>" },
      { "n", "<c-c>v" },
    },
    setup = function()
      require("plugins.slime").setup()
    end,
  })

  -- Run IPython cells
  use({
    "hanschen/vim-ipython-cell",
    requires = "jpalardy/vim-slime",
    after = "vim-slime",
    ft = "python",
    cmd = {
      "IPythonCellRun",
      "IPythonCellRunTime",
      "IPythonCellExecuteCellVerbose",
      "IPythonCellExecuteCellVerboseJump",
      "IPythonCellClear",
      "IPythonCellPrevCell",
      "IPythonCellNextCell",
    },
    setup = function()
      require("plugins.vim_ipython_cell").config()
    end,
    config = function()
      require("plugins.vim_ipython_cell").config()
    end,
  })

  -- Interact with jupyter kernels
  use({
    "jupyter-vim/jupyter-vim",
    ft = "python",
    cmd = {
      "JupyterRunFile",
      "JupyterSendCell",
      "JupyterSendRange",
      "PythonImportThisFile",
    },
    keys = {
      { "n", "<localleader>e" },
      { "v", "<localleader>e" },
    },
    setup = function()
      require("plugins.jupyter").config()
    end,
    config = function()
      require("plugins.jupyter").config()
    end,
  })

  -- Floating terminal
  use({
    "voldikss/vim-floaterm",
    cmd = {
      "FloatermToggle",
      "FloatermNew",
      "FloatermSend",
    },
    setup = function()
      require("plugins.floaterm").setup()
    end,
    config = function()
      require("plugins.floaterm").config()
    end,
  })

  -- Search and replace
  use({
    "nvim-pack/nvim-spectre",
    requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons" },
  })

  -- Nice list for showing diagnostics, lsp references etc.
  use({
    "folke/trouble.nvim", -- lsp errors and diagnostics in quickfix
    requires = "kyazdani42/nvim-web-devicons",
    cmd = {
      "Trouble",
      "TroubleToggle",
      "TroubleRefresh",
      "TroubleClose",
      "TodoTrouble",
    },
    config = function()
      require("plugins.trouble").config()
    end,
  })

  use({
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("plugins.lsp_lines").config()
    end,
  })

  -- Highlight and find TODO comments
  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("plugins.todo_comments").config()
    end,
  })

  -- Direnv integration
  use("direnv/direnv.vim")

  --------------------
  -- Text manipulation
  --------------------

  -- Repeat almost everything
  use("tpope/vim-repeat")

  -- Simple quoting/enclosing
  use({ "tpope/vim-surround", event = "BufRead" })

  -- Easier JSON manipulation
  use({ "tpope/vim-jdaddy", ft = "json" })

  -- Switch between single- and multi-line statements
  use({ "AndrewRadev/splitjoin.vim", event = "CursorHold" })

  -- Toggle special words (true/false, on/off etc.)
  use({
    "AndrewRadev/switch.vim",
    setup = function()
      require("plugins.switch").setup()
    end,
  })

  -- Align text by some character
  use({
    "tommcdo/vim-lion",
    setup = function()
      require("plugins.lion").setup()
    end,
  })

  -- Simple table manipulation (e.g. in Markdown)
  use({
    "dhruvasagar/vim-table-mode",
    setup = function()
      require("plugins.table_mode").setup()
    end,
  })

  -- Swap items in comma-separated lists
  use("machakann/vim-swap")

  -- Enhanced text objects
  use({ "wellle/targets.vim", event = "BufRead" })

  ----------------
  -- Miscellaneous
  ----------------

  -- Neovim keymaps
  use({
    "folke/which-key.nvim",
    config = function()
      require("plugins.which_key").config()
    end,
  })

  -- Various extensions
  use({
    "echasnovski/mini.nvim",
    branch = "stable",
    setup = function()
      require("plugins.mini_nvim").setup()
    end,
    config = function()
      require("plugins.mini_nvim").config()
    end,
  })

  -- Useful keybindings
  use("tpope/vim-unimpaired")

  -- Restore buffer views automatically
  use("zhimsel/vim-stay")

  -- Session management
  use({ "tpope/vim-obsession", cmd = "Obsession" }) -- session management

  -- Profile vim startup time
  use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

  -- Clipboard interoperability
  use({
    "ojroques/nvim-osc52",
    keys = "<leader>C",
    config = function()
      vim.keymap.set("n", "<leader>C", require("osc52").copy_operator, { expr = true })
      vim.keymap.set("n", "<leader>CC", "<leader>C_", { remap = true })
      vim.keymap.set("x", "<leader>C", require("osc52").copy_visual)
    end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  if Packer_bootstrap then
    require("packer").sync()
  end
end)
