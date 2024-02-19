return {
  {
    "natecraddock/workspaces.nvim",
    config = function ()
      require("workspaces").setup({
          hooks = {
              open_pre = { "SessionManager save_current_session", },
              open = { "SessionManager load_current_dir_session", },
          }
      })
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      config = function ()
        require("telescope").load_extension("workspaces")
      end
    }
  },
  {
    "Shatur/neovim-session-manager",
    config = function ()
      local config = require('session_manager.config')
      require('session_manager').setup({
        autoload_mode = config.AutoloadMode.Disabled,
        autosave_only_in_session = true,
        })
    end
  }
}
