return {
  {
    "nvim-mini/mini.icons",
    lazy = true, -- アイコンを使うプラグインから require された時に読み込まれる
    opts = {},
    init = function()
      -- nvim-web-devicons を要求するプラグイン向けの互換レイヤー
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
