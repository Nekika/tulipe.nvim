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

local function trim(str)
  return string.gsub(str, "%s+", "")
end

local function send_command(socket, command)
  local action = trim(command.action or "")
  local event = trim(command.event or "")
  if action == "" then error("command's action is mandatory") end
  local message = string.format("%s %s", action, event)
  socket:send(message .. "\n")
end

function Client:report(event)
  send_command(self.socket, { action = "REPORT", event = event })
end

function M.new(host, port)
  return Client:new(host, port)
end

return M
