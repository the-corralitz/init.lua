return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason-org/mason-lspconfig.nvim",
			"mason-org/mason.nvim",
			"saghen/blink.cmp",
		},

		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			vim.lsp.config("*", {
				root_marking = { ".git" },
			})

			vim.lsp.config("lua_ls", {
				capabilities = capabilities,
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"html",
					"cssls",
					"tailwindcss",
				},
				automatic_installation = true,
				automatic_enable = true,
			})

			vim.diagnostic.config({
				virtual_text = true,
				severity_sort = true,
				float = {
					style = "minimal",
					border = "rounded",
					source = "if_many",
					header = "",
					prefix = "",
				},
			})

			local orig = vim.lsp.util.open_floating_preview
			---@diagnostic disable-next-line: duplicate-set-field
			function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
				opts = opts or {}
				opts.border = opts.border or "rounded"
				opts.max_width = opts.max_width or 80
				opts.max_height = opts.max_height or 24
				opts.wrap = opts.wrap ~= false
				return orig(contents, syntax, opts, ...)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("my.lsp", {}),
				callback = function(args)
					local buf = args.buf
					local map = function(mode, lhs, rhs)
						vim.keymap.set(mode, lhs, rhs, { buffer = buf })
					end

					map("n", "K", vim.lsp.buf.hover)
					map("n", "gd", vim.lsp.buf.definition)
					map("n", "gD", vim.lsp.buf.declaration)
					map("n", "gi", vim.lsp.buf.implementation)
					map("n", "go", vim.lsp.buf.type_definition)
					map("n", "gr", vim.lsp.buf.references)
					map("n", "gs", vim.lsp.buf.signature_help)
					map("n", "gl", vim.diagnostic.open_float)
					map("n", "<F2>", vim.lsp.buf.rename)
					map({ "n", "x" }, "<F3>", function()
						vim.lsp.buf.format({ async = true })
					end)
					map("n", "<F4>", vim.lsp.buf.code_action)
				end,
			})
		end,
	},
}
