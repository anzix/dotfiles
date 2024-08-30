return {
   "danymat/neogen",
   dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
   },
   cmd = "Neogen",
   keys = {
      {
         -- Generate documentation for the current position.
         "<leader>cn",
         function()
            require("neogen").generate()
         end,
         desc = "Generate Annotations (Neogen)",
      },
      {
         -- Generate documentation for the current function.
         "<leader>nf",
         function()
            require('neogen').generate({ type = 'func' })
         end,
         desc = "Generate function docs",
      },
      {
         -- Generate documentation for the current class.
         "<leader>ns",
         function()
            require('neogen').generate({ type = 'class' })
         end,
         desc = "Generate struct docs",
      },
      {
         -- Generate documentation for the current type.
         "<leader>nt",
         function()
            require('neogen').generate({ type = 'type' })
         end,
         desc = "Generate type docs",
      },
      {
         -- Generate documentation for the current file.
         "<leader>nv",
         function()
            require('neogen').generate({ type = 'file' })
         end,
         desc = "Generate file docs",
      },
   },
   config = function()
      local neogen = require("neogen")
      neogen.setup({
         snippet_engine = "luasnip",
         languages = {
            lua = {
               template = {
                  annotation_convention = "emmylua",
               },
            },
            c = {
               template = {
                  annotation_convention = "doxygen",
               },
            },
            cpp = {
               template = {
                  annotation_convention = "doxygen",
               },
            },
         },
      })
   end,
   -- config = function()
   --   local neogen = require("neogen")
   --   neogen.setup({
   --     -- took this snipped from lazyvim's documentation
   --     opts = function(_, opts)
   --       if opts.snippet_engine ~= nil then
   --         return
   --       end
   --       local map = {
   --         ["LuaSnip"] = "luasnip",
   --         ["nvim-snippy"] = "snippy",
   --         ["vim-vsnip"] = "vsnip",
   --       }
   --       for plugin, engine in pairs(map) do
   --         if vim.fn.exists("*" .. plugin) == 1 then
   --           opts.snippet_engine = engine
   --         end
   --       end
   --       if vim.snippet then
   --         opts.snippet_engine = "nvim"
   --       end
   --     end,
   --     -- input_after_comment = true,

   --   })
   -- end,
}

