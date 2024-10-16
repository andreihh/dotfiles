return {
  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- Install, load and build only if `make` is available.
        build = "make",
        cond = function() return vim.fn.executable("make") == 1 end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-telescope/telescope-hop.nvim" },

      -- Useful for getting pretty icons, but requires a Nerd Font.
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
      --
      --  Open a window that shows all of the keymaps for the current Telescope
      --  picker with the following shortcuts:
      --   - Insert mode: <C-/>
      --   - Normal mode: ?
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local keymaps = {
        ["<C-o>"] = "select_default",
        ["<C-s>"] = "select_horizontal",
        ["<C-e>"] = "close",
        ["<C-h>"] = function(prompt_bufnr)
          require("telescope").extensions.hop._hop(prompt_bufnr)
        end,
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

      local function nnoremap(lhs, rhs, description)
        vim.keymap.set("n", lhs, rhs, { desc = description, noremap = true })
      end

      nnoremap("ss", builtin.builtin, "[S]earch [S]elect")
      nnoremap("sh", builtin.help_tags, "[S]earch [H]elp")
      nnoremap("sk", builtin.keymaps, "[S]earch [K]eymaps")
      nnoremap("sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, "[S]earch [N]eovim files")

      nnoremap("sf", builtin.find_files, "[S]earch [F]iles")
      nnoremap("sr", builtin.oldfiles, "[S]earch [R]ecent files")
      nnoremap("sc", builtin.git_status, "[S]earch [C]hanges")
      nnoremap("sg", builtin.live_grep, "[S]earch by [G]rep")

      nnoremap("sd", builtin.diagnostics, "[S]earch [D]iagnostics")
      nnoremap("sq", builtin.quickfix, "[S]earch [Q]uickfix")

      nnoremap(
        "sw",
        builtin.lsp_dynamic_workspace_symbols,
        "[S]earch [W]orkspace"
      )

      nnoremap(
        "s/",
        builtin.current_buffer_fuzzy_find,
        "[S]earch [/] in current buffer"
      )

      nnoremap("gd", builtin.lsp_definitions, "[G]oto [D]efinition")
      nnoremap("gi", builtin.lsp_implementations, "[G]oto [I]mplementation")
      nnoremap("gr", builtin.lsp_references, "[G]oto [R]eferences")
    end,
  },
}
