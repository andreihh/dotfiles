return {
  { -- Autocompletion
    "saghen/blink.cmp",
    version = "*", -- Download pre-built binaries for the latest release
    cmd = "BlinkCmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = { "rafamadriz/friendly-snippets" }, -- Snippets library
    opts = {
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-j>"] = { "select_next" },
        ["<C-k>"] = { "select_prev" },
        ["<C-h>"] = { "snippet_backward" },
        ["<C-l>"] = { "snippet_forward" },
        ["<C-u>"] = { "scroll_documentation_up" },
        ["<C-d>"] = { "scroll_documentation_down" },
        ["<tab>"] = { "select_and_accept", "fallback" },
        ["<C-e>"] = { "cancel" },
      },
      completion = {
        -- Don't automatically insert selected item.
        list = { selection = { auto_insert = false } },
        -- Automatically show documentation for selected item.
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 5,
          treesitter_highlighting = vim.g.lsp.treesitter_enabled,
        },
        menu = {
          draw = {
            -- Enable Treesitter rendering only for LSP items.
            treesitter = vim.g.lsp.treesitter_enabled and { "lsp" } or {},
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
          },
        },
      },
      appearance = {
        -- Adjusts spacing to ensure icons are aligned.
        nerd_font_variant = "normal",
        kind_icons = { -- See LSP `CompletionItemKind` specification
          Text = "󰉿", -- `nf-md-format_size`
          Method = "󰊕", -- `nf-md-function`
          Function = "󰊕", -- `nf-md-function`
          Constructor = "󰒓", -- `nf-md-cog`
          Field = "󰓹", -- `nf-md-tag`
          Variable = "󰀫", -- `nf-md-alpha`
          Class = "󰠱", -- `nf-md-shape`
          Interface = "󰒪", -- `nf-md-sitemap`
          Module = "", -- `nf-oct-package`
          Property = "󰓹", -- `nf-md-tag`
          Unit = "󰑭", -- `nf-md-ruler`
          Value = "󰎠", -- `nf-md-numeric`
          Enum = "", -- `nf-fa-sort_alpha_asc`
          Keyword = "󰌋", -- `nf-md-key_variant`
          Snippet = "", -- `nf-oct-code`
          Color = "󰏘", -- `nf-md-palette`
          File = "󰈙", -- `nf-md-file_document`
          Reference = "", -- `nf-cod-references`
          Folder = "󰉋", -- `nf-md-folder`
          EnumMember = "", -- `nf-fa-sort_alpha_asc`
          Constant = "󰏿", -- `nf-md-pi`
          Struct = "󰙅", -- `nf-md-file_tree`
          Event = "", -- `nf-fa-bolt`
          Operator = "󰆕", -- `nf-md-contrast`
          TypeParameter = "󰗴", -- `nf-md-format_title`
        },
      },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
    -- Allows extending the `sources.default` array elsewhere in your config
    -- without having to redefine it.
    opts_extend = { "sources.default" },
    -- Extend providers with the following properties:
    --  @field compat boolean Set up as `blink.compat` source if `true`
    --  @field kind string Use custom completion item kind
    --  @field kind_icon string Use custom completion item kind icon
    -- NOTE: `kind` and `kind_icon` must both be either set or unset.
    config = function(_, opts)
      local CompletionItemKind = require("blink.cmp.types").CompletionItemKind

      for name, provider in pairs(opts.sources.providers or {}) do
        if provider.compat then
          -- Set up `blink.compat` source.
          provider.opts = provider.opts or {}
          provider.opts.cmp_name = name
          provider.name = provider.name or name
          provider.module = "blink.compat.source"
        end

        if provider.kind then
          -- Register custom completion item kind and icon for source.
          local kind_idx = #CompletionItemKind + 1
          CompletionItemKind[kind_idx] = provider.kind
          CompletionItemKind[provider.kind] = kind_idx
          opts.appearance.kind_icons[provider.kind] = provider.kind_icon

          -- Use completion item kind for source.
          local transform_items = provider.transform_items
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = kind_idx
            end
            return items
          end

          -- Unset custom properties to pass `blink.cmp` validation.
          provider.compat = nil
          provider.kind = nil
          provider.kind_icon = nil
        end
      end

      require("blink.cmp").setup(opts)
    end,
  },
  { -- Compatibility module for `nvim-cmp` sources used in `blink.cmp`
    "saghen/blink.compat",
    version = "*", -- Match `blink.cmp` version
    lazy = true, -- Will be loaded automatically when required by `blink.cmp`
    config = true,
  },
}
