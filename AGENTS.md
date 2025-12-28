# AGENTS.md

This repository contains personal dotfiles and editor/tooling configuration. It is **not** a traditional application with a build pipeline, but agentic coding tools should still follow consistent commands, style, and safety rules when modifying files here.

The scope of this file is the **entire repository**.

---

## Project Overview

- Primary focus: Neovim configuration (`nvim/`, Lua-based)
- Supporting tools:
  - `tmux/` – tmux configuration and helper scripts
  - `starship/` – Starship prompt configuration
  - Shell config: `.zshrc`
- Package manager: `lazy.nvim` (for Neovim plugins)
- Formatting tool: `stylua`

This repo is intended to be **manually curated**. Changes should be minimal, deliberate, and consistent with existing patterns.

---

## Build, Lint, and Test Commands

There is no global build or test suite. Validation is tool-specific.

### Neovim

- Launch Neovim with this config:
  ```sh
  nvim
  ```

- Check Neovim health:
  ```sh
  :checkhealth
  ```

- Sync plugins (Lazy.nvim):
  ```sh
  :Lazy sync
  ```

- Update plugins:
  ```sh
  :Lazy update
  ```

### Lua Formatting

- Format all Lua files:
  ```sh
  stylua .
  ```

- Format a single file:
  ```sh
  stylua nvim/lua/config/options.lua
  ```

Configuration is defined in `stylua.toml`. Do not override it.

### Lua Linting (Optional / Manual)

- If `luacheck` is installed:
  ```sh
  luacheck nvim/lua
  ```

No luacheck config is currently committed; follow existing patterns.

### tmux

- Reload tmux config:
  ```sh
  tmux source-file tmux/tmux.conf
  ```

### Starship

- Validate config:
  ```sh
  starship config
  ```

---

## Editing and Safety Rules

- Never assume this repo is disposable — it is a live user environment
- Avoid destructive commands (`rm -rf`, overwriting large files)
- Do not add telemetry, analytics, or auto-updating logic
- Do not introduce new external dependencies unless explicitly requested
- Prefer editing existing files over adding new ones

---

## Code Style Guidelines

### Lua (Neovim Configuration)

**Formatting**
- Follow `stylua.toml` exactly
- Use 2 spaces indentation
- No trailing whitespace
- One statement per line

**Imports / Requires**
- Use local requires at top of file:
  ```lua
  local vim = vim
  local map = vim.keymap.set
  ```
- Group requires logically (config, utils, plugins)
- Avoid circular dependencies

**Naming Conventions**
- `snake_case` for local variables and functions
- `PascalCase` only when required by plugin APIs
- Descriptive names preferred over brevity

**Structure**
- Config files should:
  - Declare options first
  - Define helpers second
  - Register mappings/autocmds last
- Plugin specs belong in `nvim/lua/plugins/`

**Types / Assumptions**
- Lua is dynamically typed; rely on conventions
- Prefer explicit defaults over nil behavior
- Validate plugin availability with `pcall(require, ...)`

**Error Handling**
- Use `pcall` when loading plugins or optional modules
- Fail silently for optional tooling
- Do not raise errors during startup unless critical

Example:
```lua
local ok, mod = pcall(require, "some_plugin")
if not ok then
  return
end
```

---

## Neovim Plugin Guidelines

- Use Lazy.nvim spec format
- Keep plugin configs small and focused
- Prefer inline `opts = {}` over large setup functions
- Avoid global side effects
- Do not re-map default LazyVim behavior unless intentional

---

## Shell Configuration (.zshrc)

- POSIX-compatible where possible
- Avoid heavy logic in shell startup
- Prefer functions over aliases for complex behavior
- No interactive prompts or output during non-interactive shells

---

## tmux Scripts

- Use `#!/usr/bin/env bash`
- Enable strict mode where reasonable:
  ```sh
  set -euo pipefail
  ```
- Scripts must be executable
- Avoid dependencies beyond coreutils

---

## Starship Configuration

- TOML only
- Keep prompt fast (no long-running commands)
- Prefer built-in modules over custom commands

---

## Cursor / Copilot Rules

- No `.cursor/rules/`, `.cursorrules`, or `.github/copilot-instructions.md` files exist in this repository at time of writing
- If added later, those rules take precedence and should be reflected here

---

## Agent Behavior Expectations

When operating in this repo, agents should:

- Make minimal, high-signal changes
- Preserve user preferences and workflows
- Ask before large refactors or new files
- Never auto-commit or auto-push unless explicitly instructed
- Prefer clarity and consistency over novelty

This repo values **stability and predictability** over experimentation.
