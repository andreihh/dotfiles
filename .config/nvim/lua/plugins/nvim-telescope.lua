return {
  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
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
        "sq",
        "<cmd>Telescope quickfix<CR>",
        desc = "[S]earch [Q]uickfix",
      },
      {
        "sw",
        "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
        desc = "[S]earch [W]orkspace symbols",
      },
      {
        "s/",
        "<cmd>Telescope current_buffer_fuzzy_find<CR>",
        desc = "[S]earch [/] in current buffer",
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
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things
      -- that it can fuzzy find! It's more than just a "file finder", it can
      -- search many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --

      -- [[ Configure Telescope ]]
      --  See `:help telescope` and `:help telescope.setup()`
      local telescope = require("telescope")
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

      telescope.setup({
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
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })

      -- Enable Telescope extensions if they are installed.
      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "ui-select")
      pcall(telescope.load_extension, "hop")
    end,
  },
}
