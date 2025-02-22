local M = require("lualine_require").require("lualine.component"):extend()

local default_options = {
  icon = "", -- `nf-fa-folder`
}

function M:init(options)
  -- Run `super()`.
  M.super.init(self, options)

  -- Apply default options.
  self.options =
    vim.tbl_deep_extend("keep", self.options or {}, default_options)
end

function M:update_status()
  return require("auto-session.lib").current_session_name(true)
end

return M
