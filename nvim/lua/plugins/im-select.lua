local function determine_os()
  if vim.fn.has("macunix") == 1 then
    return "macOS"
  elseif vim.fn.has("win32") == 1 or vim.fn.has("wsl") == 1 then
    return "Windows"
  else
    return "Linux"
  end
end

local function has_commands(cmds)
  for _, im in ipairs(cmds) do
    if vim.fn.executable(im) == 1 then
      return im
    end
  end
  return nil
end

local function supported_ime()
  local os = determine_os()
  -- macOS, Windows, WSL
  if os ~= "Linux" then
    return has_commands({ "im-select-mspy", "im-select-imm", "im-select" })
  else
    -- Support fcitx5, fcitx and ibus in Linux
    -- other frameworks are not support yet, PR welcome
    return has_commands({ "fcitx5-remote", "fcitx-remote", "ibus" })
  end
end

local ws = require("workspace")
local ime = ws.get("im_select", "default_command") or supported_ime()
if not ime then
  return {}
end

return {
  "keaising/im-select.nvim",
  config = function()
    -- https://github.com/daipeihust/im-select
    -- im-select是通过切换区域切换输入法的。不能切换输入法的模式，有一个改进版
    -- https://github.com/PEMessage/im-select-imm
    -- 但是搜狗输入法不知道为什么不能切换
    -- im-select-mspy是im-select中的另一个改进，使用模拟按键输入的方式切换。但是不能判断是否是中文输入法
    require("im_select").setup({
      -- IM will be set to `default_im_select` in `normal` mode
      -- For Windows/WSL, default: "1033", aka: English US Keyboard
      -- For macOS, default: "com.apple.keylayout.ABC", aka: US
      -- For Linux, default:
      --               "keyboard-us" for Fcitx5
      --               "1" for Fcitx
      --               "xkb:us::eng" for ibus
      -- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
      default_im_select = ws.get("im_select", "default_im_select") or "2052-0",

      -- Can be binary's name or binary's full path,
      -- e.g. 'im-select' or '/usr/local/bin/im-select'
      -- For Windows/WSL, default: "im-select.exe"
      -- For macOS, default: "im-select"
      -- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
      default_command = ime,
    })
  end,
}
