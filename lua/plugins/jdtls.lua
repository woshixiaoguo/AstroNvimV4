local jdtls = require "jdtls"

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

-- local root_dir = require("jdtls.setup").find_root(root_markers)
-- vim.notify("root_dir " .. root_dir)

-- calculate workspace dir
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath "data" .. "/site/java/workspace-root/" .. project_name
os.execute("mkdir " .. workspace_dir)

return {
  { "mfussenegger/nvim-jdtls", lazy = true }, -- load jdtls on module
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      setup_handlers = {
        -- add custom handler
        jdtls = function(_, opts)
          vim.api.nvim_create_autocmd("Filetype", {
            pattern = "java", -- autocmd to start jdtls
            callback = function()
              if opts.root_dir and opts.root_dir ~= "" then require("jdtls").start_or_attach(opts) end
            end,
          })
        end,
      },
      config = {
        -- set jdtls server settings
        jdtls = {
          -- return the server config
          cmd = function()
            -- get the mason install path
            local install_path = require("mason-registry").get_package("jdtls"):get_install_path()

            -- get the current OS
            local os
            if vim.fn.has "macunix" then
              os = "mac"
            elseif vim.fn.has "win32" then
              os = "win"
            else
              os = "linux"
            end
            return {
              "java",
              "-Declipse.application=org.eclipse.jdt.ls.core.id1",
              "-Dosgi.bundles.defaultStartLevel=4",
              "-Declipse.product=org.eclipse.jdt.ls.core.product",
              "-Dlog.protocol=true",
              "-Dlog.level=ALL",
              "-javaagent:" .. install_path .. "/lombok.jar",
              "-Xms1g",
              "--add-modules=ALL-SYSTEM",
              "--add-opens",
              "java.base/java.util=ALL-UNNAMED",
              "--add-opens",
              "java.base/java.lang=ALL-UNNAMED",
              "-jar",
              vim.fn.glob(install_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
              "-configuration",
              install_path .. "/config_" .. os,
              "-data",
              workspace_dir,
            }
          end,
        },
        root_dir = function() return require("jdtls.setup").find_root(root_markers) end,
        settings = {
          java = {
            configuration = {
              -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
              -- And search for `interface RuntimeOption`
              -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
              -- TODO modify path
              runtimes = {
                -- {
                --   name = "JavaSE-21",
                --   path = "/opt/homebrew/Cellar/openjdk/21/"
                -- },
                {
                  name = "JavaSE-19",
                  path = "/Library/Java/JavaVirtualMachines/jdk-19.jdk/Contents/Home",
                },
                -- {
                --   name = "JavaSE-8",
                --   path = "/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home/",
                -- },
              },
            },
          },
        },
        on_attach = function(client, bufnr)
          if client.name == "jdtls" then
            -- catch exceptions
            if pcall(function() require("jdtls").setup_dap { hotcodereplace = "auto" } end) then
              vim.notify "jdtls setup dap"
            else
              vim.notify "jdtls setup dap failed"
            end
            -- launch.json style in VSCode
            if pcall(function() require("dap.ext.vscode").load_launchjs() end) then
              vim.notify "dap.ext.vscode load launchjs"
            else
              vim.notify "dap.ext.vscode load launchjs failed"
            end
            if pcall(function() require("jdtls.dap").setup_dap_main_class_configs() end) then
              vim.notify "jdtls.dap setup dap main class configs"
            else
              vim.notify "jdtls.dap setup dap main class configs failed"
            end
            vim.lsp.codelens.refresh()
          end
        end,
      },
      mappings = {
        n = {
          ["<leader>j"] = { desc = "JDT" },
          ["<leader>jj"] = { function() jdtls.test_class() end, desc = "Test class (DAP)" },
          ["<leader>jk"] = { function() jdtls.test_nearest_method() end, desc = "Test method (DAP)" },

          ["<leader>jo"] = { function() jdtls.organize_imports() end, desc = "organize imports" },
          ["<leader>jv"] = { function() jdtls.extract_variable() end, desc = "extract variable" },
          ["<leader>jc"] = { function() jdtls.extract_constant() end, desc = "extract constant" },
          ["<leader>jm"] = { function() jdtls.extract_method() end, desc = "extract method" },
          ["<Leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },

          -- a `cond` key can provided as the string of a server capability to be required to attach, or a function with `client` and `bufnr` parameters from the `on_attach` that returns a boolean
          ["<Leader>uY"] = {
            function() require("astrolsp.toggles").buffer_semantic_tokens() end,
            desc = "Toggle LSP semantic highlight (buffer)",
            cond = function(client)
              return client.supports_method "textDocument/semanticTokens/full" and vim.lsp.semantic_tokens ~= nil
            end,
          },
        },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "jdtls" },
    },
  },
}
