-- snacks.nvim terminal 配置

-- Shell 配置管理器
local shell_manager = {
  current_shell = vim.o.shell,
  current_args = {},
  
  -- 预设的 shell 配置
  presets = {
    ["PowerShell 7+"] = { cmd = "pwsh", args = { "-NoLogo" } },
    ["PowerShell 5.1"] = { cmd = "powershell", args = { "-NoLogo" } },
    ["CMD"] = { cmd = "cmd", args = { "/k" } },
    ["Bash"] = { cmd = "bash", args = { "-l" } },
    ["Bash (interactive)"] = { cmd = "bash", args = { "-li" } },
    ["Zsh"] = { cmd = "zsh", args = { "-l" } },
    ["Fish"] = { cmd = "fish", args = { "-l" } },
    ["Nu Shell"] = { cmd = "nu", args = {} },
  },
  
  -- 设置 shell
  set_shell = function(self, cmd, args)
    self.current_shell = cmd
    self.current_args = args or {}
    vim.o.shell = cmd
    
    local ok, snacks = pcall(require, "snacks")
    if ok and snacks and snacks.config and snacks.config.terminal then
      local new_shell_cmd = self:get_shell_cmd()
      snacks.config.terminal.shell = new_shell_cmd
    end
    
    local shell_str = type(args) == "table" and #args > 0 
      and (cmd .. " " .. table.concat(args, " ")) 
      or cmd
      
    vim.notify("Shell set to: " .. shell_str .. " (take effect in new terminals)", vim.log.levels.INFO)
  end,
  
  -- 获取完整的 shell 命令
  get_shell_cmd = function(self)
    if #self.current_args > 0 then
      return { self.current_shell, unpack(self.current_args) }
    else
      return self.current_shell
    end
  end,
  
  -- 交互式选择 shell
  select_shell = function(self)
    local choices = {}
    
    for name, config in pairs(self.presets) do
      if vim.fn.executable(config.cmd) == 1 then
        table.insert(choices, {
          text = name .. " (" .. config.cmd .. ")",
          value = { type = "preset", name = name, config = config }
        })
      end
    end
    
    -- 添加自定义选项
    table.insert(choices, {
      text = "Custom Shell...",
      value = { type = "custom" }
    })
    
    -- 添加重置选项
    table.insert(choices, {
      text = "Reset to Default (" .. vim.o.shell .. ")",
      value = { type = "reset" }
    })
    
    vim.ui.select(choices, {
      prompt = "Select Shell:",
      format_item = function(item) return item.text end,
    }, function(choice)
      if not choice then return end
      
      if choice.value.type == "preset" then
        self:set_shell(choice.value.config.cmd, choice.value.config.args)
      elseif choice.value.type == "custom" then
        self:custom_shell_input()
      elseif choice.value.type == "reset" then
        self:set_shell(vim.o.shell, {})
      end
    end)
  end,
  
  -- 自定义 shell 输入
  custom_shell_input = function(self)
    vim.ui.input({
      prompt = "Enter shell command: ",
      default = self.current_shell,
    }, function(input)
      if not input or input == "" then return end
      
      local parts = vim.split(input, " ", { plain = false, trimempty = true })
      local cmd = parts[1]
      local args = {}
      
      for i = 2, #parts do
        table.insert(args, parts[i])
      end
      
      if vim.fn.executable(cmd) == 1 then
        self:set_shell(cmd, args)
      else
        vim.notify("Command not found: " .. cmd, vim.log.levels.ERROR)
      end
    end)
  end,
  
  -- 显示当前 shell 信息
  show_info = function(self)
    local shell_info = {
      "Current Shell Configuration:",
      "  Command: " .. self.current_shell,
    }
    
    if #self.current_args > 0 then
      table.insert(shell_info, "  Arguments: " .. table.concat(self.current_args, " "))
    end
    
    table.insert(shell_info, "  Full command: " .. vim.inspect(self:get_shell_cmd()))
    
    vim.notify(table.concat(shell_info, "\n"), vim.log.levels.INFO)
  end,
}

return {
  "folke/snacks.nvim",
  opts = {
    terminal = {
      win = { 
        style = "terminal",
        border = "rounded",
        title = "Floating Terminal",
        title_pos = "center",
        backdrop = 60,
      },
      shell = vim.o.shell,
    }
  },

  keys = {
    {
      "<leader>fs",
      function()
        shell_manager:select_shell()
      end,
      desc = "Select Shell",
    },
    {
      "<leader>fS",
      function()
        shell_manager:show_info()
      end,
      desc = "Show Shell Info",
    },
    {
      "<leader>fw",
      function()
        Snacks.terminal(shell_manager:get_shell_cmd(), {})
      end,
      desc = "Terminal (Floating)",
    },
  },
}