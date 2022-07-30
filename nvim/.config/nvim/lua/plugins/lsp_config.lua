local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require("lspconfig")
local cmp_lsp = require("cmp_nvim_lsp")
local lsp_signature = require("lsp_signature")

local function create_capabilities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = cmp_lsp.update_capabilities(capabilities)
	return cmp_lsp.update_capabilities(capabilities)
end

local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]g", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "<leader>lwa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>lwr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>lwl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>ld", vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "<leader>ru", vim.lsp.buf.references, bufopts)
	vim.keymap.set("n", "<leader>lf", vim.lsp.buf.formatting, bufopts)
	vim.keymap.set("n", "gr", "<cmd>TroubleToggle lsp_references<CR>", bufopts)

	-- Configure signature help for completion
	lsp_signature.on_attach({
		bind = true,
		hint_enable = false,
		hi_parameter = "Search",
	})
end

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
	on_attach = on_attach,
	capabilities = create_capabilities(),
	flags = {
		debounce_text_changes = 300,
	},
})

mason.setup()
mason_lspconfig.setup()
mason_lspconfig.setup_handlers({
	function(server_name) -- default handler
		lspconfig[server_name].setup({})
	end,
	["sumneko_lua"] = function()
		lspconfig.sumneko_lua.setup({
			settings = {
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
			},
		})
	end,
	["jsonls"] = function()
		lspconfig.jsonls.setup({
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
				},
			},
		})
	end,
	["yamlls"] = function()
		lspconfig.yamlls.setup({
			settings = {
				yaml = {
					hover = true,
					completion = true,
					validate = true,
					schemas = require("schemastore").json.schemas(),
				},
			},
		})
	end,
	["lemminx"] = function()
		lspconfig.lemminx.setup({
			init_options = {
				settings = {
					xml = {
						format = {
							splitAttributes = true,
						},
					},
				},
			},
		})
	end,
	["volar"] = function()
		lspconfig.volar.setup({
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false
			end,
		})
	end,
	["jedi_language_server"] = function()
		lspconfig.jedi_language_server.setup({
			init_options = {
				diagnostics = { enable = false },
			},
		})
	end,
	["tsserver"] = function()
		local nvim_ts_utils = require("nvim-lsp-ts-utils")
		lspconfig.tsserver.setup({
			init_options = nvim_ts_utils.init_options,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				-- let eslint/prettier handle formatting
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false

				nvim_ts_utils.setup({
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
				nvim_ts_utils.setup_client(client)

				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				vim.keymap.set("n", "<leader>lm", "<cmd>TSLspRenameFile<cr>", bufopts)
				vim.keymap.set("n", "<leader>lI", "<cmd>TSLspImportAll<cr>", bufopts)
				vim.keymap.set("n", "<leader>lo", "<cmd>TSLspOrganize<cr>", bufopts)
			end,
		})
	end,
})

local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
