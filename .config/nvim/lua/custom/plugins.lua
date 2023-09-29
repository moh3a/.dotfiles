local plugins = {
 -- added this package for linting (eslint) because null-ls is archived
  {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    config = function()
      require("custom.configs.lint")
    end,
  },
  -- added this package for code fomatting (prettier)
  {
    "mhartington/formatter.nvim",
    event = "VeryLazy",
    opts = function()
      return require("custom.configs.formatter")
    end,
  },
  {
    "mfussenegger/nvim-dap",
    config = function ()
      require("custom.configs.dap")
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      require("dapui").setup()
      dap.listeners.after.event_initialized["dapui_config"] = function ()
        dapui.open()
      end
      dap.listeners.after.event_terminated["dapui_config"] = function ()
        dapui.close()
      end
      dap.listeners.after.event_exited["dapui_config"] = function ()
        dapui.close()
      end
    end
  }
}

return plugins
