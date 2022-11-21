local nnoremap = require("moh3a.keymap").nnoremap

nnoremap("<leader>tt", "<cmd>NvimTreeToggle<cr>")
nnoremap("<leader>tf", "<cmd>NvimTreeFocus<cr>")

-- Find files using Telescope command-line sugar.
nnoremap("<leader>ff", "<cmd>Telescope find_files<cr>")
nnoremap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nnoremap("<leader>fb", "<cmd>Telescope buffers<cr>")
nnoremap("<leader>fh", "<cmd>Telescope help_tags<cr>")
