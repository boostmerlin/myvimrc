local M = {}

local function is_list(t)
  if type(t) ~= "table" then
    return false
  end

  local count = 0
  local max = 0

  for k, _ in pairs(t) do
    if type(k) ~= "number" or k <= 0 or math.floor(k) ~= k then
      return false
    end
    if k > max then
      max = k
    end
    count = count + 1
  end

  return max == count
end

---@param value any
---@param indent string
local function encode(value, indent)
  local t = type(value)

  if t == "string" then
    return string.format("%q", value)
  elseif t == "number" or t == "boolean" then
    return tostring(value)
  elseif t == "table" then
    local list = is_list(value)
    local parts = {}
    local next_indent = indent .. "  "

    if list then
      ---@diagnostic disable-next-line: no-unknown
      for _, v in ipairs(value) do
        local e = encode(v, next_indent)
        if e then
          table.insert(parts, next_indent .. e)
        end
      end
      return "[\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "]"
    else
      local keys = vim.tbl_keys(value)
      table.sort(keys)
      ---@diagnostic disable-next-line: no-unknown
      for _, k in ipairs(keys) do
        local e = encode(value[k], next_indent)
        if e then
          table.insert(parts, next_indent .. string.format("%q", k) .. ": " .. e)
        end
      end
      return "{\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "}"
    end
  end
end

M.data = {}
local path = vim.fn.stdpath("config") .. "/workspace.json"

function M.load()
  local f = io.open(path, "r")
  if f then
    local data = f:read("*a")
    f:close()
    local ok, json = pcall(vim.json.decode, data, { luanil = { object = true, array = true } })
    if ok then
      M.data = json
      local env = json["env"]
      if env ~= nil then
        for key, value in pairs(env) do
          vim.fn.setenv(key, value)
        end
      end
    end
  end
end

function M.save()
  local f = io.open(path, "w")
  if f then
    f:write(encode(M.data, ""))
    f:close()
  end
end

function M.getFromData(data, ...)
  local value = data
  for _, v in ipairs({ ... }) do
    value = value[v]
    if value == nil then
      break
    end
  end
  return value
end

function M.get(...)
  return M.getFromData(M.data, ...)
end

return M
