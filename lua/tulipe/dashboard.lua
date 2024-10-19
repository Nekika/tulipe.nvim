local M = {}

local Dashboard = {}

function Dashboard:new(client)
  local o = { client = client }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Dashboard:show()
  local events = self.client:list()
  local lines = require("tulipe/events").lines(events)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
  vim.api.nvim_open_win(buf, true, { relative = 'editor', width = 100, height = 100, col = 55, row = 40 })
end

function M.new(client)
  return Dashboard:new(client)
end

return M
