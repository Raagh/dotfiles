local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
  return
end

neotest.setup({
  discovery = {
    enabled = false,
  },
  quickfix = {
    enabled = true,
    open = false,
  },
  adapters = {
    require('neotest-jest')({
      jestCommand = "yarn test --",
      jestConfigFile = function()
        local file = vim.fn.expand('%:p')
        if string.find(file, "/packages/") then
          return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
        end

        if string.find(file, "/services/") then
          return string.match(file, "(.-/[^/]+/)src") .. "jest.config.js"
        end

        return vim.fn.getcwd() .. "/jest.config.js"
      end,
      cwd = function()
        local file = vim.fn.expand('%:p')

        if string.find(file, "/packages/") then
          return string.match(file, "(.-/[^/]+/)src")
        end

        if string.find(file, "/services/") then
          return string.match(file, "(.-/[^/]+/)src")
        end

        return vim.fn.getcwd()
      end
    }),
  },
  summary = {
    open = "topleft vsplit | vertical resize 50"
  }
})
