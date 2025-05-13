return { -- Package manager for development tools (LSPs, formatters, etc.)
  "mason-org/mason.nvim",
  opts = { -- See `:help mason.nvim`
    ensure_installed = vim.list_extend({
      "lua-language-server",
      "vim-language-server",
      "bash-language-server",
      "ansible-language-server",
      "shellcheck", -- integrates with `bash-language-server`
      "ansible-lint", -- integrates with `ansible-language-server`
      "stylua",
      "shfmt",
      "prettier",
    }, vim.g.ensure_installed or {}),
  },
  config = function(_, opts)
    require("mason").setup(opts)
    local registry = require("mason-registry")
    local pkg_names_to_install = {}
    for _, pkg_name in ipairs(opts.ensure_installed or {}) do
      if not registry.is_installed(pkg_name) then
        table.insert(pkg_names_to_install, pkg_name)
      end
    end
    if not vim.tbl_isempty(pkg_names_to_install) then
      require("mason.api.command").MasonInstall(pkg_names_to_install)
    end
  end,
}
