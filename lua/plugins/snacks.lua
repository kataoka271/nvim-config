return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = { enabled = true },
    },
    keys = {
      { "<leader><space>", function() Snacks.picker.files() end, desc = "ファイルを探す" },
      { "<leader>/", function() Snacks.picker.grep() end, desc = "文字列を検索 (grep)" },
      { "<leader>sb", function() Snacks.picker.buffers() end, desc = "バッファ一覧" },
      { "<leader>sr", function() Snacks.picker.recent() end, desc = "最近開いたファイル" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "カーソル下の単語を検索", mode = { "n", "x" } },
      { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "診断一覧" },
      { "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "シンボル一覧" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "ヘルプ" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "キーマップ一覧" },
      { "<leader>s.", function() Snacks.picker.resume() end, desc = "前回の検索を再開" },
    },
  },
}
