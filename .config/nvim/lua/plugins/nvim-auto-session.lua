-- Session options recommended for the `auto-session` plugin.
vim.o.sessionoptions =
  "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return { -- Session management
  "rmagatti/auto-session",
  lazy = false, -- Ensure auto-loading
  keys = {
    {
      "ss",
      "<cmd>Autosession search<CR>",
      desc = "[S]earch [S]ession",
    },
    {
      "sD",
      "<cmd>Autosession delete<CR>",
      desc = "[S]ession [D]elete",
    },
  },
  -- Don't start sessions in the root, home, or their direct children.
  opts = { suppressed_dirs = { "/", "/*", "~/", "~/*" } },
}
