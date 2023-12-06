local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
        command = vim.fn.exepath "js-debug-adapter",
        args = { "${port}" },
    },
}

for _, language in ipairs({ "typescript", "javascript" }) do
  dap.configurations[language] = {
    {
      name = "Debug Local App",
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
    {
      name = "Docker: Attach to App",
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
  }
end
