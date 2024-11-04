-- Disable [S]ubstitute to allow search chaining.
vim.keymap.set("n", "s", "<nop>")

return { -- Fuzzy Finder (files, lsp, etc)
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = {
    {
      "sp",
      "<cmd>Telescope builtin<CR>",
      desc = "[S]earch [P]icker",
    },
    {
      "sh",
      "<cmd>Telescope help_tags<CR>",
      desc = "[S]earch [H]elp",
    },
    {
      "sk",
      "<cmd>Telescope keymaps<CR>",
      desc = "[S]earch [K]eymaps",
    },
    {
      "sf",
      "<cmd>Telescope find_files<CR>",
      desc = "[S]earch [F]iles",
    },
    {
      "sr",
      "<cmd>Telescope oldfiles<CR>",
      desc = "[S]earch [R]ecent files",
    },
    {
      "sc",
      "<cmd>Telescope git_status<CR>",
      desc = "[S]earch [C]hanged files",
    },
    {
      "sg",
      "<cmd>Telescope live_grep<CR>",
      desc = "[S]earch by [G]rep",
    },
    {
      "sd",
      "<cmd>Telescope diagnostics<CR>",
      desc = "[S]earch [D]iagnostics",
    },
    {
      "sw",
      "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
      desc = "[S]earch [W]orkspace symbols",
    },
    {
      "s/",
      "<cmd>Telescope current_buffer_fuzzy_find<CR>",
      desc = "[S]earch [/] current buffer",
    },
    {
      "gd",
      "<cmd>Telescope lsp_definitions<CR>",
      desc = "[G]oto [D]efinition",
    },
    {
      "gi",
      "<cmd>Telescope lsp_implementations<CR>",
      desc = "[G]oto [I]mplementation",
    },
    {
      "gr",
      "<cmd>Telescope lsp_references<CR>",
      desc = "[G]oto [R]eferences",
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      -- Install, load and build only if `make` is available.
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-hop.nvim",

    -- Icons require a Nerd Font.
    { "nvim-tree/nvim-web-devicons", enabled = vim.g.nerd_font_enabled },
  },
  opts = function(_, opts)
    local keymaps = {
      ["<C-j>"] = "move_selection_next",
      ["<C-k>"] = "move_selection_previous",
      ["<C-o>"] = "select_default",
      ["<C-s>"] = "select_horizontal",
      ["<C-e>"] = "close",
      ["<C-h>"] = function(prompt_bufnr)
        require("telescope").extensions.hop._hop(prompt_bufnr)
      end,
      ["<C-\\>"] = "which_key",
    }
    return vim.tbl_deep_extend("force", opts, {
      defaults = {
        mappings = {
          i = keymaps,
          n = keymaps,
        },
        path_display = { "truncate" },
      },
      pickers = {
        current_buffer_fuzzy_find = { previewer = false },
      },
      extensions = {
        fzf = {},
        hop = {},
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
      },
    })
  end,
  config = function(_, opts)
    -- [[ Configure Telescope ]]
    --  See `:help telescope` and `:help telescope.setup()`
    local telescope = require("telescope")
    telescope.setup(opts)

    -- Enable Telescope extensions if they are installed.
    for extension, _ in pairs(opts.extensions or {}) do
      pcall(telescope.load_extension, extension)
    end
  end,
}
