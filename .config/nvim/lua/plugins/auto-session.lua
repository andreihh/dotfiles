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
