return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    -- Add Treesitter text objects.
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    opts = { -- See `:help nvim-treesitter`
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
      -- Some languages depend on Vim's regex highlighting system (such as Ruby)
      -- for indent rules. If you are experiencing weird indenting issues, add
      -- the language to the list of `additional_vim_regex_highlighting` for
      -- `highlight` and `disable` languages for `indent`.
      highlight = { enable = true },
      indent = { enable = true },
      textobjects = { -- See `:help nvim-treesitter-textobjects`
        select = {
          enable = true,
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
          enable = true,
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
      -- Use Treesitter folds.
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
  },
  { -- Show current context
    "nvim-treesitter/nvim-treesitter-context",
    cmd = { "TSContextToggle", "TSContextEnable", "TSContextDisable" },
    opts = { enable = false },
  },
  { -- Better Treesitter comment strings
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    config = true,
  },
}
