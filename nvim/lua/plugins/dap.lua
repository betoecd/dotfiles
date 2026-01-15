local function pick_script()
    local pilot = require("package-pilot")

    local current_dir = vim.fn.getcwd()
    local package = pilot.find_package_file({ dir = current_dir })

    if not package then
        vim.notify("No package.json found", vim.log.levels.ERROR)
        return require("dap").ABORT
    end

    local scripts = pilot.get_all_scripts(package)

    local label_fn = function(script)
        return script
    end

    local co, ismain = coroutine.running()
    local ui = require("dap.ui")
    local pick = (co and not ismain) and ui.pick_one or ui.pick_one_sync
    local result = pick(scripts, "Select script", label_fn)
    return result or require("dap").ABORT
end

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "theHamsta/nvim-dap-virtual-text",
        "leoluz/nvim-dap-go",
        "igorlfs/nvim-dap-view",
        "banjo/package-pilot.nvim",
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
    opts = function(_, opts)
        local dap = require("dap")
        local js_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

        local current_file = vim.fn.expand("%:t")
        local cwd = function()
            return vim.fn.getcwd()
        end

        for _, language in ipairs(js_filetypes) do
            dap.configurations[language] = {
                {
                    type = "pwa-node",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = cwd,
                },
                {
                    type = "pwa-node",
                    request = "attach",
                    name = "Attach",
                    processId = require("dap.utils").pick_process,
                    cwd = cwd,
                },
                {
                    name = "tsx (" .. current_file .. ")",
                    type = "node",
                    request = "launch",
                    program = "${file}",
                    runtimeExecutable = "tsx",
                    cwd = cwd,
                    console = "integratedTerminal",
                    internalConsoleOptions = "neverOpen",
                    skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
                },
                {
                    type = "node",
                    request = "launch",
                    name = "pick script (pnpm)",
                    runtimeExecutable = "pnpm",
                    runtimeArgs = { "run", pick_script },
                    cwd = cwd,
                },
            }
        end

        return opts
    end,
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
            cwd = function()
                return vim.fn.getcwd()
            end,
        })
    end,
}
