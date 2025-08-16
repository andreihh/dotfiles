return { -- Session management
  "rmagatti/auto-session",
  lazy = false, -- Ensure auto-loading
  keys = {
    { "<leader>S", "<cmd>Autosession search<CR>", desc = "[S]ession manager" },
    { "<M-s>", "<cmd>SessionSave<CR>", desc = "[S]ave session" },
  },
  opts = {
    session_lens = {
      picker = "fzf", -- Ensure session manager uses `fzf-lua`
      mappings = { -- Match `fzf-lua` keymaps
        delete_session = { "i", "<C-x>" },
      },
    },
    -- Don't start sessions in root, home, or their direct children.
    suppressed_dirs = { "/", "/*", "~/", "~/*" },
  },
}
