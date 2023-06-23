local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

local fmt = null_ls.builtins.formatting
local dgn = null_ls.builtins.diagnostics
local cda = null_ls.builtins.code_actions

-- :NullLsInfo для обозначения что конкретно используется
-- и что доступно для конкретного языка
null_ls.setup({
	sources = {

		-- Примеры: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
		-- Встройщики: https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md

		-- Форматирование
		-- Manpage: https://github.com/mvdan/sh/blob/master/cmd/shfmt/shfmt.1.scd
		fmt.shfmt, --sh/bash
		fmt.prettier, -- markdown
		fmt.prettier.with({
			filetypes = { "html", "json", "yaml", "markdown", "javascript", "typescript" },
		}),
		-- fmt.eslint_d, -- javascript
		fmt.stylua,
		fmt.djlint, -- htmldjango
		-- fmt.rustfmt,
		-- python
		-- fmt.yapf,
		-- fmt.isort,

		-- Диагностика
		dgn.markdownlint.with({
			-- Отключает Line length (MD013)
			extra_args = { "--disable", "MD013" },
		}),
		-- dgn.eslint_d, -- javascript
		-- dgn.pylint.with({
		-- 	method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
		-- }),
		dgn.tidy, -- sudo pacman -S tidy
		dgn.djlint, -- htmldjango
		-- Code Actions
		-- cda.eslint_d,
		cda.shellcheck,
	},
	-- Включает форматирование при сохранении
	-- Закоментируйте если не нужно
	-- on_attach = function(client, bufnr)
	-- 	if client.supports_method("textDocument/formatting") then
	-- 		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	-- 		vim.api.nvim_create_autocmd("BufWritePre", {
	-- 			group = augroup,
	-- 			buffer = bufnr,
	-- 			callback = function()
	-- 				vim.lsp.buf.format({ bufnr = bufnr })
	-- 			end,
	-- 		})
	-- 	end
	-- end,
})
