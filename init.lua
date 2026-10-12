-- lazy.nvim より前に leader を設定する
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")
require("config.lazy")
