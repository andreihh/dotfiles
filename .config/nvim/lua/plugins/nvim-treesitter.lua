-- Use `treesitter` folds.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

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
      },
      -- Autoinstall languages that are not installed.
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as
        -- Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages
        --  for indent.
        additional_vim_regex_highlighting = { "ruby" },
      },
      indent = { enable = true, disable = { "ruby" } },
    },
  },
  { -- Show context
    "nvim-treesitter/nvim-treesitter-context",
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
}
