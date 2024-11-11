return { -- Fuzzy Finder (files, lsp, etc)
  "ibhagwan/fzf-lua",
  event = "VeryLazy", -- Ensure `vim.ui.select` registration
  keys = {
    {
      "sp",
      "<cmd>FzfLua builtin<CR>",
      desc = "[S]earch [P]icker",
    },
    {
      "sh",
      "<cmd>FzfLua helptags<CR>",
      desc = "[S]earch [H]elp",
    },
    {
      "sk",
      "<cmd>FzfLua keymaps<CR>",
      desc = "[S]earch [K]eymaps",
    },
    {
      "sf",
      "<cmd>FzfLua files<CR>",
      desc = "[S]earch [F]iles",
    },
    {
      "sr",
      "<cmd>FzfLua oldfiles<CR>",
      desc = "[S]earch [R]ecent files",
    },
    {
      "sc",
      "<cmd>FzfLua git_status<CR>",
      desc = "[S]earch [C]hanged files",
    },
    {
      "sg",
      "<cmd>FzfLua live_grep<CR>",
      desc = "[S]earch by [G]rep",
    },
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
      "s/",
      "<cmd>FzfLua blines<CR>",
      desc = "[S]earch [/] current buffer",
    },
    {
      "gd",
      "<cmd>FzfLua lsp_definitions<CR>",
      desc = "[G]oto [D]efinition",
    },
    {
      "gi",
      "<cmd>FzfLua lsp_implementations<CR>",
      desc = "[G]oto [I]mplementation",
    },
    {
      "gr",
      "<cmd>FzfLua lsp_references<CR>",
      desc = "[G]oto [R]eferences",
    },
  },
  dependencies = {
    -- Icons require a Nerd Font.
    { "nvim-tree/nvim-web-devicons", cond = vim.g.nerd_font_enabled },
  },
  opts = {
    keymap = {
      builtin = {
        false,
        ["<C-\\>"] = "toggle-help",
        ["<C-d>"] = "preview-half-page-down",
        ["<C-u>"] = "preview-half-page-up",
        ["<C-l>"] = "toggle-preview-wrap",
      },
      fzf = {
        false,
        ["tab"] = "accept",
        ["shift-tab"] = "toggle",
        ["ctrl-f"] = "jump",
        ["ctrl-d"] = "preview-half-page-down",
        ["ctrl-u"] = "preview-half-page-up",
        ["ctrl-l"] = "toggle-preview-wrap",
        ["ctrl-o"] = "accept",
      },
    },
    fzf_args = "--no-scrollbar",
    files = { cwd_prompt = false, prompt = "Files>" },
    oldfiles = { include_current_session = true },
    grep = { RIPGREP_CONFIG_PATH = vim.env.RIPGREP_CONFIG_PATH },
    file_icon_padding = " ",
    winopts = {
      preview = {
        scrollbar = false,
        winopts = { number = true },
      },
    },
  },
}
