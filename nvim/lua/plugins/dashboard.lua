return {
  "nvimdev/dashboard-nvim",
  opts = function(_, opts)
    local logo = [[
    ('-.  _   .-')                      (`-.                .-') _  
  _(  OO)( '.( OO )_                  _(OO  )_             ( OO ) ) 
  (,------.,--.   ,--.).-'),-----. ,--(_/   ,. \ ,-.-') ,--./ ,--,'  
  |  .---'|   `.'   |( OO'  .-.  '\   \   /(__/ |  |OO)|   \ |  |\  
  |  |    |         |/   |  | |  | \   \ /   /  |  |  \|    \|  | ) 
  (|  '--. |  |'.'|  |\_) |  |\|  |  \   '   /,  |  |(_/|  .     |/  
  |  .--' |  |   |  |  \ |  | |  |   \     /__),|  |_.'|  |\    |   
  |  `---.|  |   |  |   `'  '-'  '    \   /   (_|  |   |  | \   |   
  `------'`--'   `--'     `-----'      `-'      `--'   `--'  `--'   
    ]]
    logo = string.rep("\n", 4) .. logo .. "\n\n"

    opts.config.header = vim.split(logo, "\n")
    vim.cmd [[  
        highlight DashboardHeader guifg=#00fff9
    ]]  
  end,
}

