-- 启动时间调试工具
-- 使用方法：
-- 1. 在 init.lua 中添加: require("config.debug-startup").start_profiling()
-- 2. 重启 Neovim 
-- 3. 打开 Python file

local M = {}

local global_start_time = vim.fn.reltime()
local last_event_time = global_start_time

local function log_with_time(...)
  local args = {...}
  local current_time = vim.fn.reltime()
  
  local total_time = vim.fn.reltimestr(vim.fn.reltime(global_start_time))
  
  local interval_time = vim.fn.reltimestr(vim.fn.reltime(last_event_time))
  
  last_event_time = current_time
  
  -- 格式化消息：[总时间/间隔时间] 消息内容
  local time_info = string.format("[T:%ss I:%ss]", total_time, interval_time)
  vim.notify(time_info .. " " .. table.concat(args, " "), vim.log.levels.INFO)
end

local function reset_timer()
  global_start_time = vim.fn.reltime()
  last_event_time = global_start_time
  log_with_time("⏰ Timer reset")
end

local function profile_startup()
  log_with_time("🚀 Debug startup profiling enabled")
  
  -- 记录插件加载时间
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyLoad",
    callback = function(event)
      log_with_time("📦 Plugin loaded:", event.data)
    end,
  })

  -- 记录 LSP 启动时间
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
        local buf_ft = vim.bo[args.buf].filetype
        log_with_time("🔗 LSP attached:", client.name, "for", buf_ft)
      end
    end,
  })

  -- 记录 LSP 准备就绪
  vim.api.nvim_create_autocmd("LspNotify", {
    callback = function(args)
      if args.data and args.data.method == "textDocument/publishDiagnostics" then
        log_with_time("🩺 LSP diagnostics ready")
      end
    end,
  })

  -- 记录 Treesitter 高亮启用
  vim.api.nvim_create_autocmd("User", {
    pattern = "TSHighlight*",
    callback = function(event)
      log_with_time("🎨 Treesitter highlighting:", event.match)
    end,
  })

  -- 记录文件类型检测时间（所有文件类型）
  vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
      local filetype = args.match
      local filetype_icons = {
        python = "🐍",
        lua = "🌙",
        javascript = "💛",
        typescript = "💙",
        java = "☕",
        cpp = "⚡",
        c = "🔧",
        rust = "🦀",
        go = "🐹",
        html = "🌐",
        css = "🎨",
        json = "📋",
        yaml = "📄",
        toml = "⚙️",
        markdown = "📝",
        vim = "💚",
        bash = "🐚",
        sh = "🐚",
        sql = "🗃️",
        dockerfile = "🐳",
        tex = "📖",
        xml = "📰",
        php = "🐘",
        ruby = "💎",
        perl = "🐪",
        scala = "🎯",
        kotlin = "🟣",
        swift = "🍎",
        dart = "🎯",
        elixir = "�",
        haskell = "λ",
        clojure = "🔮",
      }
      
      local icon = filetype_icons[filetype] or "📄"
      log_with_time(icon .. " FileType detected:", filetype)
    end,
  })

  -- 记录 Treesitter 加载
  vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
      log_with_time("🌳 Treesitter updated")
    end,
  })

  -- 记录缓冲区切换（前几次）
  local buffer_count = 0
  vim.api.nvim_create_autocmd("BufEnter", {
    callback = function(args)
      buffer_count = buffer_count + 1
      local filename = vim.fn.fnamemodify(args.file, ":t") or "<no-file>"
      local filetype = vim.bo.filetype or "unknown"
      
      if buffer_count <= 5 then -- 只记录前5次，避免信息过多
        log_with_time("Buffer #" .. buffer_count .. " entered:", filename, "(" .. filetype .. ")")
      end
    end,
  })

  -- 创建调试命令
  vim.api.nvim_create_user_command("DebugMessages", function()
    vim.cmd("messages")
  end, { desc = "Show debug messages" })

  vim.api.nvim_create_user_command("DebugReset", function()
    reset_timer()
  end, { desc = "Reset debug timer" })

  log_with_time("✅ Debug autocmds registered")
end

local function start_profiling()
  profile_startup()
  log_with_time("🎯 Ready to profile! Open a file and run :DebugMessages")
end

M.start_profiling = start_profiling
M.reset_timer = reset_timer
M.log_with_time = log_with_time

return M
