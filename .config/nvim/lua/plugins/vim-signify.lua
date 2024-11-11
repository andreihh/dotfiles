return { -- VCS gutter signs
  "mhinz/vim-signify",
  init = function()
    -- Decrease VCS gutter signs priority below diagnostic signs (default 10).
    vim.g.signify_priority = 5
  end,
}
