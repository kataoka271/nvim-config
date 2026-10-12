local opt = vim.opt

-- 表示
opt.number = true          -- 行番号
-- opt.relativenumber = true  -- 相対行番号
opt.cursorline = true      -- カーソル行をハイライト
opt.signcolumn = "yes"     -- サイン列を常に表示
opt.termguicolors = true   -- 24bit カラー
opt.scrolloff = 8          -- カーソルの上下に残す行数
opt.wrap = false           -- 折り返さない

-- インデント
opt.expandtab = true       -- タブをスペースに展開
opt.tabstop = 2
opt.shiftwidth = 2
opt.smartindent = true

-- 検索
opt.ignorecase = true      -- 大文字小文字を区別しない
opt.smartcase = true       -- 大文字を含むときは区別する

-- 折りたたみ（foldmethod / foldexpr は Tree-sitter 有効時に plugins/treesitter.lua で設定）
opt.foldlevel = 99         -- 開いた時点では折りたたまない
opt.foldlevelstart = 99
opt.foldtext = ""          -- 折りたたみ行をシンタックスハイライト付きで表示
opt.fillchars:append({ fold = " " })

-- 編集
opt.clipboard = "unnamedplus" -- システムクリップボードと共有
opt.undofile = true           -- 終了後も undo 履歴を保持
opt.splitright = true         -- 縦分割は右に開く
opt.splitbelow = true         -- 横分割は下に開く
