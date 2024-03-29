local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

--Set statusbar
lualine.setup({
	options = {
		component_separators = "|",
		section_separators = "",
	},
	tabline = {
		lualine_a = { "buffers" },
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff", "diagnostics" },
		lualine_c = { "filename" },
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	extensions = { "fugitive", "quickfix" },
})
