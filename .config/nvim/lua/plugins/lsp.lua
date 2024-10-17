return {
  { -- Main LSP configuration
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim.
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP.
      "j-hui/fidget.nvim",

      -- Allows extra capabilities provided by nvim-cmp.
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- LSP servers and clients are able to communicate to each other what
      -- features they support.
      --  By default, Neovim doesn't support everything that is in the LSP
      --  specification. When you add nvim-cmp, luasnip, etc. Neovim now has
      --  *more* capabilities. So, we create new capabilities with nvim cmp, and
      --  then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      local lsp_opts = require("config.lsp")
      local servers = lsp_opts.servers or {}

      -- Ensure the servers and required tools are installed.
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run:
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require("mason").setup()
      require("mason-tool-installer").setup({
        ensure_installed = lsp_opts.ensure_installed or {},
      })

      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed by the
          -- server configuration above. Useful when disabling certain
          -- features of an LSP (for example, turning off formatting for
          -- ts_ls).
          server.capabilities = vim.tbl_deep_extend(
            "force",
            {},
            capabilities,
            server.capabilities or {}
          )
          require("lspconfig")[server_name].setup(server)
        end,
      })
    end,
  },
}
