local M = {}

local function start(client)
  for _, event in ipairs(require("tulipe/events").Events) do
    vim.api.nvim_create_autocmd(event, {
      callback = function() client:report(event) end
    })
  end
end

function M.setup(opts)
  local host = opts.host or "localhost"
  local port = opts.port or 9898

  local client = require("tulipe/client").new(host, port)

  if vim.v.vim_did_enter then
    start(client)
  else
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function() start(client) end
    })
  end
end

return M
