local M = {}

local Client = {}

function Client:new(host, port)
  local socket = require("socket").connect(host, port)
  if socket == nil then error("unabled to connect the the server") end
  local o = { socket = socket }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Client:report(event)
  self:send("REPORT:" .. event)
end

function Client:send(message)
  self.socket:send(message .. "\n")
end

function M.new(host, port)
  return Client:new(host, port)
end

return M
