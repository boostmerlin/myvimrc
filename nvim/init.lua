-- require("config.options")
-- require("config.debug-startup").start_profiling()

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local ws = require("workspace").load()
if vim.fn.has("gui_running") == 1 and ws.get("font") then
  vim.opt.guifont = ws.get("font")
end
