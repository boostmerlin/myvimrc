return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    dashboard = {
      -- your dashboard configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      width = 70,
      preset = {
        header = [[
    ('-.  _   .-')                      (`-.                .-') _  
  _(  OO)( '.( OO )_                  _(OO  )_             ( OO ) ) 
  (,------.,--.   ,--.).-'),-----. ,--(_/   ,. \ ,-.-') ,--./ ,--,'  
  |  .---'|   `.'   |( OO'  .-.  '\   \   /(__/ |  |OO)|   \ |  |\  
  |  |    |         |/   |  | |  | \   \ /   /  |  |  \|    \|  | ) 
  (|  '--. |  |'.'|  |\_) |  |\|  |  \   '   /,  |  |(_/|  .     |/  
  |  .--' |  |   |  |  \ |  | |  |   \     /__),|  |_.'|  |\    |   
  |  `---.|  |   |  |   `'  '-'  '    \   /   (_|  |   |  | \   |   
  `------'`--'   `--'     `-----'      `-'      `--'   `--'  `--'   
    ]],
      },
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
  },
}

