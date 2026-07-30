local M = {}

function M.smart_tab()
  local copilot = require("copilot.suggestion")
  if copilot.is_visible() then
    copilot.accept("<M-CR>")
  elseif vim.fn.pumvisible() == 1 then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-n>", true, false, true), "n", false)
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
  end
end

return M