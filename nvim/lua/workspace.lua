local M = {}

-- private state
local _loaded = false
local _path = vim.fn.stdpath("config") .. "/workspace-nvim.json"

---@param value table
---@return boolean
local function is_array(value)
  if type(value) ~= "table" then
    return false
  end
  local count, max = 0, 0
  for k in pairs(value) do
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
---@return string?
local function to_json(value, indent)
  local vtype = type(value)
  if vtype == "string" then
    return string.format("%q", value)
  elseif vtype == "number" or vtype == "boolean" then
    return tostring(value)
  elseif vtype == "table" then
    local parts = {}
    local next_indent = indent .. "  "
    if is_array(value) then
      for _, item in ipairs(value) do
        local encoded = to_json(item, next_indent)
        if encoded then
          table.insert(parts, next_indent .. encoded)
        end
      end
      return "[\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "]"
    else
      local keys = vim.tbl_keys(value)
      table.sort(keys)
      for _, key in ipairs(keys) do
        local encoded = to_json(value[key], next_indent)
        if encoded then
          table.insert(parts, next_indent .. string.format("%q", key) .. ": " .. encoded)
        end
      end
      return "{\n" .. table.concat(parts, ",\n") .. "\n" .. indent .. "}"
    end
  end
end

---@param data table
---@return any
local function get_nested(data, ...)
  local value = data
  for _, key in ipairs({ ... }) do
    value = value[key]
    if value == nil then
      break
    end
  end
  return value
end

local function ensure_loaded()
  if not _loaded then
    M.load()
  end
end

M.data = {}

function M.load()
  local file = io.open(_path, "r")
  if file then
    local raw = file:read("*a")
    file:close()
    local ok, decoded = pcall(vim.json.decode, raw, { luanil = { object = true, array = true } })
    if ok then
      M.data = decoded
      local env = decoded["env"]
      if env ~= nil then
        for key, value in pairs(env) do
          vim.fn.setenv(key, value)
        end
      end
    end
  end
  _loaded = true
  return M
end

function M.save()
  local file = io.open(_path, "w")
  if file then
    file:write(to_json(M.data, ""))
    file:close()
  end
end

function M.get(...)
  ensure_loaded()
  return get_nested(M.data, ...)
end

---Last argument is the default value; preceding arguments are nested keys.
function M.get_or(...)
  ensure_loaded()
  local n = select("#", ...)
  assert(n >= 2, "get_or needs at least 2 arguments")
  local args = { ... }
  local default = args[n]
  local value = get_nested(M.data, unpack(args, 1, n - 1))
  return value ~= nil and value or default
end

return M
