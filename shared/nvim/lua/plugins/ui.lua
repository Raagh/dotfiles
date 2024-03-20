return {
  {
    "LazyVim/LazyVim",
    priority = 100,
    opts = function(_, _)
      vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapBreakpoint", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "ﳁ", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
      )
      vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapLogPoint", linehl = "", numhl = "" })
      vim.fn.sign_define(
        "DapStopped",
        { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
      )
    end,
  },

  {
    "akinsho/bufferline.nvim",
    keys = {
      {
        "[b",
        function()
          require("bufferline").move(-1)
        end,
        desc = "Move Buffer Left",
      },
      {
        "]b",
        function()
          require("bufferline").move(1)
        end,
        desc = "Move Buffer Right",
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      --   Warn  15:34:01 notify.warn DAP Debug adapter didn't respond. Either the adapter is slow (then wait and ignore this) or there is a problem with your adapter or `pwa-node` configuration. Check the logs for errors (:help dap.set_log_level)
      table.insert(opts.routes, {
        filter = {
          event = "dap",
          find = "Debug adapter didn't respond. Either the adapter is slow (then wait and ignore this) or there is a problem with your adapter or `pwa-node` configuration. Check the logs for errors (:help dap.set_log_level)",
        },
        opts = { skip = true },
      })

      opts.presets = {
        lsp_doc_border = true,
        command_palette = {
          views = {
            cmdline_popup = {
              position = {
                row = "50%",
              },
            },
          },
        },
      }
    end,
  },
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
██████╗ ███╗   ███╗██╗  ██╗
██╔══██╗████╗ ████║╚██╗██╔╝
██████╔╝██╔████╔██║ ╚███╔╝ 
██╔══██╗██║╚██╔╝██║ ██╔██╗ 
██║  ██║██║ ╚═╝ ██║██╔╝ ██╗
╚═╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝
                           
██████╗  █████╗  █████╗  ██████╗ ██╗  ██╗
██╔══██╗██╔══██╗██╔══██╗██╔════╝ ██║  ██║
██████╔╝███████║███████║██║  ███╗███████║
██╔══██╗██╔══██║██╔══██║██║   ██║██╔══██║
██║  ██║██║  ██║██║  ██║╚██████╔╝██║  ██║
╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
          -- stylua: ignore
          center = {
            { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = "󰦛 ", key = "s" },
            { action = 'Telescope find_files hidden=true theme=dropdown',          desc = " Find file",       icon = " ", key = "f" },
            { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
            { action = "Telescope live_grep",                                      desc = " Find text",       icon = " ", key = "g" },
            { action = "ene | startinsert",                                        desc = " New file",        icon = " ", key = "n" },
            { action = "edit $MYVIMRC",                                            desc = " Config",          icon = " ", key = "c" },
            { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
            { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
            { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },
  {
    "folke/which-key.nvim",
    keys = {
      {
        "<leader>ur",
        "<cmd>:e %<cr>",
        desc = "Reload File",
      },
    },
    opts = {
      window = {
        border = "rounded",
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        border = "rounded",
      },
    },
  },
  {
    "folke/flash.nvim",
    opts = {
      modes = {
        -- Disable labels for regular search with `/`
        search = {
          enabled = false,
        },
        -- Disable labels for motions like f, t, F, T
        char = {
          enabled = false,
        },
      },
    },
  },
}
