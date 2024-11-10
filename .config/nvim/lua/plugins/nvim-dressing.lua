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
          ["<C-j>"] = "HistoryPrev",
          ["<C-k>"] = "HistoryNext",
          ["<tab>"] = "Confirm",
          ["<C-e>"] = "Close",
        },
        v = {
          ["<C-e>"] = "Close",
          ["<esc>"] = false,
        },
      },
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
