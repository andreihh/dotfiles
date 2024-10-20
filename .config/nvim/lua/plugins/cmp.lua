return {
  { -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Adds other completion capabilities.
      --  `nvim-cmp` does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",

      -- Snippets engine.
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",

      -- Snippets library.
      "rafamadriz/friendly-snippets",

      -- Pictograms and source annotations for completion items.
      "onsails/lspkind.nvim",
    },
    event = "InsertEnter",
    config = function()
      -- See `:help cmp`
      local cmp = require("cmp")

      -- Required to map vsnip commands.
      local function feedkey(key)
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes(key, true, true, true),
          "",
          false
        )
      end

      cmp.setup({
        completion = { completeopt = "menu,menuone,noselect" },

        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },

        formatting = {
          format = require("lspkind").cmp_format({
            -- Show symbols if you have a Nerd Font.
            mode = vim.g.nerd_font_enabled and "symbol_text" or "text",
            menu = require("config.lsp").completion_source_tags or {},
          }),
        },

        -- See `:help ins-completion`
        mapping = cmp.mapping.preset.insert({
          -- Select the [n]ext / [p]revious item.
          ["<C-n>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Select,
          }),
          ["<C-p>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Select,
          }),

          -- Scroll the documentation window [u]p / [d]own.
          ["<C-u>"] = cmp.mapping.scroll_docs(-5),
          ["<C-d>"] = cmp.mapping.scroll_docs(5),

          -- Accept the selected completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ["<tab>"] = cmp.mapping.confirm({ select = true }),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ["<C-space>"] = cmp.mapping.complete({}),

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion
          -- locations. <c-h> is similar, except moving you backwards.
          ["<C-l>"] = cmp.mapping(function()
            if vim.fn["vsnip#available"](1) == 1 then
              feedkey("<plug>(vsnip-expand-or-jump)")
            end
          end, { "i", "s" }),
          ["<C-h>"] = cmp.mapping(function()
            if vim.fn["vsnip#available"](-1) == 1 then
              feedkey("<plug>(vsnip-jump-prev)")
            end
          end, { "i", "s" }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "vsnip" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },
}
