return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>e",
        function()
          require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
        end,
        desc = "Explorer",
      },
      {
        "<leader>E",
        false,
      },
      { "<leader>fe", false },
      { "<leader>fE", false },
    },
    opts = {
      window = {
        position = "float",
      },
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>/", false },
      { "<leader>,", false },
      { "<leader><space>", false },
      -- { "<leader>s", false },
      {
        "<leader>fl",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume last search",
      },
      {
        "<leader>fg",
        function()
          require("telescope.builtin").live_grep({ hidden = true })
        end,
        desc = "Live grep",
      },
    },
    opts = {
      pickers = {
        find_files = {
          previewer = false,
          hidden = true,
          theme = "dropdown",
        },
        live_grep = {
          additional_args = function(_)
            return { "--hidden" }
          end,
        },
        colorscheme = {
          enable_preview = true,
        },
      },
    },
  },
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      -- opts.window = {
      --   documentation = {
      --     border = "rounded",
      --     winhighlight = "NormalFloat:TelescopeNormal,FloatBorder:TelescopeBorder",
      --   },
      -- }

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  -- {
  --   "akinsho/toggleterm.nvim",
  --   opts = {
  --     direction = "float",
  --     float_opts = {
  --       border = "none",
  --       width = 100000,
  --       height = 100000,
  --     },
  --   },
  --   keys = {
  --     { "<C-/>", "<cmd>ToggleTerm<cr>", desc = "Open ToggleTerm" },
  --     { "<leader>ft", "<cmd>ToggleTerm<cr>", desc = "Open ToggleTerm" },
  --   },
  -- },
}
