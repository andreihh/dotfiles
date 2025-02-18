-- TODO: delete once https://github.com/nvim-lualine/lualine.nvim/issues/1375 is
-- resolved.
local M = require("lualine_require").require("lualine.component"):extend()

local default_options = {
  icon = "", -- `nf-fa-gear`
  symbols = {
    separator = " ",
    done = "✓", -- `U+2713`
    spinner = Snacks.util.spinner, -- Compute spinner synmbol with a function
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

  --- The difference between the `begin` and `end` progress events for each LSP.
  ---
  --- @type table<integer, integer>
  self.lsp_work_by_client_id = {}

  vim.api.nvim_create_autocmd("LspProgress", {
    desc = "Update the Lualine LSP status component with progress",
    group = vim.api.nvim_create_augroup("lualine_lsp_progress", {}),
    --- @param event {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(event)
      local kind = event.data.params.value.kind
      local client_id = event.data.client_id

      local work = self.lsp_work_by_client_id[client_id] or 0
      local work_change = kind == "begin" and 1 or (kind == "end" and -1 or 0)

      self.lsp_work_by_client_id[client_id] = math.max(work + work_change, 0)

      -- Refresh Lualine to update the LSP status symbol if it changed.
      if (work == 0 and work_change > 0) or (work == 1 and work_change < 0) then
        require("lualine").refresh()
      end
    end,
  })
end

function M:update_status()
  local result = {}

  local bufnr = vim.api.nvim_get_current_buf()
  for _, client in ipairs(vim.lsp.get_clients({ bufnr = bufnr })) do
    local status
    local work = self.lsp_work_by_client_id[client.id]
    if work ~= nil and work > 0 then
      status = self.symbols.spinner()
    elseif work ~= nil and work == 0 then
      status = self.symbols.done
    end

    -- Append the status to the LSP only if it supports progress reporting.
    table.insert(result, client.name .. (status and " " .. status or ""))
  end

  return table.concat(result, self.symbols.separator)
end

return M
