return {
   "iamcco/markdown-preview.nvim", -- Быстрый предпросмотр Markdown в браузере
   -- TODO: расмотреть замену, так как этот начинает не работать и устаревать
   -- Возможна замена, без браузера НО довольно интересно
   -- https://github.com/MeanderingProgrammer/render-markdown.nvim
   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
   build = "cd app && yarn install",
   init = function()
      vim.g.mkdp_filetypes = { "markdown" }
   end,
   ft = { "markdown" },
   keys = {
      { "<leader>pv", ":MarkdownPreviewToggle", desc = "MD: [P]re[v]iew Markdown" }
   },
   config = function()
      -- Не закрывайте вкладку предварительного просмотра при переключении на другие буферы
      vim.g.mkdp_auto_close = 0
   end

}
