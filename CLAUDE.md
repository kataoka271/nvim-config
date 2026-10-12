# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 概要

Windows 上の Neovim（0.12 系）の個人設定。プラグイン管理は lazy.nvim。コメント・キーマップの `desc` は日本語で書く。

## 構成

- `init.lua` で `mapleader` を設定してから `config.options` → `config.keymaps` → `config.lazy` の順に読み込む。leader は lazy.nvim より前に設定する必要がある。
- `lua/config/lazy.lua` は lazy.nvim を `stdpath("data")/lazy`（`%LOCALAPPDATA%\nvim-data`）へ自動 clone し、`{ import = "plugins" }` で `lua/plugins/*.lua` をすべて読み込む。プラグインを追加するときは `lua/plugins/` に1ファイル1機能でファイルを足し、`return { { "owner/repo", ... } }` の形で spec を返す。
- `lazy-lock.json` はプラグインのコミットを固定するロックファイル。プラグインを追加・更新したらこれもコミットする。

### ファイルをまたぐ設計上の約束

- **LSP は mason を使わない**。`lsp.lua` は Neovim 0.11+ の `vim.lsp.config` / `vim.lsp.enable` で basedpyright・ruff・rust_analyzer を有効化するだけで、サーバー本体は PATH 上に別途インストールされている前提。Python は役割分担している（型チェック・定義ジャンプ → basedpyright、lint・フォーマット・import 整理 → ruff。ruff の hover は無効化）。
- **折りたたみ**: `options.lua` は `foldlevel` などだけを設定し、`foldmethod=expr` / `foldexpr` は `treesitter.lua` の FileType autocmd がパーサーのあるバッファにだけ設定する。
- **nvim-treesitter は `main` ブランチ**（旧 master 系の `configs.setup` API ではない）。パーサーは `require("nvim-treesitter").install({...})` で入れ、ハイライトは `vim.treesitter.start` で有効にする。パーサーのビルドには tree-sitter-cli（npm）が必要。Windows では npm の `.cmd` shim を libuv から起動できないため、`init` で実体の exe のディレクトリを PATH の先頭に足している。
- **アイコン**は mini.icons に統一し、`package.preload` で nvim-web-devicons をモックしている。nvim-web-devicons を依存に追加しないこと。
- **キーの衝突**: ビジュアルモードの `S` は nvim-surround が使うため、flash.nvim の `S` は n/o モードのみに割り当てている。新しいキーマップを追加するときは which-key のグループ（`<leader>s` 検索、`<leader>h` git hunk、`gr` LSP）に合わせる。
- 補完（blink.cmp）は `InsertEnter` / `CmdlineEnter` で遅延読み込み。LSP の capabilities は blink 経由で渡していない（Neovim 0.12 標準のもので足りる）。

## 動作確認

テストやビルドはない。変更後は次のように確認する。

```sh
# 設定がエラーなく読み込めるか（エラーがあれば出力される）
nvim --headless "+qa"

# プラグインのインストール・ロックファイルどおりへの復元
nvim --headless "+Lazy! restore" +qa

# 健康診断（Neovim 内で）
:checkhealth
:Lazy
```
