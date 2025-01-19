return { -- LSP configuration
  "neovim/nvim-lspconfig",
  cond = not vim.tbl_contains(vim.v.argv, "-d"), -- Disable LSPs in diff mode
  dependencies = {
    { "j-hui/fidget.nvim", config = true }, -- Useful status updates for LSP
    -- Ensure the servers and required tools are installed.
    --  To check the current status of installed tools and/or manually install
    --  other tools, you can run:
    --    :Mason
    --
    --  You can press `g?` for help in this menu.
    { "williamboman/mason.nvim", config = true },
    { "williamboman/mason-lspconfig.nvim", config = true },
    { -- Automatically install LSPs and related tools to stdpath for Neovim.
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      opts = { ensure_installed = vim.g.lsp.ensure_installed },
    },

    "saghen/blink.cmp", -- Allows extra capabilities provided by `blink.cmp`
  },
  opts = { servers = vim.g.lsp.servers },
  config = function(_, opts)
    local lspconfig = require("lspconfig")
    local blink = require("blink.cmp")
    for server, config in pairs(opts.servers) do
      -- LSP servers and clients are able to communicate to each other what
      -- features they support.
      --  By default, Neovim doesn't support everything that is in the LSP
      --  specification. When you add `blink.cmp`, `luasnip`, etc. Neovim now
      --  has *more* capabilities. So, we create new capabilities with
      --  `blink.cmp`, and then broadcast that to the servers.
      --
      -- TODO: skip updating capabilities on Neovim 0.11+ and remove `blink.cmp`
      -- dependency once https://github.com/neovim/nvim-lspconfig/issues/3494
      -- is resolved. See:
      --  - https://github.com/Saghen/blink.cmp/pull/897
      --  - https://github.com/Saghen/blink.cmp/issues/987
      config.capabilities =
        blink.get_lsp_capabilities(config.capabilities or {})
      lspconfig[server].setup(config)
    end
  end,
}
