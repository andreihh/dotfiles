return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    dependencies = {
      { -- Add Treesitter text objects
        "nvim-treesitter/nvim-treesitter-textobjects",
        cond = vim.g.lsp.treesitter_enabled,
      },
    },
    -- See `:help nvim-treesitter`
    opts = {
      ensure_installed = { -- Enable the following parsers
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "markdown",
        "diff",
        "query",
        "regex",
      },
      auto_install = true, -- Autoinstall languages that are not installed
      highlight = {
        enable = vim.g.lsp.treesitter_enabled,
        -- Some languages depend on vim's regex highlighting system (such as
        -- Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages
        --  for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = {
        enable = vim.g.lsp.treesitter_enabled,
        disable = { "ruby" },
      },
      -- Select and jump through Treesitter text objects.
      --  See `:help nvim-treesitter-textobjects`
      textobjects = {
        select = {
          enable = vim.g.lsp.treesitter_enabled,
          lookahead = true, -- Automatically jump forward to text object
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["at"] = "@class.outer",
            ["it"] = "@class.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
          },
        },
        move = {
          enable = vim.g.lsp.treesitter_enabled,
          set_jumps = true,
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]t"] = "@class.outer",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]T"] = "@class.outer",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[t"] = "@class.outer",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[T"] = "@class.outer",
          },
        },
      },
    },
    init = function()
      if vim.g.lsp.treesitter_enabled then
        -- Use Treesitter folds.
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end
    end,
  },
  { -- Show current context
    "nvim-treesitter/nvim-treesitter-context",
    cond = vim.g.lsp.treesitter_enabled,
    cmd = { "TSContextToggle", "TSContextEnable", "TSContextDisable" },
    keys = {
      { "<leader>c", "<cmd>TSContextToggle<CR>", desc = "Toggle [C]ontext" },
    },
    opts = { enable = false },
  },
  { -- Better Treesitter comment strings
    "folke/ts-comments.nvim",
    cond = vim.g.lsp.treesitter_enabled,
    event = "VeryLazy",
    config = true,
  },
}
