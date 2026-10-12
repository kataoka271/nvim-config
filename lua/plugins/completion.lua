return {
  {
    "saghen/blink.cmp",
    version = "1.*", -- リリース版ならビルド済みバイナリを取得できる
    -- 補完が必要になるまで読み込まない。読み込み前に起動した LSP には Neovim 標準の
    -- capabilities が渡るが、0.12 では snippetSupport 等 blink が必要とするものを含んでいる
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      -- <C-y> 確定 / <C-n> <C-p> 選択 / <C-space> 補完を開く / <C-e> 閉じる
      keymap = { preset = "default" },
      completion = {
        documentation = { auto_show = true }, -- 選択中の候補のドキュメントを表示
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      signature = { enabled = true }, -- 関数の引数入力中にシグネチャを表示
    },
  },
}
