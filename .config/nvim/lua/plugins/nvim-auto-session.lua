return { -- Session management
  "rmagatti/auto-session",
  lazy = false, -- Ensure auto-loading
  keys = {
    {
      "ss",
      "<cmd>Autosession search<CR>",
      desc = "[S]ession [S]earch",
    },
    {
      "sD",
      "<cmd>Autosession delete<CR>",
      desc = "[S]ession [D]elete",
    },
    {
      "sS",
      "<cmd>SessionSave<CR>",
      desc = "[S]ession [S]ave",
    },
  },
  opts = {
    use_git_branch = true,
    -- Don't start sessions in root, home, or their direct children.
    suppressed_dirs = { "/", "/*", "~/", "~/*" },
  },
}
