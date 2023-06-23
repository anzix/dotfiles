-- Автозапонения
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
	return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
	return
end


local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- Активирует сниппеты
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	experimental = {
		ghost_text = false, -- подсвечивание автозаполнения
	},
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
			-- require("snippy").expand_snippet(args.body) -- For `snippy` users.
			-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
		end,
	},
	mapping = cmp.mapping.preset.insert({
		-- scroll up and down in the completion documentation
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		-- navigate items on the list
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),
	sources = {
		{ name = "nvim_lsp" },
		-- { name = 'nvim_lsp_signature_help' }, -- display function signatures with current parameter emphasized
		{ name = "nvim_lua" }, -- complete neovim's Lua runtime API such vim.lsp.*
		{ name = "luasnip" }, -- For luasnip users.
		{ name = "path" }, -- (cmp-path) Автозавершения путей Linux
		{
			name = "buffer", -- (cmp-buffer)
			option = {
				-- Избегать случайного запуска на больших файлах
				get_bufnrs = function()
					local buf = vim.api.nvim_get_current_buf()
					local byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
					if byte_size > 1024 * 1024 then -- Максимум 1 mb
						return {}
					end
					return { buf }
				end,
			},
		},
		{ name = "calc" }, -- (cmp-calc) source for math calculation
	},
})

vim.diagnostic.config({
	virtual_text = true,
})
