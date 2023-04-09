-- nvim-tree configuration
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
    update_focused_file = {
        enable = true,
        update_cwd = true
    },
    view = {
        width = 30,
        side = "left",
        mappings = {
            list = {{
                key = {"l", "<CR>", "o"},
                cb = tree_cb "edit"
            }, {
                key = "h",
                cb = tree_cb "close_node"
            }, {
                key = "v",
                cb = tree_cb "vsplit"
            }}
        }
    }
}


-- open nvim-tree when vim starts
require("nvim-tree.api").tree.toggle({
	path = nil,
	current_window = false,
	find_file = false,
	update_root = false,
	focus = true,
})
