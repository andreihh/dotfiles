return { -- AI agent, must extend `opts` with `provider` and `providers` config
  "yetone/avante.nvim",
  build = "make",
  keys = { { "<leader><leader>", mode = { "n", "x" }, desc = "AI" } },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    hints = { enabled = false }, -- Disable hints
    mappings = {
      ask = "<leader><leader>a",
      new_ask = "<leader><leader>n",
      edit = "<leader><leader>e",
      refresh = "<leader><leader>r",
      focus = "<leader><leader>f",
      stop = "<leader><leader>s",
      toggle = {
        default = "<leader><leader>t",
        debug = "<leader><leader>D",
        hint = "<leader><leader>H",
        suggestion = "<leader><leader>S",
        repomap = "<leader><leader>R",
      },
      sidebar = {
        remove_file = "dd",
        close_from_input = { normal = "q", insert = "<C-c>" },
      },
      files = {
        add_current = "<leader><leader>c",
        add_all_buffers = "<leader><leader>b",
      },
      select_model = "<leader><leader>?",
      select_history = "<leader><leader>h",
      confirm = { focus_window = "f" },
    },
  },
}
