local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	Packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

require("packer").init({
	max_jobs = 50, -- https://github.com/wbthomason/packer.nvim/issues/202
	display = {
		keybindings = { -- Keybindings for the display window
			quit = "q",
			toggle_info = "-",
			diff = "<CR>",
			prompt_revert = "r",
		},
	},
})

-- reload plugin configuration automatically
local packer_user_config_cmd = [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost %s/lua/plugins/*.lua source <afile> | PackerCompile
  augroup end
]]
vim.cmd(string.format(packer_user_config_cmd, fn.stdpath("config")))

return require("packer").startup(function(use)
	--------------------
	-- Plugin management
	--------------------

	-- Package manager
	use("wbthomason/packer.nvim")

	-- Faster startup
	use({
		"lewis6991/impatient.nvim",
		"nathom/filetype.nvim",
	})

	---------------
	-- UI and style
	---------------

	-- Colorscheme
	use({
		"sainnhe/gruvbox-material",
		setup = "vim.cmd[[source ~/.config/nvim/theme.vim]]",
		config = function()
			vim.g.gruvbox_material_palette = "material"
			vim.g.gruvbox_material_statusline_style = "default"
			vim.g.gruvbox_material_background = "medium"
			vim.g.gruvbox_material_enable_bold = 0
			vim.g.gruvbox_material_enable_italic = 0
			vim.g.gruvbox_material_disable_italic_comment = 0
			vim.g.gruvbox_material_sign_column_background = "none"
			vim.g.gruvbox_material_better_performance = 1
			vim.g.gruvbox_material_diagnostic_line_highlight = 0
			vim.g.gruvbox_material_diagnostic_text_highlight = 1

			vim.opt.termguicolors = true
			vim.opt.background = "dark"
			vim.cmd("colorscheme gruvbox-material")
		end,
	})

	-- Indentation guides
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "ColorScheme",
		config = function()
			require("plugins.indent_blankline")
		end,
	})

	-- Status line
	use({
		"vim-airline/vim-airline",
		after = "gruvbox-material",
		config = function()
			vim.g.airline_theme = "gruvbox_material"
			vim.g.airline_powerline_fonts = 1
			vim.g.airline_left_sep = ""
			vim.g.airline_left_alt_sep = ""
			vim.g.airline_right_sep = ""
			vim.g.airline_right_alt_sep = ""
		end,
	})

	-- Buffer line
	use({
		"akinsho/bufferline.nvim",
		event = "BufWinEnter",
		config = function()
			require("plugins.bufferline")
		end,
	})

	-- Git signs
	use({
		"airblade/vim-gitgutter",
		event = "BufRead",
		config = function()
			vim.g.gitgutter_preview_win_floating = 0
		end,
	})

	-- Start screen
	use({
		"mhinz/vim-startify",
		config = function()
			vim.g.startify_list_order = { "files", "dir", "bookmarks", "commands" }
			vim.g.startify_bookmarks = {
				{ c = "~/.config/nvim/init.vim" },
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
				{ up = { "Update plugins", ":PackerSync" } },
			}
		end,
	})

	-------------
	-- Navigation
	-------------

	-- File tree
	use({
		"kyazdani42/nvim-tree.lua",
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
			require("plugins.nvim_tree")
		end,
	})

	-- LSP symbol tree
	use({
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
		config = function()
			require("plugins.symbols_outline")
		end,
	})

	-- Fuzzy finder
	use({
		{
			"nvim-telescope/telescope.nvim",
			cmd = { "Telescope", "TodoTelescope" },
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
			},
			config = function()
				require("plugins.telescope")
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
		config = function()
			vim.g.matchup_transmute_enabled = 0 -- covered by nvim-ts-autotag
			vim.g.matchup_matchparen_offscreen = { method = "popup" }
		end,
	})

	-- Sneaky motion
	use({
		"justinmk/vim-sneak",
		config = function()
			vim.g["sneak#label"] = 1
			vim.g["sneak#use_ic_scs"] = 1
		end,
	})

	-- Always highlight the quickest movement to any word on the current line
	use({
		"unblevable/quick-scope",
		config = function()
			vim.g.qs_max_chars = 256
			vim.g.qs_buftype_blacklist = { "terminal", "nofile", "startify", "qf" }
			vim.g.qs_lazy_highlight = 1
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
			requires = "onsails/lspkind-nvim", -- nice symbols for completion menu
			config = function()
				require("plugins.nvim_cmp")
			end,
		},
		{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }, -- lsp
		{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }, -- neovim lua
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
			require("plugins.autopairs")
		end,
	})

	-- Auto-close more things like end/endfunction/endif etc.
	use({
		"tpope/vim-endwise",
		config = function()
			vim.g.endwise_no_mappings = 1
		end,
	})

	-- Snippets
	use({
		"SirVer/ultisnips",
		requires = { {
			"honza/vim-snippets",
			rtp = ".",
			event = "InsertCharPre",
		} },
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<Plug>(ultisnips_expand)"
			vim.g.UltiSnipsJumpForwardTrigger = "<Plug>(ultisnips_jump_forward)"
			vim.g.UltiSnipsJumpBackwardTrigger = "<Plug>(ultisnips_jump_backward)"
			vim.g.UltiSnipsListSnippets = "<c-x><c-s>"
			vim.g.UltiSnipsRemoveSelectModeMappings = 0
			vim.g.ultisnips_python_style = "numpy"
		end,
	})

	-- Lightweight snippet alternative (mostly used for LaTeX)
	use({
		"brennier/quicktex",
		config = function()
			require("plugins.quicktex")
		end,
	})

	-- Expand HTML/CSS abbreviations
	use({
		"mattn/emmet-vim",
		ft = { "html", "htmldjango", "vue", "css" },
		setup = function()
			vim.g.user_emmet_install_global = 0
		end,
		config = "vim.cmd[[EmmetInstall]]",
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
				require("plugins.treesitter")
			end,
		},
		-- Advanced text objects
		{ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
		-- Context-aware text objects
		{ "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" },
		-- Always show treesitter context
		{ "romgrk/nvim-treesitter-context", after = "nvim-treesitter" },
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
		"williamboman/nvim-lsp-installer",
		-- Show signature help while typing
		"ray-x/lsp_signature.nvim",
		-- JSON schema support
		"b0o/schemastore.nvim",
		-- Better typescript lsp support
		"jose-elias-alvarez/nvim-lsp-ts-utils",
		{
			-- Language server configuration
			"neovim/nvim-lspconfig",
			after = {
				"nvim-cmp",
				"nvim-lsp-installer",
				"lsp_signature.nvim",
				"schemastore.nvim",
				"nvim-lsp-ts-utils",
			},
			config = function()
				require("plugins.lsp_config")
			end,
		},
	})

	-- LaTeX
	use({ "lervag/vimtex", ft = "tex" })

	-- Transparent editing of GPG encrypted files
	use("jamessan/vim-gnupg")

	----------------------
	-- Syntax highlighting
	----------------------

	-- Highlight color codes (eg. #42AFFE)
	use({
		"norcalli/nvim-colorizer.lua",
		event = "ColorScheme",
		config = function()
			require("plugins.colorizer")
		end,
	})

	-- Semantic syntax highlighting for Python
	-- Let's wait for https://github.com/nvim-treesitter/nvim-treesitter/issues/81
	-- and then switch to Treesitter for semantic syntax highlighting
	use({ "numirias/semshi", config = "vim.cmd [[silent UpdateRemotePlugins]]" })

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
		after = "nvim-lspconfig",
		requires = {
			"nvim-lua/plenary.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("plugins.null-ls")
		end,
	})

	-- Linting and fixing (for everything that null-ls can't do yet)
	use({
		"dense-analysis/ale", -- linting and fixing
		config = function()
			require("plugins.ale")
		end,
	})

	-- Docstring generator
	use({
		"kkoomen/vim-doge",
		run = function()
			vim.fn["doge#install"]()
		end,
		cmd = "DogeGenerate",
		config = function()
			require("plugins.doge")
		end,
	})

	-- Git
	use({
		{ "tpope/vim-fugitive", cmd = { "Git", "Gwrite", "Gllog", "Gblame", "Gedit", "Gdiffsplit" } },
		-- Github integration
		{ "tpope/vim-rhubarb", after = "vim-fugitive" },
		-- Bitbucket integration
		{ "tommcdo/vim-fubitive", after = "vim-fugitive" },
		-- Git commit browser
		{ "junegunn/gv.vim", cmd = "GV" },
		-- Show git commit under cursor
		{ "rhysd/git-messenger.vim", cmd = "GitMessenger", keys = "<leader>gm" },
	})

	-- Convenient test invocation
	use({
		"janko/vim-test",
		cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
	})

	-- Run jobs in background (builds, tests, runs etc.)
	use({
		"tpope/vim-dispatch",
		cmd = { "Dispatch", "Make", "Focus", "Start" },
		config = function()
			-- send dispatch commands to tmux popup session
			vim.g.tmux_session = "popup"
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
		config = function()
			require("plugins.projectionist")
		end,
	})

	-- automatically change to project directory when opening files
	use({
		"airblade/vim-rooter",
		config = function()
			vim.g.rooter_silent_chdir = 1
			vim.g.rooter_cd_cmd = "lcd"
			vim.g.rooter_patterns = {
				"!^.direnv",
				"!^site-packages",
				"!^node_modules",
				".project-root",
				"package.json",
				"requirements.txt",
				"setup.py",
				"manage.py",
				"pyproject.toml",
				".git",
			}
		end,
	})

	-- Comment stuff out
	use({
		"b3nj5m1n/kommentary",
		event = "BufWinEnter",
		config = function()
			require("kommentary.config").configure_language("default", {
				prefer_single_line_comments = true,
			})
		end,
	})

	-- Interact with databases
	use({
		{ "tpope/vim-dadbod", cmd = { "DB" } },
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
		config = function()
			vim.g.slime_target = "tmux"
			vim.g.slime_python_ipython = 1

			-- always send text to the top-right pane in the current tmux tab
			-- without asking
			vim.g.slime_default_config = {
				socket_name = vim.split(os.getenv("TMUX"), ",")[1],
				target_pane = "{bottom-left}",
			}
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
		config = function()
			vim.g.ipython_cell_delimit_cells_by = "tags"
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
		config = function()
			vim.g.jupyter_mapkeys = 1
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
		config = function()
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
	})

	-- Search and replace
	use({
		"windwp/nvim-spectre",
		keys = {
			{ "n", "<leader>S" },
			{ "n", "<leader>ss" },
			{ "n", "<leader>sw" },
			{ "v", "<leader>s" },
		},
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
			require("plugins.trouble")
		end,
	})

	-- Highlight and find TODO comments
	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		cmd = "ColorScheme",
	})

	-- Direnv integration
	use("direnv/direnv.vim")

	-- Automatically generate tags
	use("ludovicchabant/vim-gutentags")

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
		config = function()
			vim.g.switch_mapping = "-"
		end,
	})

	-- Align text by some character
	use({
		"tommcdo/vim-lion",
		config = function()
			vim.g.lion_squeeze_spaces = 1
			vim.g.lion_map_right = "ga"
			vim.g.lion_map_left = "gA"
		end,
	})

	-- Simple table manipulation (e.g. in Markdown)
	use({
		"dhruvasagar/vim-table-mode",
		config = function()
			vim.g.table_mode_map_prefix = "<localleader>t"
		end,
	})

	-- Swap items in comma-separated lists
	use("machakann/vim-swap")

	-- Enhanced text objects
	use({ "wellle/targets.vim", event = "BufRead" })

	---------------
	-- Organization
	---------------

	-- Wiki
	use({
		{
			"vimwiki/vimwiki",
			branch = "dev",
			cmd = {
				"VimwikiIndex",
				"VimwikiUISelect",
				"VimwikiDiaryIndex",
				"VimwikiMakeDiaryNote",
				"VimwikiMakeYesterdayDiaryNote",
				"VimwikiMakeTomorrowDiaryNote",
			},
			keys = {
				{ "n", "<leader>ww" },
				{ "n", "<leader>w<leader>w" },
				{ "n", "<leader>wi" },
				{ "n", "<leader>ws" },
				{ "n", "<leader>w<leader>y" },
				{ "n", "<leader>w<leader>m" },
			},
			config = function()
				vim.g.vimwiki_list = {
					{
						path = "~/vimwiki/",
						syntax = "markdown",
						ext = ".md",
						index = "README",
					},
				}
				vim.g.vimwiki_key_mappings = {
					all_maps = 1,
					global = 1,
					headers = 1,
					text_objs = 1,
					table_format = 1,
					table_mappings = 0,
					lists = 1,
					links = 1,
					html = 1,
					mouse = 0,
				}
				vim.g.vimwiki_global_ext = 0
				vim.g.vimwiki_folding = ""
				vim.g.vimwiki_markdown_link_ext = 1
			end,
		},
		{
			"tools-life/taskwiki", -- taskwarrior integration
			after = "vimwiki",
			config = function()
				vim.g.taskwiki_disable_concealcursor = "yes"
			end,
		},
	})

	----------------
	-- Miscellaneous
	----------------

	-- Useful keybindings
	use("tpope/vim-unimpaired")

	-- Show contents of registers at the right time
	use("tversteeg/registers.nvim")

	-- Restore buffer views automatically
	use("zhimsel/vim-stay")

	-- Session management
	use({ "tpope/vim-obsession", cmd = "Obsession" }) -- session management

	-- Profile vim startup time
	use({ "dstein64/vim-startuptime", cmd = "StartupTime" })

	-- Clipboard interoperability
	use({ "ojroques/vim-oscyank", cmd = "OSCYank" })

	-- Automatically set up your configuration after cloning packer.nvim
	if Packer_bootstrap then
		require("packer").sync()
	end
end)
