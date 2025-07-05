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
  opts = {
    bigfile = { -- Disable Treesitter, LSP, folds, undo, etc. in big files
      setup = function(ctx)
        vim.opt_local.swapfile = false
        vim.opt_local.foldmethod = "manual"
        vim.opt_local.undolevels = -1
        vim.opt_local.undoreload = 0
        vim.opt_local.list = false
        vim.b[ctx.buf].snacks_indent = false
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(ctx.buf) then
            vim.bo[ctx.buf].syntax = ctx.ft
            vim.bo[ctx.buf].commentstring =
              vim.filetype.get_option(ctx.ft, "commentstring")
          end
        end)
      end,
    },
    -- Indent guides without scope highlighting.
    indent = { scope = { enabled = false } },
    words = {}, -- Highlighting and jumping to references
    zen = { toggles = { dim = false } }, -- Don't dim outer scopes in Zen mode
    input = { -- Register `snacks` for `vim.ui.input`
      win = {
        relative = "cursor", -- Show float relative to cursor
        row = -3, -- Show float above cursor
        keys = {
          -- Override default tab action.
          i_tab = { "<tab>", "confirm", mode = { "n", "i" } },
          -- Scroll through input history.
          c_n = { "<C-n>", "hist_down", mode = { "n", "i" } },
          c_p = { "<C-p>", "hist_up", mode = { "n", "i" } },
        },
      },
    },
    -- Starting dashboard with icons:
    --  - `nf-fa-file_text`
    --  - `nf-fa-folder`
    --  - `nf-fa-search`
    --  - `nf-fa-list_alt`
    --  - `nf-fa-copy`
    --  - `nf-fa-save`
    --  - `nf-fa-plug`
    --  - `nf-fa-sign_out`
    dashboard = {
      preset = {
        keys = {
          { icon = "", key = "e", action = "g-", desc = "Open explorer" },
          { icon = "", key = "f", action = "sf", desc = "Find file" },
          { icon = "", key = "g", action = "sg", desc = "Grep text" },
          { icon = "", key = "r", action = "sr", desc = "Recent files" },
          { icon = "", key = "l", action = "ss", desc = "Load session" },
          { icon = "", key = "m", action = "M", desc = "Manage plugins" },
          { icon = "", key = "q", action = "Q", desc = "Quit" },
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
        Snacks.toggle
          .new({
            name = "Navigation context",
            get = function()
              return vim.g.__context_enabled == true
            end,
            set = function(state)
              local lualine = require("lualine")
              local treesitter_context = require("treesitter-context")

              vim.g.__context_enabled = state
              vim.g.__winbar_config = vim.g.__winbar_config
                or vim.tbl_deep_extend(
                  "keep",
                  lualine.get_config().winbar, -- Save initial winbar config
                  { lualine_b = {} } -- Ensure context is cleared from winbar
                )

              if state then
                lualine.setup({
                  winbar = { lualine_b = { { "filename", path = 1 } } },
                })
                treesitter_context.enable()
              else
                lualine.setup({ winbar = vim.g.__winbar_config })
                treesitter_context.disable()
              end
            end,
          })
          :map("<leader>-")
          :set(false) -- Disable context by default
      end,
    })
  end,
}
