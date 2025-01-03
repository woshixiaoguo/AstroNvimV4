-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
    -- import/override with your plugins folder

    -- colorscheme
    { import = "astrocommunity.colorscheme.catppuccin" },

    -- project
    { import = "astrocommunity.project.project-nvim" },

    -- java
    { import = "astrocommunity.pack.java" },

    -- noice
    { import = "astrocommunity.utility.noice-nvim" },

    -- distant
    -- { import = "astrocommunity.remote-development.distant-nvim" },

    -- pets
    { import = "astrocommunity.media.pets-nvim" },

    -- zen
    { import = "astrocommunity.editing-support.zen-mode-nvim" },

    -- typescript-all-in-one
    -- { import = "astrocommunity.pack.typescript-all-in-one" },

    -- vim-visual-multi
    { import = "astrocommunity.editing-support.vim-visual-multi" },

    -- indent
    { import = "astrocommunity.indent.mini-indentscope" },
}
