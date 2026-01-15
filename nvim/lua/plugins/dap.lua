return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "leoluz/nvim-dap-go",
        "igorlfs/nvim-dap-view",
    },
    keys = {
        { "<leader>dc", "<cmd>DapContinue<cr>", desc = "DAP Continue" },
        { "<leader>db", "<cmd>DapToggleBreakpoint<cr>", desc = "DAP Toggle Breakpoint" },
        { "<leader>di", "<cmd>DapStepInto<cr>", desc = "DAP Step Into" },
        { "<leader>do", "<cmd>DapStepOver<cr>", desc = "DAP Step Over" },
        { "<leader>dO", "<cmd>DapStepOut<cr>", desc = "DAP Step Out" },
        { "<leader>dr", "<cmd>DapRestartFrame<cr>", desc = "DAP Restart Frame" },
        { "<leader>dq", "<cmd>DapTerminate<cr>", desc = "DAP Terminate" },
        { "<leader>du", "<cmd>DapUp<cr>", desc = "DAP Up" },
        { "<leader>dd", "<cmd>DapDown<cr>", desc = "DAP Down" },
        { "<leader>dt", "<cmd>DapViewToggle<cr>", desc = "DAP View Toggle" },
        { "<leader>dw", "<cmd>DapViewWatch<cr>", desc = "DAP View Watch" },
    },
    config = function()
        require("nvim-dap-virtual-text").setup({})
        require("dap-go").setup()

        local dap = require("dap")
        dap.configurations.go = dap.configurations.go or {}
        table.insert(dap.configurations.go, {
            type = "go",
            name = "Debug (go run ./cmd/<app>)",
            request = "launch",
            program = function()
                return vim.fn.input("Go package dir: ")
            end,
            cwd = "${workspaceFolder}",
        })
    end,
}
