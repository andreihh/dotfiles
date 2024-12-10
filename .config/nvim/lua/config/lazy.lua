-- [[ Install `lazy.nvim` plugin manager ]]
--  To check the current status of your plugins, run `:Lazy`. Press `?` in this
--  menu for help. Use `q` to close the window.
--
--  See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim

-- Bootstrap `lazy.nvim`.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup `lazy.nvim`.
require("lazy").setup("plugins", {
  -- Don't show config change notifications in command prompt.
  change_detection = { notify = false },
})
