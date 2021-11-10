require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"typescript",
		"javascript",
		"python",
		"go",
		"jsdoc",
		"html",
		"css",
		"json",
		"lua",
		"bash",
		"rst",
		"toml",
		"vue",
		"query", -- for treesitter playground
	},
	highlight = {
		enable = true,
		disable = {
			"python",
		},
	},
	indent = {
		enable = true,
		disable = {
			"python",
		},
	},
	autopairs = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			},
		},
		move = {
			enable = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
		},
	},
	textsubjects = {
		enable = true,
		keymaps = {
			["."] = "textsubjects-smart",
			[";"] = "textsubjects-container-outer",
		},
	},
	rainbow = {
		enable = false, -- https://github.com/p00f/nvim-ts-rainbow/issues/5
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25,
		persist_queries = false,
	},
	autotag = {
		enable = true,
	},
	context_commentstring = {
		enable = true,
	},
	matchup = {
		enable = true,
	},
})
