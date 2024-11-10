return { -- Highlight and jump to references, Lazygit, handle big files, etc.
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "[r",
      function()
        Snacks.words.jump(-1, true)
      end,
      desc = "Jump to previous [R]eference",
    },
    {
      "]r",
      function()
        Snacks.words.jump(1, true)
      end,
      desc = "Jump to next [R]eference",
    },
    {
      "<leader>H",
      function()
        Snacks.toggle.inlay_hints():toggle()
      end,
      desc = "Toggle inlay [H]ints",
    },
    {
      "<leader>T",
      function()
        Snacks.toggle.treesitter():toggle()
      end,
      desc = "Toggle [T]reesitter",
    },
    {
      "gb",
      function()
        Snacks.git.blame_line()
      end,
      desc = "[G]oto Git [B]lame",
    },
    {
      "gG",
      function()
        Snacks.lazygit.open()
      end,
      desc = "[G]oto Lazy[G]it",
    },
  },
  dependencies = {
    -- Icons require a Nerd Font.
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.nerd_font_enabled },
  },
  opts = {
    -- Disable Treesitter, LSP, folds, undo, etc. on big files.
    bigfile = {
      -- Mark files over 2 MiB as big.
      size = 2 * 1024 * 1024,
      setup = function(ctx)
        vim.opt_local.swapfile = false
        vim.opt_local.foldmethod = "manual"
        vim.opt_local.undolevels = -1
        vim.opt_local.undoreload = 0
        vim.opt_local.list = false
        vim.schedule(function()
          vim.bo[ctx.buf].syntax = ctx.ft
          vim.bo[ctx.buf].commentstring =
            vim.filetype.get_option(ctx.ft, "commentstring")
        end)
      end,
    },
    -- Highlighting and jumping to references.
    words = { notify_end = false },
    -- Disable unused features.
    notifier = { enabled = false },
    quickfile = { enabled = false },
    statuscolumn = { enabled = false },
  },
}
