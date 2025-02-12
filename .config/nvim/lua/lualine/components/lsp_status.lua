-- TODO: delete once https://github.com/nvim-lualine/lualine.nvim/issues/1375 is
-- resolved.
local lualine_require = require("lualine_require")

local M = lualine_require.require("lualine.component"):extend()

local default_options = {
  icon = "", -- `nf-fa-gear`
  symbols = {
    -- Use standard unicode characters for the `spinner` and `done` symbols.
    spinner = {
      "⠋",
      "⠙",
      "⠹",
      "⠸",
      "⠼",
      "⠴",
      "⠦",
      "⠧",
      "⠇",
      "⠏",
    },
    done = "✓",
    separator = " ",
  },
}

function M:init(options)
  -- Run `super()`.
  M.super.init(self, options)

  -- Apply default options.
  self.options =
    vim.tbl_deep_extend("keep", self.options or {}, default_options)

  -- Apply symbols.
  self.symbols = self.options.symbols or {}

  -- Initialize LSP progress symbols by client id to store and use when rendering component.
  self.lsp_progress_by_client_id = {}

  vim.api.nvim_create_autocmd("LspProgress", {
    desc = "Update the Lualine LSP status component with progress",
    group = vim.api.nvim_create_augroup("lualine_lsp_progress", {}),
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
      local is_done = ev.data.params.value.kind == "end"
      local i = math.floor(vim.uv.hrtime() / (1e6 * 80)) % #self.symbols.spinner
        + 1
      local prev_progress = self.lsp_progress_by_client_id[ev.data.client_id]
      local next_progress = is_done and self.symbols.done
        or self.symbols.spinner[i]

      -- Update the stored LSP progress symbol.
      self.lsp_progress_by_client_id[ev.data.client_id] = next_progress

      -- Refresh Lualine to update the LSP progress symbol if it changed.
      if prev_progress ~= next_progress then
        require("lualine").refresh()
      end
    end,
  })
end

function M:update_status()
  local bufnr = vim.api.nvim_get_current_buf()
  local result = {}
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    -- Append the progress to the LSP name only if supported.
    local progress = self.lsp_progress_by_client_id[client.id]
    table.insert(result, client.name .. (progress and " " .. progress or ""))
  end
  return table.concat(result, self.symbols.separator)
end

return M
