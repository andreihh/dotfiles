return {
  settings = {
    Lua = {
      telemetry = { enable = false },
      completion = { callSnippet = "Replace" },
      -- Ignore LuaLS's noisy `missing-fields` warnings.
      diagnostics = { disable = { "missing-fields" } },
    },
  },
  -- TODO: delete when https://github.com/neovim/nvim-lspconfig/issues/3494 is
  -- fixed.
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = {
    ".luarc.json",
    ".luarc.jsonc",
    ".luacheckrc",
    ".stylua.toml",
    "stylua.toml",
    "selene.toml",
    "selene.yml",
    ".git",
  },
}
