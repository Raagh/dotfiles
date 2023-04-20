local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_vscode_js_ok, dap_vscode_js = pcall(require, "dap-vscode-js")
if not dap_vscode_js_ok then
  return
end

dap_vscode_js.setup({
  debugger_path = vim.fn.stdpath('data') .. "/mason/packages/js-debug-adapter",                -- Path to vscode-js-debug installation.
  node_path = "node",                                                                          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
  adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
})

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      name = "Debug Local App",
      request = "launch",
      runtimeArgs = {
        "run",
        "dev"
      },
      runtimeExecutable = "npm",
      skipFiles = {
        "<node_internals>/**"
      },
      type = "pwa-node",
      envFile = "${workspaceFolder}/.env.local",
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
    {
      name = "Docker: Attach to Node",
      type = "pwa-node",
      request = "attach",
      restart = true,
      port = 9229,
      localRoot = "${workspaceFolder}",
      remoteRoot = "/usr/src/app",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
      protocol = "inspector",
      cwd = "${workspaceFolder}",
    },
    {
      name = "Debug Local App: Watch",
      request = "launch",
      runtimeArgs = {
        "run",
        "dev:watch"
      },
      runtimeExecutable = "npm",
      skipFiles = {
        "<node_internals>/**"
      },
      type = "pwa-node",
      envFile = "${workspaceFolder}/.env.local",
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    },
  }
end
