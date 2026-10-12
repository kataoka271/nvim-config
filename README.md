# nvim-config

Windows 用の Neovim 個人設定。プラグイン管理は [lazy.nvim](https://github.com/folke/lazy.nvim)。

## 必要なもの

| ツール | 用途 | インストール例 |
|---|---|---|
| Neovim 0.12 以上 | nvim-treesitter（main ブランチ）の要件 | `winget install Neovim.Neovim` |
| git | lazy.nvim とプラグインの取得 | `winget install Git.Git` |
| tree-sitter-cli | Tree-sitter パーサーのビルド | `npm install -g tree-sitter-cli` |
| C コンパイラ | 同上（MSVC など） | Visual Studio Build Tools |
| ripgrep | snacks.nvim の grep 検索 | `winget install BurntSushi.ripgrep.MSVC` |
| Nerd Font | アイコン表示（ターミナル側で設定） | |
| basedpyright, ruff | Python の LSP | `uv tool install basedpyright` / `uv tool install ruff` |
| rust-analyzer, clippy | Rust の LSP | `rustup component add rust-analyzer clippy` |

LSP サーバーは mason で自動インストールしないので、上記のように入れて PATH を通しておく。

## セットアップ

```powershell
git clone https://github.com/kataoka271/nvim-config "$env:LOCALAPPDATA\nvim"
nvim
```

初回起動時に lazy.nvim・プラグイン・Tree-sitter パーサーが自動でインストールされる。その後、プラグインのバージョンを `lazy-lock.json` に揃える。

```vim
:Lazy restore
```

問題があれば `:checkhealth` で確認する。

## 構成

```
init.lua              leader を設定し、config/ を読み込む
lua/config/
  options.lua         エディタのオプション
  keymaps.lua         基本のキーマップ
  lazy.lua            lazy.nvim の bootstrap と設定
lua/plugins/          プラグインごとの spec（自動で読み込まれる）
lazy-lock.json        プラグインのコミットを固定するロックファイル
```

プラグインを追加するときは `lua/plugins/` にファイルを足す。

## 主なプラグイン

| プラグイン | 内容 |
|---|---|
| github-nvim-theme | カラースキーム（`github_dark_default`） |
| snacks.nvim | ファイル検索・grep などのピッカー |
| blink.cmp | 補完 |
| nvim-lspconfig | LSP（basedpyright, ruff, rust_analyzer） |
| nvim-treesitter | シンタックスハイライト・インデント・折りたたみ |
| gitsigns.nvim | Git の差分表示と hunk 操作 |
| flash.nvim | ジャンプ移動 |
| nvim-surround | 囲み文字の追加・変更・削除 |
| which-key.nvim | キーマップのヒント表示 |
| mini.icons | アイコン |

## 主なキーマップ

leader は `<Space>`。一覧は `<leader>sk` で検索できる。

| キー | 動作 |
|---|---|
| `<leader><space>` | ファイルを探す |
| `<leader>/` | grep |
| `<leader>sb` / `<leader>sr` | バッファ一覧 / 最近開いたファイル |
| `<leader>sd` / `<leader>ss` | 診断一覧 / シンボル一覧 |
| `gd` / `gD` | 定義 / 宣言へジャンプ |
| `<leader>f` | フォーマット |
| `<leader>dq` / `<leader>dl` | 診断を quickfix / ロケーションリストに表示 |
| `]c` / `[c` | 次 / 前の Git hunk |
| `<leader>hs` / `<leader>hr` / `<leader>hp` | hunk のステージ / 取り消し / プレビュー |
| `s` / `S` | Flash ジャンプ / Treesitter 選択 |
| `<leader>w` / `<leader>q` | 保存 / 閉じる |
| `<C-h/j/k/l>` | ウィンドウ移動 |
