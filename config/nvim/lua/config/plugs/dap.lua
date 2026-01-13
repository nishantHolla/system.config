local dap = require("dap")
local dapui = require("dapui")

dapui.setup()

require("nvim-dap-virtual-text").setup({
  enabled = true,
  enabled_commands = true,
  highlight_changed_variables = true,
  highlight_new_as_changed = false,
  show_stop_reason = true,
  commented = false,
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

-- C/C++

dap.adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = "/usr/bin/codelldb",
    args = {"--port", "${port}"},
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file (codelldb)",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    terminal = 'integrated',
    stdio = {nil, nil, nil},
  },
}

dap.configurations.c = dap.configurations.cpp

-- Keymaps

Key("n", "<leader>1", dap.continue, K_Opt("Dap continue"))
Key("n", "<leader>2", dap.step_over, K_Opt("Dap step over"))
Key("n", "<leader>3", dap.step_into, K_Opt("Dap step into"))
Key("n", "<leader>4", dap.step_out, K_Opt("Dap step out"))

Key("n", "<leader>b", dap.toggle_breakpoint, K_Opt("Dap toggle breakpoint"))
Key("n", "<leader>B", function()
  dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
end, K_Opt("Dap conditional breakpoint"))

Key("n", "<leader>dr", dap.repl.open, K_Opt("Dap Open REPL"))
Key("n", "<leader>dl", dap.run_last,  K_Opt("Dap Run Last"))
Key("n", "<leader>dt", dapui.toggle,  K_Opt("Dap Toggle UI"))
