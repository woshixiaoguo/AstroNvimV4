local colors = require "catppuccin.palettes.mocha"
return {
  "catppuccin",
  opts = {
    -- transparent_background = vim.g.transparent_background,
    transparent_background = true,
    styles = {
      comments = { "italic" },
      conditionals = { "italic" },
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    -- https://github.com/catppuccin/catppuccin/blob/main/docs/style-guide.md
    custom_highlights = function(colors)
      return {
        Comment = { fg = colors.flamingo },
        LineNr = { fg = colors.subtext0 },
        CursorLine = { bg = colors.surface2 },
        -- CursorLine = { bg = colors.subtext1 },
        -- TabLineSel = { bg = colors.pink },
      }
    end,
    native_lsp = {
      enabled = true,
      inlay_hints = {
        background = true,
      },
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
    },
  },
}
