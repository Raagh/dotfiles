return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "haydenmeade/neotest-jest",
    },
    opts = {
      discovery = {
        enabled = false,
      },
      quickfix = {
        enabled = true,
        open = false,
      },
      adapters = {
        ["neotest-jest"] = {
          jestCommand = "yarn test --",
          jestConfigFile = function()
            local file = vim.fn.expand("%:p")
            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
            end

            if string.find(file, "/services/") then
              return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
            end

            return vim.fn.getcwd() .. "/jest.config.js"
          end,
          cwd = function()
            local file = vim.fn.expand("%:p")

            if string.find(file, "/packages/") then
              return string.match(file, "(.-/[^/]+/)src")
            end

            if string.find(file, "/services/") then
              return string.match(file, "(.-/[^/]+/)src")
            end

            return vim.fn.getcwd()
          end,
        },
      },
      summary = {
        open = "topleft vsplit | vertical resize 50",
      },
    },
  },
}
