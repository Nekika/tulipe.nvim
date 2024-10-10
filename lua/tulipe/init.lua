local M = {}

function M.setup(_opts)
  local socket = require("socket").connect("localhost", 9898)

  for _, event in ipairs(require("tulipe/events").Events) do
    vim.api.nvim_create_autocmd(event, {
      callback = function() socket:send(event .. '\n') end
    })
  end
end

return M
