return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      if vim.fn.executable("tsgo") == 1 then
        return
      end
      if vim.g._tsgo_global_install_started then
        return
      end
      vim.g._tsgo_global_install_started = true

      if vim.fn.executable("npm") ~= 1 then
        vim.schedule(function()
          vim.notify(
            "tsgo not found and npm is unavailable; install @typescript/native-preview globally",
            vim.log.levels.WARN
          )
        end)
        return
      end

      vim.system({ "npm", "install", "-g", "@typescript/native-preview" }, { text = true }, function(result)
        vim.schedule(function()
          if result.code == 0 then
            vim.notify("Installed @typescript/native-preview globally", vim.log.levels.INFO)
          else
            local err = (result.stderr and result.stderr ~= "") and result.stderr or result.stdout or "unknown error"
            vim.notify("Failed to install @typescript/native-preview globally: " .. err, vim.log.levels.ERROR)
          end
        end)
      end)
    end,
    opts = {
      servers = {
        vtsls = {
          enabled = false,
        },
        tsgo = {
          enabled = true,
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          settings = {
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
            },
          },
        },
      },
    },
  },
}
