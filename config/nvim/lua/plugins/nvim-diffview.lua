return { -- Better diff views
  "sindrets/diffview.nvim",
  cmd = { "DiffviewOpen", "DiffviewFileHistory" },
  keys = {
    { "<leader>vd", "<cmd>DiffviewOpen<CR>", desc = "[V]CS [D]iff" },
    {
      "<leader>vh",
      "<cmd>DiffviewFileHistory %<CR>",
      desc = "[V]CS file [H]istory",
    },
    { "<leader>vH", "<cmd>DiffviewFileHistory<CR>", desc = "[V]CS [H]istory" },
  },
  opts = function()
    local actions = require("diffview.actions")
    return {
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
      -- Always track file history through renames.
      default_args = { DiffviewFileHistory = { "--follow" } },
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
