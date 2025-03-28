return {
  {
    "qrsp/imSelect.vim",
    cond = function() return jit.os == "Windows" end,
    event = "VeryLazy",
    init = function()
      vim.g.imselect_insert_engines = { 134481924 }
      vim.g.imselect_normal_engines = { 67699721 }
      vim.api.nvim_create_user_command( "IM", ":call imselect#toggle('n')", {})
    end,
  },
  { "qrsp/ibus.vim",
    cond = function() return jit.os == "Linux" end,
    event = "VeryLazy",
    init = function()
      vim.g.ibus_insert_engines = {'rime', 'mozc-jp'}
      vim.g.ibus_normal_engines = { 'xkb:us::eng' }
      vim.api.nvim_create_user_command( "IM", ":call ibus#toggle('n')", {})
    end,
  },
}
