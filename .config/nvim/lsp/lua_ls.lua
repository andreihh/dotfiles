return {
  settings = {
    Lua = {
      telemetry = { enable = false },
      completion = { callSnippet = "Replace" },
      -- Ignore LuaLS's noisy `missing-fields` warnings.
      diagnostics = { disable = { "missing-fields" } },
    },
  },
}
