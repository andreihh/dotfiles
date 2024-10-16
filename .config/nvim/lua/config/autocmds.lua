-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local cursorline_augroup =
  vim.api.nvim_create_augroup("highlight-cursorline", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "FocusGained" }, {
  desc = "Enable cursor line highlight when entering window",
  group = cursorline_augroup,
  callback = function() vim.opt.cursorline = true end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "FocusLost" }, {
  desc = "Disable cursor line highlight when leaving window",
  group = cursorline_augroup,
  callback = function() vim.opt.cursorline = false end,
})

-- Highlight when yanking (copying) text.
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- This function gets run when an LSP attaches to a particular buffer.
--  That is to say, every time a new file is opened that is associated with an
--  lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
--  function will be executed to configure the current buffer.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --  See `:help CursorHold` for information about when this is executed.
    --
    -- When you move your cursor, the highlights will be cleared (the second
    -- autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if
      client
      and client.supports_method(
        vim.lsp.protocol.Methods.textDocument_documentHighlight
      )
    then
      local highlight_augroup =
        vim.api.nvim_create_augroup("highlight-reference", { clear = false })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        desc = "Highlight references for token under cursor",
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        desc = "Clear references highlight for token under cursor",
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = highlight_augroup,
            buffer = event2.buf,
          })
        end,
      })
    end
  end,
})
