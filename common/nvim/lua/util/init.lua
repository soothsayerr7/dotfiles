local M = {}

function M.keymap(desc_arg, lhs_arg, rhs_arg, mode_arg)
  mode_arg = mode_arg or 'n'
  vim.keymap.set(mode_arg, lhs_arg, rhs_arg, { desc = desc_arg })
  return { lhs_arg, rhs_arg, mode_arg, desc = desc_arg }
end

function M.pwsh()
  local o = vim.o
  if vim.fn.executable('pwsh') == 1 then
    o.shell = 'pwsh'
    o.shellcmdflag = '-NoLogo -NonInteractive -ExecutionPolicy RemoteSigned -Command ' ..
    '[Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new();' ..
    '$PSDefaultParameterValues[\'Out-File:Encoding\']=\'utf8\';' ..
    '$PSStyle.OutputRendering=\'plaintext\';' ..
    'Remove-Alias -Force -ErrorAction SilentlyContinue tee;'
    o.shellredir = '2>&1 | %%{ "$_" } | Out-File %s; exit $LastExitCode'
    o.shellpipe = '2>&1 | %%{ "$_" } | Tee-Object %s; exit $LastExitCode'
    o.shellquote, o.shellxquote = '', ''
  end
end

return M
