return { -- Session management
  "rmagatti/auto-session",
  lazy = false, -- Ensure auto-loading
  keys = {
    { "<leader>S", "<cmd>Autosession search<CR>", desc = "[S]ession manager" },
    { "<M-s>", "<cmd>SessionSave<CR>", desc = "[S]ave session" },
    { "dS", "<cmd>Autosession delete<CR>", desc = "[D]elete [S]ession" },
  },
  -- Don't start sessions in root, home, or their direct children.
  opts = { suppressed_dirs = { "/", "/*", "~/", "~/*" } },
}
