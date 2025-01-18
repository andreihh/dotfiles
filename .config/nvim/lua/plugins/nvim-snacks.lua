return { -- Highlight and jump to references, Lazygit, handle big files, etc.
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "<C-z>",
      function()
        Snacks.zen()
      end,
      desc = "Toggle [Z]en mode",
    },
    {
      "[r",
      function()
        Snacks.words.jump(-1, true)
      end,
      desc = "Jump to the previous [R]eference",
    },
    {
      "]r",
      function()
        Snacks.words.jump(1, true)
      end,
      desc = "Jump to the next [R]eference",
    },
    {
      "<leader>g",
      function()
        Snacks.lazygit()
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
      size = 1024 * 1024, -- Set big file size threshold to 1 MiB
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
        row = -3,
        keys = {
          -- Override default tab action.
          i_tab = { "<tab>", "confirm", mode = { "n", "i" } },
          -- Exit from any mode.
          c_e = { "<C-e>", "cancel", mode = { "n", "i", "x" } },
        },
      },
    },
    dashboard = {
      preset = {
        -- Icons require a Nerd Font.
        keys = {
          {
            icon = NerdFontEnabled() and "" or "", -- `nf-fa-file_text`
            key = "n",
            action = ":enew",
            desc = "New file",
          },
          {
            icon = NerdFontEnabled() and "" or "", -- `nf-fa-folder`
            key = "o",
            action = "<C-o>",
            desc = "Open explorer",
          },
          {
            icon = NerdFontEnabled() and "" or "", -- `nf-fa-search`
            key = "f",
            action = "sf",
            desc = "Find file",
          },
          {
            icon = NerdFontEnabled() and "" or "", -- `nf-fa-list_alt`
            key = "g",
            action = "sg",
            desc = "Grep text",
          },
          {
            icon = NerdFontEnabled() and "" or "", -- `nf-fa-copy`
            key = "r",
            action = "sr",
            desc = "Recent files",
          },
          {
            icon = NerdFontEnabled() and "" or "", -- `nf-fa-save`
            key = "s",
            action = "ss",
            desc = "Restore session",
          },
          {
            icon = NerdFontEnabled() and "" or "", -- `nf-fa-plug`
            key = "m",
            action = "M",
            desc = "Manage plugins",
          },
          {
            icon = NerdFontEnabled() and "" or "", -- `nf-fa-sign_out`
            key = "q",
            action = "Q",
            desc = "Quit",
          },
        },
      },
    },
  },
  init = function()
    vim.g.snacks_animate = false -- Globally disable all animations
    vim.api.nvim_create_autocmd("User", {
      desc = "Configure Snacks toggle keymaps",
      group = vim.api.nvim_create_augroup("configure_snacks_toggles", {}),
      pattern = "VeryLazy",
      callback = function()
        Snacks.toggle.inlay_hints():map("<leader>H")
        Snacks.toggle.treesitter():map("<leader>T")
        Snacks.toggle.diagnostics():map("<leader>D")
      end,
    })
  end,
}
