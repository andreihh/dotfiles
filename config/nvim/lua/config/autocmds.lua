-- [[ Autocommands ]]
--  See `:help lua-guide-autocommands`

local cursorline_augroup =
  vim.api.nvim_create_augroup("highlight_cursorline", {})

vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
  desc = "Enable cursor line highlight when entering window",
  group = cursorline_augroup,
  callback = function()
    vim.wo.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
  desc = "Disable cursor line highlight when leaving window",
  group = cursorline_augroup,
  callback = function()
    vim.wo.cursorline = false
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight_yank", {}),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  desc = "Enable Treesitter",
  group = vim.api.nvim_create_augroup("enable_treesitter", {}),
  callback = function()
    -- Enable Treesitter syntax highlighting, indentation and folding.
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      vim.wo[0][0].foldmethod = "expr"
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end
  end,
})

vim.api.nvim_create_autocmd("User", {
  desc = "Configure color scheme",
  group = vim.api.nvim_create_augroup("configure_colorscheme", {}),
  pattern = "LazyDone",
  callback = function()
    vim.cmd.colorscheme(vim.env.NVIM_THEME)
  end,
})
