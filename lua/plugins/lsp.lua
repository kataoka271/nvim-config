return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      -- 型チェック・定義ジャンプは basedpyright、lint・フォーマット・import 整理は ruff が担当
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            disableOrganizeImports = true, -- ruff と重複するため
            analysis = {
              typeCheckingMode = "standard", -- 既定の "recommended" は厳しすぎるため
            },
          },
        },
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            check = { command = "clippy" }, -- 保存時の診断を cargo check から clippy に
          },
        },
      })

      vim.lsp.enable({ "basedpyright", "ruff", "rust_analyzer" })

      -- エラー・警告を行末にも表示する
      vim.diagnostic.config({ virtual_text = true })

      vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "全バッファの診断を quickfix に一覧表示" })
      vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "バッファの診断をロケーションリストに一覧表示" })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false -- K は basedpyright に任せる
          end

          local function map(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = args.buf, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "定義へジャンプ")
          map("gD", vim.lsp.buf.declaration, "宣言へジャンプ")
          map("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "フォーマット")
        end,
      })
    end,
  },
}
