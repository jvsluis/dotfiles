local harpoon = require("harpoon")

harpoon:setup()

-- Custom harpoon keybindings
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = 'Add Harpoon Buffer' })
vim.keymap.set("n", "<leader>ft", function() harpoon.ui:toggle_telescope(harpoon:list()) end, { desc = 'Harpoon Telescope' })
vim.keymap.set("n", "<leader>jf", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon Quick Menu' })
vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = 'Harpoon Buffer 1' })
vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = 'Harpoon Buffer 2' })
vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = 'Harpoon Buffer 3' })
vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = 'Harpoon Buffer 4' })

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end)

-- Telescope config
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),

        attach_mappings = function(prompt_buffer_number, map)
            map("i", "<C-d>", function()
              local state = require("telescope.actions.state")
              local selected_entry = state.get_selected_entry()
              local current_picker = state.get_current_picker(prompt_buffer_number)

              harpoon:list():remove(selected_entry)
              current_picker:refresh(make_finder())
            end)

            return true
          end,

    }):find()
end
