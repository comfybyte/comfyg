require("kanagawa").setup({
  transparent = true,
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none",
        },
      },
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    return {
      NormalFloat = { bg = "none" },
      FloatBorder = { bg = "none" },
      FloatTitle = { bg = "none" },

      TelescopeTitle = { fg = theme.ui.special, bold = true },
      TelescopePromptNormal = { bg = "none" },
      TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = "none" },
      TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = "none" },
      TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = "none" },
      TelescopePreviewNormal = { bg = "none" },
      TelescopePreviewBorder = { bg = "none", fg = "none" },
    }
  end,
})
