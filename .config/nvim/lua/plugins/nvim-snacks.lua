return { -- Highlight and jump to references, Lazygit, handle big files, etc.
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "<C-z>",
      function()
        Snacks.zen.zen()
      end,
      desc = "Toggle [Z]en mode",
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
      size = vim.g.lsp.bigfile_size, -- Set big file size threshold
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
    -- Don't dim code outside of the current scope in Zen mode.
    zen = { toggles = { dim = false } },
    input = { -- Register `snacks` for `vim.ui.input`
      -- Icons require a Nerd Font: `nf-fa-edit`.
      icon = NerdFontEnabled() and " " or "",
      win = {
        -- Show float relative to cursor.
        relative = "cursor",
        row = 1,
        keys = {
          -- Override default tab action.
          i_tab = { "<tab>", "confirm", mode = { "n", "i" } },
          -- Exit from any mode.
          c_e = { "<C-e>", "cancel", mode = { "n", "i", "x" } },
        },
      },
    },
  },
}
