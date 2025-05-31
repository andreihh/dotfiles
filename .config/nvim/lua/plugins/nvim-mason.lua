return { -- Package manager for development tools (LSPs, formatters, etc.)
  "mason-org/mason.nvim",
  opts = {},
  config = function(_, opts)
    require("mason").setup(opts)

    -- Ensure `tree-sitter-cli` is installed.
    local ensure_installed = vim.g.ensure_installed or {}
    table.insert(ensure_installed, "tree-sitter-cli")

    -- Collect packages to install.
    local pkg_names_to_install = {}
    for _, pkg_name in ipairs(ensure_installed) do
      if not require("mason-registry").is_installed(pkg_name) then
        table.insert(pkg_names_to_install, pkg_name)
      end
    end

    -- Install missing packages, if any.
    if not vim.tbl_isempty(pkg_names_to_install) then
      require("mason.api.command").MasonInstall(pkg_names_to_install)
    end
  end,
}
