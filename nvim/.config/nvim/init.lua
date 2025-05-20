local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set the <leader> to space
vim.g.mapleader = " "

-- Configure spacing
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.cmd [[let g:python_recommended_style = 0]]

-- Setup plugins
require("lazy").setup("plugins")

-- Set colour
vim.opt.termguicolors = true
vim.cmd [[colorscheme gedit]]
-- vim.cmd [[colorscheme delek]]
-- vim.cmd [[colorscheme darkblue]]
-- vim.cmd [[colorscheme solarized8]]

-- Set some editor specifics
vim.wo.number = true
vim.opt.colorcolumn = "80"
-- If blue theme:
-- vim.cmd [[highlight ColorColumn ctermbg=blue guibg=blue]]
-- If solarized8:
-- vim.cmd [[highlight ColorColumn ctermbg=16]]
vim.o.signcolumn = "yes"
vim.o.scrolloff = 8

-- Custom bindings
vim.keymap.set('n', '<Leader>t', '<cmd>NvimTreeToggle<CR>')
vim.keymap.set('n', '<Leader>e', '<cmd>NvimTreeFocus<CR>')
vim.keymap.set('n', '<Leader>fe', '<cmd>Telescope<CR>')
vim.keymap.set('n', '<Leader>ff', '<cmd>Telescope find_files<CR>')
vim.keymap.set('n', '<Leader>gg', '<cmd>LazyGit<CR>')
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-- vim.keymap.set('n', '<leader>cm', function() os.execute(vim.loop.cwd() + '') end)

-- Some custom cmake related code
local function project_cmake_build()
  local build_cmd = 'cmake --build ' .. vim.loop.cwd() .. '/build';
  local handle = io.popen(build_cmd)
  local result = handle:read("*a")
  handle:close()

  -- Display the output at the bottom of the Neovim window
  vim.notify(result, vim.log.levels.INFO)
end
vim.keymap.set('n', '<leader>cm', project_cmake_build, { desc = 'Build current project' })

-- Auto format
vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = buffer,
  callback = function()
    vim.lsp.buf.format { async = false }
  end
})