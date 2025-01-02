return { -- Better diff views
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "dvo", "<cmd>DiffviewOpen<CR>", desc = "[D]iff [V]iew [O]pen" },
    { "dvO", ":DiffviewOpen ", desc = "[D]iff [V]iew [O]pen" },
    {
      "dvh",
      "<cmd>DiffviewFileHistory %<CR>",
      desc = "[D]iff [V]iew file [H]istory",
    },
    { "dvH", "<cmd>DiffviewFileHistory<CR>", desc = "[D]iff [V]iew [H]istory" },
    { "dvb", "<cmd>.DiffviewFileHistory<CR>", desc = "[D]iff [V]iew [B]lame" },
  },
  dependencies = {
    -- Icons require a Nerd Font.
    { "nvim-tree/nvim-web-devicons", cond = NerdFontEnabled() },
  },
  opts = function()
    local actions = require("diffview.actions")
    return {
      use_icons = NerdFontEnabled(), -- Icons require a Nerd Font
      file_panel = { listing_style = "list" },
      view = {
        default = { disable_diagnostics = true },
        file_history = { disable_diagnostics = true },
        merge_tool = { layout = "diff4_mixed" },
      },
      hooks = {
        view_opened = function()
          -- Allow closing diff view tab with `q`.
          vim.api.nvim_tabpage_set_var(0, "is_diff_tab", 1)
        end,
      },
      keymaps = {
        file_panel = {
          { "n", "<C-u>", actions.scroll_view(-0.5), { desc = "Scroll up" } },
          { "n", "<C-d>", actions.scroll_view(0.5), { desc = "Scroll down" } },
        },
        file_history_panel = {
          { "n", "<C-u>", actions.scroll_view(-0.5), { desc = "Scroll up" } },
          { "n", "<C-d>", actions.scroll_view(0.5), { desc = "Scroll down" } },
        },
        -- Disable conflicting keymaps.
        view = { ["[F"] = false, ["]F"] = false },
      },
    }
  end,
}
