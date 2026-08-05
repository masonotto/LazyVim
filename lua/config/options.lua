-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Check if 'pwsh' (PowerShell Core) is executable and set the shell accordingly
if vim.fn.executable("pwsh") == 1 then
  vim.o.shell = "pwsh"
elseif vim.fn.executable("powershell.exe") == 1 then
  -- Fallback to Windows PowerShell if pwsh is not found
  vim.o.shell = "powershell.exe"
end

-- Setting shell command flags for PowerShell compatibility
-- These flags are important for proper command execution and output encoding
vim.o.shellcmdflag =
  "-NoLogo -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();$PSDefaultParameterValues['Out-File:Encoding']='utf8';"
vim.o.shellredir = "2>&1 | Out-File %s; exit $LastExitCode"
vim.o.shellpipe = "2>&1 | Out-File %s; exit $LastExitCode"

vim.g.snacks_animate = false

-- Add this at the very end of your init.lua
local function disable_formatting()
  local hl_groups = vim.api.nvim_get_hl(0, {})
  for group_name, hl_info in pairs(hl_groups) do
    if hl_info.italic or hl_info.bold then
      local new_hl = vim.deepcopy(hl_info)
      new_hl.italic = false
      new_hl.bold = false
      -- Use nvim_set_hl to override the group
      vim.api.nvim_set_hl(0, group_name, new_hl)
    end
  end
end

-- Run it on startup and whenever you change your colorscheme
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = disable_formatting,
})

-- Initial run
disable_formatting()
