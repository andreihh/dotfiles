return { -- Better core input and select UI
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      mappings = {
        n = {
          ["<tab>"] = "Confirm",
          ["<C-e>"] = "Close",
        },
        i = {
          ["<C-n>"] = "HistoryNext",
          ["<C-p>"] = "HistoryPrev",
          ["<tab>"] = "Confirm",
          ["<C-e>"] = "Close",
        },
        v = {
          ["<C-e>"] = "Close",
          ["<esc>"] = false,
        },
      },
      win_options = { listchars = "precedes:◀,extends:▶" },
    },
    -- Uses Telescope, `fzf-lua`, or `fzf` if installed.
    select = {
      mappings = {
        ["<esc>"] = "Close",
        ["<tab>"] = "Confirm",
      },
    },
  },
}
