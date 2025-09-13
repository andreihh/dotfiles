return { -- Session management
  "rmagatti/auto-session",
  lazy = false, -- Ensure auto-loading
  cmd = "AutoSession",
  keys = {
    { "<leader>S", "<cmd>AutoSession search<CR>", desc = "[S]ession manager" },
    { "<M-s>", "<cmd>AutoSession save<CR>", desc = "[S]ave session" },
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
