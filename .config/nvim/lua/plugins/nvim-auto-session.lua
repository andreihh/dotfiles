-- Session options recommended for the `auto-session` plugin.
--  Don't save unloaded and hidden buffers.
vim.o.sessionoptions =
  "blank,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

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
