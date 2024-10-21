-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local cursorline_augroup =
  vim.api.nvim_create_augroup("highlight-cursorline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
  desc = "Enable cursor line highlight when entering window",
  group = cursorline_augroup,
  callback = function()
    vim.opt.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
  desc = "Disable cursor line highlight when leaving window",
  group = cursorline_augroup,
  callback = function()
    vim.opt.cursorline = false
  end,
})

-- Highlight when yanking (copying) text.
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
