return {
  {
    'goolord/alpha-nvim',
    config = function ()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.dashboard'
      -- Set header
      dashboard.section.header.val = {}
      dashboard.section.buttons.val = {
        dashboard.button('n', ' > New File', '<cmd>ene<CR>'),
        dashboard.button('f', '󰱼 > Find Files', '<cmd>Telescope find_files<CR>'),
        dashboard.button("g", "󰷾 > Find text", ":Telescope live_grep <CR>"),
        dashboard.button('r', ' > Find Recent Files', '<cmd>Telescope oldfiles<CR>'),
        dashboard.button('w', ' > Find Workspaces', '<cmd>Telescope workspaces<CR>'),
        dashboard.button('s', ' > Load Session', '<cmd>SessionsLoad<CR>'),
        dashboard.button('q', ' > Quit NVIM', '<cmd>qa<CR>'),
      }
      alpha.setup(dashboard.opts)
    end
  }
}
