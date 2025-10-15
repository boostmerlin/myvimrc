-- extra config for specific languages. default is in Zzz...
-- BUT:
-- you MAY MUST enable plugin in :LazyExtra first!
-- e.g. for python, enable `lazyvim.plugins.extras.lang.python`
-- test.core
-- dap.core

-- plugins 目录下似乎是按字母顺序加载的

local ws = require("workspace")
local specs = {}

for _, v in ipairs(ws.getOrDefault("lang", {})) do
  table.insert(specs, require("plugins/zzz-extras/" .. v))
end

return specs
