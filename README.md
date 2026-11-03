# nvim-config

Windows / Linux 用の Neovim 個人設定。プラグイン管理は [lazy.nvim](https://github.com/folke/lazy.nvim)。

## 必要なもの

| ツール | 用途 | Windows | Linux（Debian / Ubuntu の例） |
|---|---|---|---|
| Neovim 0.12 以上 | nvim-treesitter（main ブランチ）の要件 | `winget install Neovim.Neovim` | 公式の tarball（[下記](#linux-に-neovim-をインストールする)） |
| git | lazy.nvim とプラグインの取得 | `winget install Git.Git` | `sudo apt install git` |
| tree-sitter-cli | Tree-sitter パーサーのビルド | `npm install -g tree-sitter-cli` | `npm install -g tree-sitter-cli` または `cargo install tree-sitter-cli` |
| C コンパイラ | 同上 | Visual Studio Build Tools（MSVC） | `sudo apt install build-essential` |
| curl, tar | パーサーのソース・blink.cmp のバイナリの取得 | Windows 10 以降に同梱 | `sudo apt install curl tar` |
| ripgrep | snacks.nvim の grep 検索 | `winget install BurntSushi.ripgrep.MSVC` | `sudo apt install ripgrep` |
| クリップボード連携 | `clipboard=unnamedplus` | 不要 | Wayland: `wl-clipboard` / X11: `xclip`（SSH 越しは OSC 52 対応ターミナルなら不要） |
| Nerd Font | アイコン表示（ターミナル側で設定） | | |
| basedpyright, ruff | Python の LSP | `uv tool install basedpyright` / `uv tool install ruff` | 同左（`~/.local/bin` を PATH に通す） |
| rust-analyzer, clippy | Rust の LSP | `rustup component add rust-analyzer clippy` | 同左（`~/.cargo/bin` を PATH に通す） |

LSP サーバーは mason で自動インストールしないので、上記のように入れて PATH を通しておく。

### Linux に Neovim をインストールする

ディストリのパッケージ（`apt install neovim` など）は 0.12 より古いことが多い（Ubuntu 24.04 は 0.9.5）。WSL や EC2 でも、公式のビルド済み tarball を `/opt` に展開して使う。

```sh
# apt で入れた古い nvim があれば削除する
sudo apt remove neovim

# x86_64 なら nvim-linux-x86_64、ARM（aarch64、EC2 の Graviton など）なら nvim-linux-arm64
arch=$(uname -m | sed 's/aarch64/arm64/')
curl -LO "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch}.tar.gz"
sudo rm -rf "/opt/nvim-linux-${arch}"
sudo tar -C /opt -xzf "nvim-linux-${arch}.tar.gz"
rm "nvim-linux-${arch}.tar.gz"

# PATH に追加する（zsh なら ~/.zshrc）
echo "export PATH=\"/opt/nvim-linux-${arch}/bin:\$PATH\"" >> ~/.bashrc
source ~/.bashrc
hash -r

nvim --version
```

更新するときは、PATH の追加以外の手順をもう一度実行する。公式の tarball は新しめの glibc を前提にしているため、Amazon Linux 2 のような古いディストリでは動かないことがある。

## セットアップ

Windows（PowerShell）:

```powershell
git clone https://github.com/kataoka271/nvim-config "$env:LOCALAPPDATA\nvim"
nvim
```

Linux:

```sh
git clone https://github.com/kataoka271/nvim-config "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
nvim
```

プラグインなどのデータは Windows では `%LOCALAPPDATA%\nvim-data`、Linux では `~/.local/share/nvim` に置かれる。

初回起動時に lazy.nvim・プラグイン・Tree-sitter パーサーが自動でインストールされる。その後、プラグインのバージョンを `lazy-lock.json` に揃える。

```vim
:Lazy restore
```

問題があれば `:checkhealth` で確認する。

複数のマシンで使う場合、`:Lazy update` はどれか1台でだけ行って `lazy-lock.json` をコミットし、ほかのマシンでは `git pull` してから `:Lazy restore` する（各マシンで update するとロックファイルが衝突する）。

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
