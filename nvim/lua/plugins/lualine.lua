local lint_progress = function()
  local linters = require("lint").get_running()
  if #linters == 0 then
    return "󰦕"
  end
  return "󱉶 " .. table.concat(linters, ", ")
end

return {
  "nvim-lualine/lualine.nvim",
  opts = {
    sections = {
      lualine_z = {
        "encoding",
        "fileformat",
        -- lint_progress,
      },
    },
  },
}
