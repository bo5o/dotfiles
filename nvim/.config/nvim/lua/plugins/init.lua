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
	-- Package management
	use("wbthomason/packer.nvim")

	-- UI and style
	use("sainnhe/gruvbox-material") -- colorscheme
	use({
		"lukas-reineke/indent-blankline.nvim", -- indentation guides
		event = "BufRead",
		config = function()
			require("plugins.indent_blankline")
		end,
	})
	use({
		"vim-airline/vim-airline", -- status line
		after = "gruvbox-material",
		event = "BufEnter",
	})
	use({
		"akinsho/bufferline.nvim", -- buffer line
		event = "BufEnter",
		config = function()
			require("plugins.bufferline")
		end,
	})
	use("airblade/vim-gitgutter") -- git diff in gutter
	use("mhinz/vim-startify") -- fancy start screen

	-- Navigation
	use({
		"kyazdani42/nvim-tree.lua", -- file tree
		event = "CursorHold",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("plugins.nvim_tree")
		end,
	})
	use({
		"simrat39/symbols-outline.nvim", -- LSP symbol tree
		config = function()
			require("plugins.symbols_outline")
		end,
	})
	use({
		{
			"nvim-telescope/telescope.nvim", -- fuzzy finder
			event = "CursorHold",
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
	use({ "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" }) -- quick nav
	use({ "andymass/vim-matchup", event = "VimEnter" }) -- extended % matching
	use("justinmk/vim-sneak") -- sneak motion
	use("unblevable/quick-scope") -- fast left-right movement (using f, F, t, T)

	-- Auto-completion and snippets
	use({
		{
			"hrsh7th/nvim-cmp", -- autocompletion
			event = "InsertEnter",
			requires = "onsails/lspkind-nvim", -- nice symbols for completion menu ,
			config = function()
				require("plugins.nvim_cmp")
			end,
		},
		{ "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" },
		{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
		{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
		{ "hrsh7th/cmp-path", after = "nvim-cmp" },
		{ "quangnguyen30192/cmp-nvim-ultisnips", after = "nvim-cmp" },
		{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
		{ "kristijanhusak/vim-dadbod-completion", requires = "tpope/vim-dadbod", after = "nvim-cmp" },
		{ "andersevenrud/cmp-tmux", after = "nvim-cmp" },
	})
	use({
		"windwp/nvim-autopairs", -- autoclose brackets etc
		event = "InsertCharPre",
		config = function()
			require("plugins.autopairs")
		end,
	})
	use("tpope/vim-endwise") -- wisely add end/endfunction/endif...
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
	use({
		"brennier/quicktex", -- lightweight snippets (most useful for latex math)
		config = function()
			require("plugins.quicktex")
		end,
	})
	use("mattn/emmet-vim") -- expand html abbreviations

	-- Language integration
	use({
		{
			"nvim-treesitter/nvim-treesitter", -- treesitter core
			event = "CursorHold",
			run = ":TSUpdate",
			config = function()
				require("plugins.treesitter")
			end,
		},
		{ "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" }, -- advanced text objects
		{ "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" }, -- context aware text objects
		{ "romgrk/nvim-treesitter-context", after = "nvim-treesitter" }, -- always show treesitter context
		{ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" }, -- colorize nested parentheses
		{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }, -- autoclose and -rename html tags
		{ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" }, -- autoset commentstring
		{ "nvim-treesitter/playground", after = "nvim-treesitter" }, -- explore treesitter
	})
	use({
		"neovim/nvim-lspconfig", -- LSP configurations
		event = "BufRead",
		after = "nvim-cmp",
		requires = {
			"williamboman/nvim-lsp-installer", -- LSP server installation helpers
			"ray-x/lsp_signature.nvim", -- show signature help while typing
			"b0o/schemastore.nvim", -- jsonls schema support
			"jose-elias-alvarez/nvim-lsp-ts-utils", -- better typescript lsp support
		},
		config = function()
			require("plugins.lsp_config")
		end,
	})
	use({ "lervag/vimtex", ft = "tex" }) -- LaTeX
	use("jamessan/vim-gnupg") -- transparent editing of gpg encrypted files

	-- Syntax highlighting
	use({
		"norcalli/nvim-colorizer.lua", -- highlight color strings (eg. #42AFFE)
		event = "CursorHold",
		config = function()
			require("plugins.colorizer")
		end,
	})
	use({ -- let's wait for https://github.com/nvim-treesitter/nvim-treesitter/issues/81
		"numirias/semshi", -- semantic highlighting for python
		config = "vim.cmd [[silent UpdateRemotePlugins]]",
	})
	use("Vimjas/vim-python-pep8-indent")
	use("kovetskiy/sxhkd-vim") -- sxhkdrc
	use("ericpruitt/tmux.vim") -- .tmux.conf
	use("ekalinin/Dockerfile.vim") -- Dockerfile
	use("raimon49/requirements.txt.vim") -- requirements.txt
	use("chr4/nginx.vim") -- nginx
	use("Glench/Vim-Jinja2-Syntax") -- jinja2

	-- Developer tools
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
	use({
		"dense-analysis/ale", -- linting and fixing
		config = function()
			require("plugins.ale")
		end,
	})
	use({
		"kkoomen/vim-doge", -- docstring generator
		run = function()
			vim.fn["doge#install"]()
		end,
		cmd = "DogeGenerate",
		config = function()
			require("plugins.doge")
		end,
	})
	use({
		"tpope/vim-fugitive", -- git integration
		requires = {
			"tpope/vim-rhubarb", -- github integration
			"tommcdo/vim-fubitive", -- bitbucket integration
		},
	})
	use("junegunn/gv.vim") -- git commit browser
	use("janko/vim-test") -- convenient test invocation
	use("tpope/vim-dispatch") -- asynchronously run jobs
	use("tpope/vim-tbone") -- tmux interaction
	use("tpope/vim-eunuch") -- unix helpers
	use({ "rhysd/git-messenger.vim", event = "BufRead" }) -- show git commit under cursor
	use("tpope/vim-projectionist") -- project-specific configurations
	use({
		"airblade/vim-rooter", -- autochdir to project root when opening files
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
	use({
		"b3nj5m1n/kommentary", -- comment stuff out
		event = "BufRead",
		config = function()
			require("kommentary.config").configure_language("default", {
				prefer_single_line_comments = true,
			})
		end,
	})
	use({ "kristijanhusak/vim-dadbod-ui", requires = "tpope/vim-dadbod" }) -- DB UI
	use("jpalardy/vim-slime") -- tmux repl
	use({ "jupyter-vim/jupyter-vim", ft = "python" }) -- jupyter notebook integration
	use({ "hanschen/vim-ipython-cell", ft = "python" }) -- execute ipython cells
	use({ "voldikss/vim-floaterm", event = "CursorHold" }) -- floating terminal
	use("windwp/nvim-spectre") -- search and replace
	use({
		"folke/trouble.nvim",
		config = function()
			require("plugins.trouble")
		end,
	}) -- lsp errors and diagnostics in quickfix
	use({
		"folke/todo-comments.nvim",
		config = function()
			require("plugins.trouble")
		end,
	}) -- highlight and find todo comments
	use("direnv/direnv.vim") -- direnv support
	use("ludovicchabant/vim-gutentags") -- automate ctags

	-- Text manipulation
	use("tpope/vim-repeat") -- repeat almost anything
	use({ "tpope/vim-surround", event = "BufRead" }) -- simple quoting/parenthesizing
	use({ "tpope/vim-jdaddy", ft = { "json" } }) -- json manipulation
	use({ "AndrewRadev/splitjoin.vim", event = "CursorHold" }) -- easily switch between single- and multi-line statements
	use({
		"AndrewRadev/switch.vim", -- toggle special words (true/false etc.)
		config = function()
			vim.g.switch_mapping = "-"
		end,
	})
	use("tommcdo/vim-lion") -- align text by some character
	use("dhruvasagar/vim-table-mode") -- simple table editing (e.g. in markdown)
	use("machakann/vim-swap") -- swap items in comma separated lists
	use({ "wellle/targets.vim", event = "BufRead" }) -- enhanced text objects

	-- Organization
	use({ "vimwiki/vimwiki", branch = "dev" }) -- personal wiki
	use("tools-life/taskwiki") -- vimwiki taskwarrior integration

	-- Miscellaneous
	use("tpope/vim-unimpaired") -- some useful keybindings
	use("tpope/vim-obsession") -- session management
	use("zhimsel/vim-stay") -- restore buffer views automaticaly
	use("dstein64/vim-startuptime") -- profile vim startup time
	use("ojroques/vim-oscyank") -- osc yank for clipboard interoperability

	-- Automatically set up your configuration after cloning packer.nvim
	if Packer_bootstrap then
		require("packer").sync()
	end
end)
