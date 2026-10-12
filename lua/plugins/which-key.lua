return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,
      spec = {
        { "<leader>s", group = "検索" },
        { "<leader>h", group = "git hunk" },
        { "gr", group = "LSP" },
      },
    },
  },
}
