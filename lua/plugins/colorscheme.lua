return {
  {
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    lazy = false,
    priority = 1000,
    config = function()
      -- 既定の出力先（%TEMP%\nvim）は Windows の一時ファイル掃除でコンパイル結果だけ
      -- 消され、ハッシュが残って再コンパイルされず読み込みに失敗するため data 側に置く
      require("github-theme").setup({
        options = { compile_path = vim.fn.stdpath("data") .. "/github-theme" },
      })
      vim.cmd.colorscheme("github_dark_default")
    end,
  },
}
