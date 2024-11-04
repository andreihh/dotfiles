local lsp_opts = require("config.lsp")

return { -- LSP configuration
  "neovim/nvim-lspconfig",
  dependencies = {
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
      opts = { ensure_installed = lsp_opts.ensure_installed or {} },
    },

    -- Allows extra capabilities provided by nvim-cmp.
    "hrsh7th/cmp-nvim-lsp",

    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim", config = true },
  },
  opts = { servers = lsp_opts.servers or {} },
  config = function(_, opts)
    -- LSP servers and clients are able to communicate to each other what
    -- features they support.
    --  By default, Neovim doesn't support everything that is in the LSP
    --  specification. When you add nvim-cmp, luasnip, etc. Neovim now has
    --  *more* capabilities. So, we create new capabilities with nvim cmp, and
    --  then broadcast that to the servers.
    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )

    local lspconfig = require("lspconfig")
    for server_name, server_opts in pairs(opts.servers or {}) do
      -- This handles overriding only values explicitly passed by the server
      -- configuration. Useful when disabling certain features of an LSP (for
      -- example, turning off formatting for ts_ls).
      server_opts.capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        server_opts.capabilities or {}
      )
      lspconfig[server_name].setup(server_opts)
    end
  end,
}
