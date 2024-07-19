return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    -- customize the dashboard header
    opts.section.header.val = {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
    }

    -- opts.config.opts.noautowmd = false
    opts.section.buttons.val = {
      opts.button("LDR n  ", "  New File  "),
      opts.button("LDR f p", "  Find Project  "),
      opts.button("LDR f f", "  Find File  "),
      opts.button("LDR f o", "󰈙  Recents  "),
      opts.button("LDR f w", "󰈭  Find Word  "),
      opts.button("LDR S f", "  Find Session  "),
      opts.button("LDR f '", "  Bookmarks  "),
      opts.button("LDR S l", "  Last Session  "),
    }
    opts.section.footer.val = "Guoguo"
    return opts
  end,
}
