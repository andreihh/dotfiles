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
      opts = { ensure_installed = vim.g.lsp_opts.ensure_installed or {} },
    },

    "saghen/blink.cmp", -- Allows extra capabilities provided by `blink.cmp`

    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim", config = true },
  },
  opts = { servers = vim.g.lsp_opts.servers or {} },
  config = function(_, opts)
    -- Define command to display attached LSP capabilities.
    vim.api.nvim_create_user_command("LspCapabilities", function()
      local clients =
        vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
      for _, client in pairs(clients) do
        vim.print("LSP capabilities for server " .. client.name .. ":")
        vim.print(client.server_capabilities)
      end
    end, { desc = "Display the attached LSP capabilities" })

    local lspconfig = require("lspconfig")
    for server_name, server_opts in pairs(opts.servers or {}) do
      -- LSP servers and clients are able to communicate to each other what
      -- features they support.
      --  By default, Neovim doesn't support everything that is in the LSP
      --  specification. When you add `blink.cmp`, `luasnip`, etc. Neovim now
      --  has *more* capabilities. So, we create new capabilities with
      --  `blink.cmp`, and then broadcast that to the servers.
      server_opts.capabilities = require("blink.cmp").get_lsp_capabilities(
        server_opts.capabilities or {}
      )
      lspconfig[server_name].setup(server_opts)
    end
  end,
}
