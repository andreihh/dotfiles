-- Session options recommended for the `auto-session` plugin.
vim.o.sessionoptions =
  "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

return {
  { -- Session management
    "rmagatti/auto-session",
    lazy = false,
    keys = {
      {
        "ss",
        "<cmd>SessionSearch<CR>",
        desc = "[S]earch [S]essions",
      },
    },
    opts = { session_lens = { load_on_setup = false } },
  },
}
