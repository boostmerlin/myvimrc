-- bootstrap lazy.nvim, LazyVim and your plugins
local ws = require("workspace").load()
require("config.lazy")

if vim.fn.has("gui_running") == 1 and ws.get("font") then
  vim.opt.guifont = ws.get("font")
end
