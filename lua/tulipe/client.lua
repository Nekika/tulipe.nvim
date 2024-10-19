local M = {}

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

local function receive_response(socket)
  local response = socket:receive("*l")
  return string.gsub(response, "\n", "")
end

local Client = {}

function Client:new(host, port)
  local socket = require("socket").connect(host, port)
  if socket == nil then error("unabled to connect the the server") end
  local o = { socket = socket }
  setmetatable(o, self)
  self.__index = self
  return o
end

function Client:list(filter)
  filter = filter or {}
  local event = trim(filter.event or "")
  send_command(self.socket, { action = "LIST", event = event })
  local response = receive_response(self.socket)
  return require("tulipe/events").parse(response)
end

function Client:report(event)
  send_command(self.socket, { action = "REPORT", event = event })
  local response = receive_response(self.socket)
  if response ~= "OK" then error(string.format("error: %s", response)) end
end

function M.new(host, port)
  return Client:new(host, port)
end

return M
