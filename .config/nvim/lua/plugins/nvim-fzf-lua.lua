return { -- Fuzzy finder (files, lsp, etc.)
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "s ", "<cmd>FzfLua resume<CR>", desc = "[S]earch resume" },
    { "sp", "<cmd>FzfLua builtin<CR>", desc = "[S]earch [P]icker" },
    { "sh", "<cmd>FzfLua helptags<CR>", desc = "[S]earch [H]elp tags" },
    { "sm", "<cmd>FzfLua manpages<CR>", desc = "[S]earch [M]an pages" },
    { "sk", "<cmd>FzfLua keymaps<CR>", desc = "[S]earch [K]eymaps" },
    { "sf", "<cmd>FzfLua files<CR>", desc = "[S]earch [F]iles" },
    { "sr", "<cmd>FzfLua oldfiles<CR>", desc = "[S]earch [R]ecent files" },
    { "sb", "<cmd>FzfLua buffers<CR>", desc = "[S]earch [B]uffers" },
    { "sc", "<cmd>FzfLua git_status<CR>", desc = "[S]earch Git [C]hanges" },
    { "sg", "<cmd>FzfLua live_grep<CR>", desc = "[S]earch by [G]rep" },
    {
      "sd",
      "<cmd>FzfLua diagnostics_workspace<CR>",
      desc = "[S]earch [D]iagnostics",
    },
    {
      "sw",
      "<cmd>FzfLua lsp_workspace_symbols<CR>",
      desc = "[S]earch [W]orkspace symbols",
    },
    {
      "s.",
      "<cmd>FzfLua files cwd='%:h'<CR>",
      desc = "[S]earch files in [.] current buffer's working directory",
    },
    {
      "s+",
      function()
        require("fzf-lua").buffers({
          buffers = vim.tbl_filter(function(buf)
            return vim.api.nvim_get_option_value("modified", { buf = buf })
          end, vim.api.nvim_list_bufs()),
          fzf_opts = { ["--header-lines"] = false },
        })
      end,
      desc = "[S]earch [+] modified buffers",
    },
    {
      "s:",
      "<cmd>FzfLua command_history<CR>",
      desc = "[S]earch [:] command history",
    },
    { "s'", "<cmd>FzfLua marks marks=%a<CR>", desc = "[S]earch ['] marks" },
    { "s/", "<cmd>FzfLua blines<CR>", desc = "[S]earch [/] current buffer" },
    {
      "gd",
      "<cmd>FzfLua lsp_definitions jump_to_single_result=true<CR>",
      desc = "[G]oto [D]efinition",
    },
    {
      "gD",
      "<cmd>FzfLua lsp_declarations jump_to_single_result=true<CR>",
      -- NOTE: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      desc = "[G]oto [D]eclaration",
    },
    {
      "gi",
      "<cmd>FzfLua lsp_implementations jump_to_single_result=true<CR>",
      desc = "[G]oto [I]mplementation",
    },
    { "gr", "<cmd>FzfLua lsp_references<CR>", desc = "[G]oto [R]eferences" },
    { "<leader>a", "<cmd>FzfLua lsp_code_actions<CR>", desc = "Code [A]ction" },
  },
  opts = {
    keymap = { -- Disable default keymaps
      builtin = {
        ["<C-d>"] = "preview-half-page-down",
        ["<C-u>"] = "preview-half-page-up",
        ["<C-p>"] = "toggle-preview-wrap",
        ["<C-\\>"] = "toggle-help",
      },
      fzf = {},
    },
    previewers = {
      builtin = { treesitter = { enabled = vim.g.lsp.treesitter_enabled } },
    },
    fzf_colors = true, -- Match `fzf` colors with color scheme
    defaults = { formatter = "path.dirname_first" },
    file_icon_padding = " ", -- Required for double-width icon rendering
    -- Make files prompt consistent with other pickers.
    files = { cwd_prompt = false },
    -- Include current session files in recent files.
    oldfiles = { include_current_session = true },
  },
  init = function()
    -- Register `fzf-lua` for `vim.ui.select` lazily.
    vim.schedule(function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("fzf-lua").register_ui_select()
        return vim.ui.select(...)
      end
    end)
  end,
}
