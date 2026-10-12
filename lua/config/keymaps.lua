local map = vim.keymap.set

-- 保存・終了
map("n", "<leader>w", "<cmd>write<CR>", { desc = "保存" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "閉じる" })

-- 検索ハイライトを消す
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "検索ハイライトを消す" })

-- ウィンドウ移動
map("n", "<C-h>", "<C-w>h", { desc = "左のウィンドウへ" })
map("n", "<C-j>", "<C-w>j", { desc = "下のウィンドウへ" })
map("n", "<C-k>", "<C-w>k", { desc = "上のウィンドウへ" })
map("n", "<C-l>", "<C-w>l", { desc = "右のウィンドウへ" })

-- ビジュアルモードでインデント後も選択を維持
map("v", "<", "<gv", { desc = "インデントを減らす" })
map("v", ">", ">gv", { desc = "インデントを増やす" })
