return { -- Package manager for development tools (LSPs, formatters, etc.)
  "mason-org/mason.nvim",
  config = function(_, opts)
    -- See `:help mason.nvim`
    require("mason").setup(opts)
    local registry = require("mason-registry")
    local pkg_names_to_install = {}
    for _, pkg_name in ipairs(vim.g.ensure_installed or {}) do
      if not registry.is_installed(pkg_name) then
        table.insert(pkg_names_to_install, pkg_name)
      end
    end
    if not vim.tbl_isempty(pkg_names_to_install) then
      require("mason.api.command").MasonInstall(pkg_names_to_install)
    end
  end,
}
