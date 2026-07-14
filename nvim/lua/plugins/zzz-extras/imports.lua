local ws = require("workspace")

local extra_imports = {
  ai = {
    "lazyvim.plugins.extras.ai.avante",
  },
  cpp = {
    "lazyvim.plugins.extras.lang.clangd",
    "lazyvim.plugins.extras.lang.cmake",
  },
  python = {
    "lazyvim.plugins.extras.lang.python",
    "lazyvim.plugins.extras.dap.core",
    "lazyvim.plugins.extras.test.core",
  },
}

local specs = {}

for _, lang in ipairs(ws.getOrDefault("lang", {})) do
  for _, import in ipairs(extra_imports[lang] or {}) do
    table.insert(specs, { import = import })
  end
end

return specs
