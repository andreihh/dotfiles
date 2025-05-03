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

vim.api.nvim_create_autocmd("User", {
  desc = "Configure color scheme",
  group = vim.api.nvim_create_augroup("configure_colorscheme", {}),
  pattern = "LazyDone",
  callback = function()
    vim.cmd.colorscheme(vim.env.NVIM_THEME)
  end,
})

-- Start LSPs automatically.
--  Override configs with `vim.lsp.config()`.
--  See `:help vim.lsp.Config`
vim.lsp.enable({ "lua_ls", "vimls", "bashls", "ansiblels" })
