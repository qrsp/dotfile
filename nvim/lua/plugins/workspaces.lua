return {
  {
    "natecraddock/workspaces.nvim",
    config = function ()
      require("workspaces").setup({
          hooks = {
              open_pre = {
                -- If recording, save current session state and stop recording
                "SessionsStop",

                -- delete all buffers (does not save changes)
                "silent %bdelete!",
              },
              open = function()
                require("sessions").load(nil, { silent = true })
              end,
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
    "natecraddock/sessions.nvim",
    config = function ()
      require("sessions").setup({
        session_filepath = vim.fn.stdpath("data") .. "/sessions",
        absolute = true,
      })
    end
  }
}
