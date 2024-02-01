 return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("config.nvim-lspconfig")
    end,
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
  }
}
