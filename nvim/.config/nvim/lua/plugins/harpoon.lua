return {
    "ThePrimeagen/harpoon",
    config = function()
      require("config.harpoon")
    end,
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
}