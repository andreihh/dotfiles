return { -- Autocompletion
  "hrsh7th/nvim-cmp",
  event = { "InsertEnter", "CmdlineEnter" },
  cmd = { "CmpStatus" },
  dependencies = {
    -- Adds other completion capabilities.
    --  `nvim-cmp` does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",

    -- Snippets engine.
    "hrsh7th/vim-vsnip",
    "hrsh7th/vim-vsnip-integ",

    -- Snippets library.
    "rafamadriz/friendly-snippets",

    -- Pictograms and source annotations for completion items.
    "onsails/lspkind.nvim",
  },
  opts = function(_, opts)
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

    -- Don't automatically insert the selected item.
    local select_behavior = cmp.SelectBehavior.Select

    -- See `:help ins-completion`
    local mappings = {
      -- Select the next / previous item.
      ["<C-j>"] = {
        i = cmp.mapping.select_next_item({ behavior = select_behavior }),
        c = cmp.mapping.select_next_item({ behavior = select_behavior }),
      },
      ["<C-k>"] = {
        i = cmp.mapping.select_prev_item({ behavior = select_behavior }),
        c = cmp.mapping.select_prev_item({ behavior = select_behavior }),
      },

      -- Accept the selected completion.
      --  This will auto-import if your LSP supports it.
      --  This will expand snippets if the LSP sent a snippet.
      ["<tab>"] = {
        i = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({ select = true }),
      },

      -- Abort the completion.
      ["<C-e>"] = {
        i = cmp.mapping.abort(),
        c = cmp.mapping.abort(),
      },

      -- Manually trigger a completion from nvim-cmp.
      --  Generally you don't need this, because nvim-cmp will display
      --  completions whenever it has completion options available.
      ["<C-space>"] = {
        i = cmp.mapping.complete({}),
        c = cmp.mapping.complete({}),
      },

      -- Scroll the documentation window [u]p / [d]own.
      ["<C-u>"] = cmp.mapping.scroll_docs(-5),
      ["<C-d>"] = cmp.mapping.scroll_docs(5),

      -- Think of <c-l> as moving to the right of your snippet expansion.
      --  So if you have a snippet that's like:
      --  function $name($args)
      --    $body
      --  end
      --
      -- <c-l> will move you to the right of each of the expansion locations.
      -- <c-h> is similar, except moving you backwards.
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
    }

    return vim.tbl_deep_extend("force", opts, {
      completion = { completeopt = "menu,menuone,noselect" },
      snippet = {
        expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
        end,
      },
      formatting = {
        format = {
          -- Icons require a Nerd Font.
          mode = vim.g.nerd_font_enabled and "symbol_text" or "text",
          -- Set tags to highlight sources in the completion menu.
          menu = {
            nvim_lsp = "[LSP]",
            vsnip = "[Snip]",
            buffer = "[Buffer]",
            path = "[Path]",
            cmdline = "[Cmd]",
          },
        },
      },
      mapping = mappings,
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "vsnip" },
      }, {
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
  config = function(_, opts)
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    -- Apply the lspkind formatting function with the specified options.
    opts.formatting.format = lspkind.cmp_format(opts.formatting.format)

    cmp.setup(opts)

    cmp.setup.cmdline({ "/", "?" }, {
      mapping = opts.mapping,
      sources = cmp.config.sources({
        { name = "buffer" },
      }),
    })

    cmp.setup.cmdline(":", {
      mapping = opts.mapping,
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
}
