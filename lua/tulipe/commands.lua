local M = {}

function M.register(dashboard)
  vim.api.nvim_create_user_command('TulipeDashboard', function() dashboard:show() end, {})
end

return M
