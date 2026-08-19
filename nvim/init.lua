-- require("config.options")
-- require("config.debug-startup").start_profiling()

-- bootstrap lazy.nvim, LazyVim and your plugins
local ws = require("workspace")

local path_prepend = ws.get_or("path_prepend", {})
if #path_prepend > 0 then
  local separator = package.config:sub(1, 1) == "\\" and ";" or ":"
  local prefix = table.concat(path_prepend, separator)
  vim.env.PATH = prefix .. separator .. (vim.env.PATH or "")
end

require("config.lazy")

local function set_guifont_safe(font_spec)
  if type(font_spec) ~= "string" or font_spec == "" then
    return
  end

  local candidates = {}
  if font_spec:find(",", 1, true) then
    for part in font_spec:gmatch("[^,]+") do
      local font = vim.trim(part)
      if font ~= "" then
        table.insert(candidates, font)
      end
    end
  else
    table.insert(candidates, font_spec)
  end

  for _, font in ipairs(candidates) do
    local ok = pcall(function()
      vim.opt.guifont = font
    end)
    if ok then
      return
    end
  end
end

if vim.fn.has("gui_running") == 1 and ws.get("font") then
  set_guifont_safe(ws.get("font"))
end
