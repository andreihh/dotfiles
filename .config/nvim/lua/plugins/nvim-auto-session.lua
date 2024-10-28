-- Session options recommended for the `auto-session` plugin.
vim.o.sessionoptions =
  "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
  { -- Session management
    "rmagatti/auto-session",
    lazy = false,
    keys = {
      {
        "sp",
        "<cmd>SessionSearch<CR>",
        desc = "[S]earch [P]roject sessions",
      },
    },
    config = true,
  },
}
