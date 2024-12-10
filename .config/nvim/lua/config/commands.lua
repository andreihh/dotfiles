-- [[ User commands ]]
--  See `:help lua-guide-commands`

vim.api.nvim_create_user_command("LspCapabilities", function()
  local clients =
    vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
  for _, client in pairs(clients) do
    vim.print("LSP capabilities for server " .. client.name .. ":")
    vim.print(client.server_capabilities)
  end
end, { desc = "Display the attached LSP capabilities" })
