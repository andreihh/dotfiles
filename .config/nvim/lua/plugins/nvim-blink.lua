return { -- Autocompletion
  "saghen/blink.cmp",
  version = "*", -- Download pre-built binaries for the latest release
  event = { "InsertEnter", "CmdlineEnter" },
  -- Provides snippets for the snippet source.
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    keymap = {
      preset = "none",
      ["<C-space>"] = { "show" },
      ["<C-j>"] = { "select_next" },
      ["<C-k>"] = { "select_prev" },
      ["<C-h>"] = { "snippet_backward" },
      ["<C-l>"] = { "snippet_forward" },
      ["<C-u>"] = { "scroll_documentation_up" },
      ["<C-d>"] = { "scroll_documentation_down" },
      ["<Tab>"] = { "select_and_accept", "fallback" },
      ["<C-e>"] = { "cancel" },
    },
    completion = {
      -- Always show documentation for selected item.
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 50,
        treesitter_highlighting = vim.g.lsp.treesitter_enabled,
      },
      menu = {
        draw = {
          -- Enable Treesitter rendering only for LSP items.
          treesitter = vim.g.lsp.treesitter_enabled and { "lsp" } or {},
          columns = {
            -- Icons require a Nerd Font.
            { NerdFontEnabled() and "kind_icon" or "kind" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },
        },
      },
    },
    appearance = {
      -- Sets the fallback highlight groups to `nvim-cmp` highlight groups.
      -- Useful for when your theme doesn't support `blink.cmp`. Will be removed
      -- in a future release.
      use_nvim_cmp_as_default = true,
      -- Adjusts spacing to ensure icons are aligned.
      nerd_font_variant = "normal",
      kind_icons = {
        Text = "󰉿", -- `nf-md-format_size`
        Method = "󰊕", -- `nf-md-function`
        Function = "󰊕", -- `nf-md-function`
        Constructor = "", -- `nf-oct-gear`
        Field = "󰜢", -- `nf-md-tag_plus`
        Variable = "󰀫", -- `nf-md-alpha`
        Property = "󰜢", -- `nf-md-tag_plus`
        Class = "󰠱", -- `nf-md-shape`
        Interface = "", -- `nf-fa-sitemap`
        Struct = "󰙅", -- `nf-md-file_tree`
        Module = "", -- `nf-oct-package`
        Unit = "󰑭", -- `nf-md-ruler`
        Value = "󰎠", -- `nf-md-numeric`
        Enum = "", -- `nf-fa-sort_alpha_asc`
        EnumMember = "", -- `nf-fa-sort_alpha_asc`
        Keyword = "󰌋", -- `nf-md-key_variant`
        Constant = "󰏿", -- `nf-md-pi`
        Snippet = "", -- `nf-oct-code`
        Color = "󰏘", -- `nf-md-palette`
        File = "󰈙", -- `nf-md-file_document`
        Reference = "󰈇", -- `nf-md-export`
        Folder = "󰉋", -- `nf-md-folder`
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
}
