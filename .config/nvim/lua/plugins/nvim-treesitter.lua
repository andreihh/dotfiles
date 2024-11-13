return {
  { -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs",
    -- See `:help nvim-treesitter`
    opts = {
      -- Enable the following parsers.
      ensure_installed = {
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "markdown",
        "diff",
        "query",
        "regex",
      },
      -- Autoinstall languages that are not installed.
      auto_install = true,
      highlight = {
        enable = vim.g.lsp_opts.treesitter_enabled == true,
        -- Some languages depend on vim's regex highlighting system (such as
        -- Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages
        --  for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = {
        enable = vim.g.lsp_opts.treesitter_enabled == true,
        disable = { "ruby" },
      },
      -- Incremental selection of Treesitter nodes.
      --  See `:help nvim-treesitter-incremental-selection-mod`
      incremental_selection = {
        enable = vim.g.lsp_opts.treesitter_enabled == true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<C-]>",
        },
      },
    },
    init = function()
      if vim.g.lsp_opts.treesitter_enabled == true then
        -- Use Treesitter folds.
        vim.opt.foldmethod = "expr"
        vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      end
    end,
  },
  { -- Show context
    "nvim-treesitter/nvim-treesitter-context",
    cond = vim.g.lsp_opts.treesitter_enabled == true,
    cmd = { "TSContextToggle", "TSContextEnable", "TSContextDisable" },
    init = function()
      -- Registering the command in `keys` leads to a failure when triggered.
      vim.keymap.set(
        "n",
        "<leader>c",
        "<cmd>TSContextToggle<CR>",
        { desc = "Toggle [C]ontext" }
      )
    end,
    opts = { enable = false },
  },
  { -- Better Treesitter comment strings
    "folke/ts-comments.nvim",
    cond = vim.g.lsp_opts.treesitter_enabled == true,
    event = "VeryLazy",
    config = true,
  },
}
