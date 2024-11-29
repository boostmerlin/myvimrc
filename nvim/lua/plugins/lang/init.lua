local ws = require("workspace")
local specs = {}

for _, v in ipairs(ws.getOrDefault("lang", {})) do
  table.insert(specs, require("plugins/lang/" .. v))
end

return specs
