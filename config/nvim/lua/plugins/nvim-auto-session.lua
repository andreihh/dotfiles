return { -- Session management
  "rmagatti/auto-session",
  lazy = false, -- Ensure auto-loading
  keys = {
    { "ss", "<cmd>Autosession search<CR>", desc = "[S]earch [S]ession" },
    { "dS", "<cmd>Autosession delete<CR>", desc = "[D]elete [S]ession" },
    { "<M-s>", "<cmd>SessionSave<CR>", desc = "[S]ave session" },
  },
  -- Don't start sessions in root, home, or their direct children.
  opts = { suppressed_dirs = { "/", "/*", "~/", "~/*" } },
}
