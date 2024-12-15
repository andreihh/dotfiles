return { -- Highlight and jump to references, Lazygit, handle big files, etc.
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "<C-z>",
      function()
        Snacks.zen.zoom()
      end,
      "[Z]oom window",
    },
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
      "<leader>b",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Open Git [B]lame",
    },
    {
      "<leader>g",
      function()
        Snacks.lazygit.open()
      end,
      desc = "Open Lazy[G]it",
    },
  },
  dependencies = {
    -- Icons require a Nerd Font.
    { "nvim-tree/nvim-web-devicons", cond = NerdFontEnabled() },
  },
  opts = {
    -- Disable Treesitter, LSP, folds, undo, etc. on big files.
    bigfile = {
      -- Mark big files as configured (default is over 1 MiB).
      size = vim.g.lsp_opts.bigfile_size or (1024 * 1024),
      setup = function(ctx)
        vim.opt_local.swapfile = false
        vim.opt_local.foldmethod = "manual"
        vim.opt_local.undolevels = -1
        vim.opt_local.undoreload = 0
        vim.opt_local.list = false
        vim.b[ctx.buf].snacks_indent = false
        vim.schedule(function()
          vim.bo[ctx.buf].syntax = ctx.ft
          vim.bo[ctx.buf].commentstring =
            vim.filetype.get_option(ctx.ft, "commentstring")
        end)
      end,
    },
    -- Indent guides without scope highlighting.
    indent = { scope = { enabled = false } },
    -- Highlighting and jumping to references.
    words = { notify_end = false },
  },
}
