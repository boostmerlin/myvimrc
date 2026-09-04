local function explorer_cursor_dir()
  local picker = Snacks.picker.get({ source = "explorer" })[1]
  local item = picker and picker:current()
  if not item or not item.file then
    vim.notify("No Explorer item under cursor", vim.log.levels.WARN)
    return
  end

  return item.dir and item.file or vim.fs.dirname(item.file)
end

return {
  "folke/snacks.nvim",
  keys = {
    {
      "<leader>jg",
      function()
        local dir = explorer_cursor_dir()
        if dir then
          Snacks.picker.grep({ cwd = dir })
        end
      end,
      desc = "Grep in Explorer Cursor Dir",
    },
    {
      "<leader>jw",
      function()
        local dir = explorer_cursor_dir()
        if not dir then
          return
        end

        local word = vim.fn.expand("<cword>")
        if word == "" then
          vim.notify("No word under cursor", vim.log.levels.INFO)
          return
        end

        Snacks.picker.grep({ cwd = dir, search = word })
      end,
      desc = "Grep cword in Explorer Cursor Dir",
    },
    {
      "<leader>jG",
      function()
        local dir = explorer_cursor_dir()
        if not dir then
          return
        end

        vim.ui.input({
          prompt = "Grep directory: ",
          default = dir,
          completion = "dir",
        }, function(input)
          if not input or input == "" then
            return
          end

          local dir = vim.fn.fnamemodify(vim.fn.expand(input), ":p")
          if vim.fn.isdirectory(dir) ~= 1 then
            vim.notify("Not a directory: " .. dir, vim.log.levels.ERROR)
            return
          end

          Snacks.picker.grep({ cwd = dir })
        end)
      end,
      desc = "Grep in Selected Dir",
    },
  },
}
