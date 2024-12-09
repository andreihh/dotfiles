return { -- Autocompletion
  "saghen/blink.cmp",
  lazy = false, -- Lazy loading is handled internally
  version = "*", -- Download pre-built binaries for the latest release
  -- Provides snippets for the snippet source.
  dependencies = { "rafamadriz/friendly-snippets" },
  opts = {
    keymap = {
      preset = "default",
      ["<C-n>"] = { "snippet_forward", "select_next" },
      ["<C-p>"] = { "snippet_backward", "select_prev" },
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },
      ["<Tab>"] = { "select_and_accept", "fallback" },
      -- Disable unused mappings.
      ["<C-f>"] = {},
      ["<C-b>"] = {},
      ["<S-Tab>"] = {},
    },
    completion = {
      -- Don't trigger inside a snippet to avoid conflicting keymaps.
      trigger = { show_in_snippet = false },
      -- Always show documentation for selected item.
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 5,
        update_delays_ms = 10,
        treesitter_highlighting = vim.g.lsp_opts.treesitter_enabled,
      },
      menu = {
        draw = {
          treesitter = vim.g.lsp_opts.treesitter_enabled,
          columns = {
            -- Icons require a Nerd Font.
            { NerdFontEnabled() and "kind_icon" or "kind" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },
        },
      },
    },
    sources = {
      completion = {
        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, via `opts_extend`.
        enabled_providers = { "lsp", "snippets", "buffer", "path" },
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
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Property = "󰜢",
        Class = "󰠱",
        Interface = "",
        Struct = "󰙅",
        Module = "",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        EnumMember = "",
        Keyword = "󰌋",
        Constant = "󰏿",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰬛",
      },
    },
  },
  -- Allows extending the `enabled_providers` array elsewhere in your config
  -- without having to redefine it.
  opts_extend = { "sources.completion.enabled_providers" },
}
