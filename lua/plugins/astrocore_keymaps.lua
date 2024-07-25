return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          --
          -- ["<Leader>b"] = { name = "Buffers" },
          --
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command

          -- buffer manipulation
          [";h"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
          [";l"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          [";j"] = { function() require("astrocore.buffer").move(-1) end, desc = "Move buffer left" },
          [";k"] = { function() require("astrocore.buffer").move(1) end, desc = "Move buffer right" },

          -- diagnosis
          [";d"] = { function() vim.diagnostic.goto_next() end, desc = "Move to next diagnosis" },
          [";D"] = { function() vim.diagnostic.goto_prev() end, desc = "Move to previous diagnosis" },
          -- telescope
          ["<leader>fp"] = {
            function() require("telescope").extensions.projects.projects {} end,
            desc = "Find projects",
          },

          -- resize windows
          ["<C-PageUp>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" },
          ["<C-PageDown>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" },
          ["<C-End>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" },
          ["<C-Home>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" },

          -- distant
          ["<leader>D"] = { desc = "󰢹 Distant" },
          ["<leader>Dc"] = { ":DistantConnect ssh://", desc = "Connects to a remote server" },
          ["<leader>Do"] = { ":DistantOpen ", desc = "Open a file or directory on the remote machine" },
          ["<leader>Ds"] = { ":DistantShell<CR>", desc = "Spawns a remote shell for the current connection" },
          ["<leader>Dm"] = { ":DistantMkdir ", desc = "Creates a new directory on the remote machine" },
          ["<leader>Dv"] = { ":DistantClientVersion<CR>", desc = "Prints out the version of distant CLI" },
        },
        i = {
          ["jk"] = { "<esc>" },
        },
        v = {
          ["K"] = { ":move '<-2<CR>gv-gv", desc = "Move line up", silent = true },
          ["J"] = { ":move '>+1<CR>gv-gv", desc = "Move line down", silent = true },

          -- keep visiual mode after indent
          ["<"] = { "<gv", desc = "Unindent line" },
          [">"] = { ">gv", desc = "Indent line" },
        },
        t = {

          -- setting a mapping to false will disable it
          -- ["<esc>"] = false,
        },
      },
    },
  },
}
