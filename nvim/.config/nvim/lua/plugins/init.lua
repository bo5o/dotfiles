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
		config = function()
			require("plugins.indent_blankline")
		end,
	})
	use("vim-airline/vim-airline") -- status line
	use({
		"akinsho/bufferline.nvim", -- buffer line
		config = function()
			require("plugins.bufferline")
		end,
	})
	use("airblade/vim-gitgutter") -- git diff in gutter
	use("mhinz/vim-startify") -- fancy start screen

	-- Navigation
	use({
		"kyazdani42/nvim-tree.lua", -- file tree
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
		"nvim-telescope/telescope.nvim", -- fuzzy finder
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			"fhill2/telescope-ultisnips.nvim",
			"kyazdani42/nvim-web-devicons",
		},
		config = function()
			require("plugins.telescope")
		end,
	})
	use({ "ThePrimeagen/harpoon", requires = "nvim-lua/plenary.nvim" }) -- quick nav
	use({ "andymass/vim-matchup", event = "VimEnter" }) -- extended % matching
	use("justinmk/vim-sneak") -- sneak motion
	use("unblevable/quick-scope") -- fast left-right movement (using f, F, t, T)

	-- Auto-completion and snippets
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"quangnguyen30192/cmp-nvim-ultisnips",
			{ "kristijanhusak/vim-dadbod-completion", requires = "tpope/vim-dadbod" },
			{ "andersevenrud/compe-tmux", branch = "cmp" },
			"onsails/lspkind-nvim", -- nice symbols for completion menu
		},
		config = function()
			require("plugins.nvim_cmp")
		end,
	})
	use({
		"windwp/nvim-autopairs", -- autoclose brackets etc
		config = function()
			require("plugins.autopairs")
		end,
	})
	use("tpope/vim-endwise") -- wisely add end/endfunction/endif...
	use("SirVer/UltiSnips") -- snippet engine
	use("honza/vim-snippets") -- snippet collection
	use({
		"brennier/quicktex", -- lightweight snippets (most useful for latex math)
		config = function()
			require("plugins.quicktex")
		end,
	})
	use("mattn/emmet-vim") -- expand html abbreviations

	-- Language integration
	use({
		"nvim-treesitter/nvim-treesitter", -- treesitter core
		run = ":TSUpdate",
		requires = {
			"nvim-treesitter/nvim-treesitter-textobjects", -- advanced text objects
			"RRethy/nvim-treesitter-textsubjects", -- context aware text objects
			"romgrk/nvim-treesitter-context", -- always show treesitter context
			"p00f/nvim-ts-rainbow", -- colorize nested parentheses
			"windwp/nvim-ts-autotag", -- autoclose and -rename html tags
			"JoosepAlviste/nvim-ts-context-commentstring", -- autoset commentstring
			{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
		},
		config = function()
			require("plugins.treesitter")
		end,
	})
	use({
		"neovim/nvim-lspconfig", -- LSP configurations
		requires = {
			"williamboman/nvim-lsp-installer", -- LSP server installation helpers
			"ray-x/lsp_signature.nvim", -- show signature help while typing
			"b0o/schemastore.nvim", -- jsonls schema support
		},
		config = function()
			require("plugins.lsp_config")
		end,
	})
	use({ "lervag/vimtex", ft = "tex" }) -- LaTeX
	use({ "davidhalter/jedi-vim", ft = "python" }) -- python
	use("jamessan/vim-gnupg") -- transparent editing of gpg encrypted files

	-- Syntax highlighting
	use({
		"norcalli/nvim-colorizer.lua", -- highlight color strings (eg. #42AFFE)
		config = function()
			require("plugins.colorizer")
		end,
	})
	use({ -- let's wait for https://github.com/nvim-treesitter/nvim-treesitter/issues/81
		"numirias/semshi", -- semantic highlighting for python
		ft = "python",
		config = "vim.cmd [[UpdateRemotePlugins]]",
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
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		after = "nvim-lspconfig",
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
	use("rhysd/git-messenger.vim") -- show git commit under cursor
	use("tpope/vim-projectionist") -- project-specific configurations
	use("airblade/vim-rooter") -- autochdir to project root when opening files
	use({
		"b3nj5m1n/kommentary", -- comment stuff out
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
	use("voldikss/vim-floaterm") -- floating terminal
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
	use("tpope/vim-surround") -- simple quoting/parenthesizing
	use("tpope/vim-jdaddy") -- json manipulation
	use("AndrewRadev/splitjoin.vim") -- easily switch between single- and multi-line statements
	use("tommcdo/vim-lion") -- align text by some character
	use("dhruvasagar/vim-table-mode") -- simple table editing (e.g. in markdown)
	use("machakann/vim-swap") -- swap items in comma separated lists
	use("wellle/targets.vim") -- enhanced text objects

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
