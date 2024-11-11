return { -- Decorate tabline with tab index, buffer flags, etc.
  "nanozuki/tabby.nvim",
  dependencies = {
    -- Icons require a Nerd Font.
    { "nvim-tree/nvim-web-devicons", cond = vim.g.nerd_font_enabled },
  },
  opts = {
    line = function(line)
      local theme = {
        fill = "TabLineFill",
        head = "TabLine",
        current_tab = "TabLineSel",
        tab = "TabLine",
      }
      -- Icons require a Nerd Font.
      local icons = vim.g.nerd_font_enabled
          and {
            vim = "  ",
            seg_start = "",
            seg_sep = "",
            seg_end = "",
            current_seg = "*",
          }
        or {
          vim = " Vim ",
          seg_start = "",
          seg_sep = "|",
          seg_end = " ",
          current_seg = "*",
        }
      return {
        {
          { icons.vim, hl = theme.head },
          line.sep(icons.seg_end, theme.head, theme.fill),
        },
        line.tabs().foreach(function(tab)
          local hl = tab.is_current() and theme.current_tab or theme.tab
          return {
            line.sep(icons.seg_start, hl, theme.fill),
            tab.number(),
            icons.seg_sep,
            tab.name(),
            tab.is_current() and icons.seg_sep or "",
            tab.is_current() and icons.current_seg or "",
            line.sep(icons.seg_end, hl, theme.fill),
            hl = hl,
            margin = " ",
          }
        end),
        hl = theme.fill,
      }
    end,
    -- Icons require a Nerd Font.
    option = { nerdfont = vim.g.nerd_font_enabled },
  },
}
