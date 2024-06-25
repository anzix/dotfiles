local fn = vim.fn

-- Автоматически устанавливать packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Использовать всплывающие окно packer
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return require("packer").startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself

	use({
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x", -- fuzzy finder на стероидах
	})

	use("nvim-lua/plenary.nvim")
	use({
		"folke/todo-comments.nvim", -- Быстрое добавление TODO, PREF, NOTE, FIX, WARNING и т.д
		requires = "nvim-lua/plenary.nvim",
	})
	use("folke/tokyonight.nvim") -- Тема

	-- use("theprimeagen/harpoon") -- Быстрое переключение

	use({
		"nvim-treesitter/nvim-treesitter", -- Продвинутый синтаксис кода
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	})

	use({
		"NvChad/nvim-colorizer.lua", -- Показывает hex палитру цветов
		config = function()
			require("colorizer").setup({
				user_default_options = {
					tailwind = true,
				},
			})
		end,
	})

	-- Добавляет направляющие отступов ко всем строкам (включая пустые строки)
	use("lukas-reineke/indent-blankline.nvim")

	use("nvim-tree/nvim-web-devicons")

	use("SidOfc/carbon.nvim")

	use("nvim-lualine/lualine.nvim")

	use({

		-- LSP Support
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-calc" },
		-- { "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },

		-- Snippets
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },
	})

	-- formatting & linting
	use("nvimtools/none-ls.nvim") -- Обратно совместим с null-ls
	use("jay-babu/mason-null-ls.nvim") -- Есть совместимость с none-ls

	-- Debugger
	use("mfussenegger/nvim-dap")
	use("rcarriga/nvim-dap-ui")
	use("nvim-neotest/nvim-nio")
	use("jay-babu/mason-nvim-dap.nvim")

	use({
		"ruifm/gitlinker.nvim",
		config = function()
			require("gitlinker").setup({
				keys = {
					"<leader>gy",
					'<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
				},
			})
		end,
	})

	use({
		"numToStr/Comment.nvim", -- Быстрое комментирование юзая бинд gcc
		config = function()
			require("Comment").setup()
		end,
	})

	use({
		"windwp/nvim-autopairs", -- Удобная работа с кавычками
		config = function()
			require("nvim-autopairs").setup({})
		end,
	})

	use({
		"uga-rosa/translate.nvim", -- Переводчик текста
		config = function()
			require("translate").setup({})
		end,
	})

	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})

	use("lewis6991/gitsigns.nvim") -- Показывает изменённые строки кода/конфига

	use("mbbill/undotree") -- Показывает дерево истории undo и redo

	use("ntpeters/vim-better-whitespace") -- Показывает пробелы (vim-scripts)

	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
