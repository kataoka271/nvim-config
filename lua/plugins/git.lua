return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(bufnr)
        local gs = require("gitsigns")
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- diff モードでは標準の ]c / [c を使う
        map("n", "]c", function()
          if vim.wo.diff then vim.cmd.normal({ "]c", bang = true }) else gs.nav_hunk("next") end
        end, "次の変更へ")
        map("n", "[c", function()
          if vim.wo.diff then vim.cmd.normal({ "[c", bang = true }) else gs.nav_hunk("prev") end
        end, "前の変更へ")

        map("n", "<leader>hs", gs.stage_hunk, "hunk をステージ")
        map("n", "<leader>hr", gs.reset_hunk, "hunk を元に戻す")
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "選択範囲をステージ")
        map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "選択範囲を元に戻す")
        map("n", "<leader>hp", gs.preview_hunk, "hunk をプレビュー")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "この行の blame")
        map("n", "<leader>hd", gs.diffthis, "差分を表示")
      end,
    },
  },
}
