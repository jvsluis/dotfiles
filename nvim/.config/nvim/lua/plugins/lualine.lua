return {
    'nvim-lualine/lualine.nvim',
    config = function()
      require("config.lualine")
    end,
    dependencies = { 'nvim-tree/nvim-web-devicons' }
}