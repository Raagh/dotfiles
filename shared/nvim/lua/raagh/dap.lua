local henchman = require("utils.henchman")

local function setup_adapter(dap)
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = vim.fn.exepath("js-debug-adapter"),
      args = { "${port}" },
    },
  }
end

local function build_henchman_configs()
  return {
    {
      name = "All Services (watch:node)",
      type = "pwa-node",
      request = "launch",
      runtimeExecutable = "yarn",
      runtimeArgs = { "watch:node" },
      cwd = "${workspaceFolder}",
      rootPath = "${workspaceFolder}",
      outFiles = {
        "${workspaceFolder}/services/**/lib/**/*.js",
        "${workspaceFolder}/packages/**/lib/**/*.js",
        "!**/node_modules/**",
      },
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      name = "Launch Service (pick)",
      type = "pwa-node",
      request = "launch",
      runtimeExecutable = function()
        return vim.fn.getcwd() .. "/node_modules/.bin/tsx"
      end,
      runtimeArgs = { "watch", "--env-file=.env" },
      program = "src/index.ts",
      cwd = function()
        local root = vim.fn.getcwd()
        local services_dir = root .. "/services"
        local entries = vim.fn.readdir(services_dir)
        local services = vim.tbl_filter(function(name)
          return vim.fn.isdirectory(services_dir .. "/" .. name) == 1
        end, entries)
        table.sort(services)

        local co = coroutine.running()
        Snacks.picker.select(services, { prompt = "Debug service" }, function(choice)
          coroutine.resume(co, choice)
        end)
        local chosen = coroutine.yield()

        if chosen then
          return services_dir .. "/" .. chosen
        end
      end,
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      resolveSourceMapLocations = function()
        local root = vim.fn.getcwd()
        return {
          root .. "/services/**",
          root .. "/packages/**",
          "!**/node_modules/**",
        }
      end,
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      name = "Attach to Node (9229)",
      type = "pwa-node",
      request = "attach",
      port = 9229,
      cwd = "${workspaceFolder}",
      outFiles = {
        "${workspaceFolder}/services/**/lib/**/*.js",
        "${workspaceFolder}/packages/**/lib/**/*.js",
        "!**/node_modules/**",
      },
      sourceMaps = true,
      skipFiles = { "<node_internals>/**" },
      resolveSourceMapLocations = {
        "${workspaceFolder}/services/**",
        "${workspaceFolder}/packages/**",
        "!**/node_modules/**",
      },
    },
  }
end

-- Replace the built-in "dap.launch.json" provider so that in a henchman
-- project it returns our 3 configs instead of reading .vscode/launch.json.
-- For every other project the original provider runs unchanged.
local function install_config_guard(dap)
  local orig = dap.providers.configs["dap.launch.json"]
  dap.providers.configs["dap.launch.json"] = function(bufnr)
    if henchman.is_henchman_project(vim.fn.getcwd()) then
      return build_henchman_configs()
    end
    return orig(bufnr)
  end
end

return function()
  local dap = require("dap")
  setup_adapter(dap)
  install_config_guard(dap)
end
