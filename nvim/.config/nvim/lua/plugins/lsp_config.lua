local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	-- Mappings.
	local opts = { noremap = true, silent = true }
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "<leader>K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<leader>cld", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<leader>cll", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "<leader>clL", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
	buf_set_keymap("n", "<leader>clf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ru", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "[g", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "]g", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

	-- Configure signature help for completion
	require("lsp_signature").on_attach({
		bind = true,
		hint_enable = false,
		hi_parameter = "Search",
	})
end

-- Configure lua language server for neovim development
local lua_settings = {
	Lua = {
		runtime = {
			-- LuaJIT in the case of Neovim
			version = "LuaJIT",
			path = vim.split(package.path, ";"),
		},
		diagnostics = {
			-- Get the language server to recognize the `vim` global
			globals = { "vim" },
		},
		workspace = {
			-- Make the server aware of Neovim runtime files
			library = {
				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
			},
		},
	},
}

local json_settings = {
	json = {
		schemas = require("schemastore").json.schemas(),
	},
}

local lsp_installer = require("nvim-lsp-installer")

-- Register a handler that will be called for all installed servers.
lsp_installer.on_server_ready(function(server)
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	local opts = { on_attach = on_attach, capabilities = capabilities }

	if server.name == "sumneko_lua" then
		opts.settings = lua_settings
	elseif server.name == "jsonls" then
		opts.settings = json_settings
	elseif server.name == "volar" then
		-- take over mode
		opts.filetypes = {
			"typescript",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"vue",
			"json",
		}
		opts.on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end
	elseif server.name == "tsserver" then
		opts.init_options = require("nvim-lsp-ts-utils").init_options
		opts.on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			-- let eslint/prettier handle formatting
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false

			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup({
				debug = false,
				disable_commands = false,
				enable_import_on_completion = false,

				import_all_timeout = 5000, -- ms
				import_all_priorities = {
					same_file = 1, -- add to existing import statement
					local_files = 2, -- git files or files with relative path markers
					buffer_content = 3, -- loaded buffer content
					buffers = 4, -- loaded buffer names
				},
				import_all_scan_buffers = 100,
				import_all_select_source = false,

				filter_out_diagnostics_by_severity = {},
				filter_out_diagnostics_by_code = {},

				auto_inlay_hints = true,
				inlay_hints_highlight = "Comment",

				update_imports_on_move = false,
				require_confirmation_on_move = false,
				watch_dir = nil,
			})

			-- required to fix code action ranges and filter diagnostics
			ts_utils.setup_client(client)

			local map_opts = { silent = true }
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>clm", ":TSLspRenameFile<CR>", map_opts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>clI", ":TSLspImportAll<CR>", map_opts)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>clO", ":TSLspOrganize<CR>", map_opts)
		end
	end

	server:setup(opts)
end)

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
