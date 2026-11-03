return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    init = function()
      -- Windows では npm の shim (tree-sitter.cmd) を libuv から起動できないため、実体の exe を PATH に通す
      if vim.fn.has("win32") == 1 then
        local cli_dir = vim.fs.joinpath(vim.env.APPDATA or "", "npm", "node_modules", "tree-sitter-cli")
        if vim.fn.executable(vim.fs.joinpath(cli_dir, "tree-sitter.exe")) == 1 then
          vim.env.PATH = cli_dir .. ";" .. vim.env.PATH
        end
      end
    end,
    config = function()
      -- Neovim 同梱（c, lua, markdown, vim, vimdoc, query）以外で使うパーサー
      require("nvim-treesitter").install({
        "python",
        "regex",
        "rust",
        "bash",
        "json",
        "toml",
        "yaml",
      })

      -- パーサーがある filetype ではハイライト・インデント・折りたたみを Tree-sitter で行う
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if not pcall(vim.treesitter.start, args.buf) then
            return
          end
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          vim.wo[0][0].foldmethod = "expr"
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
        end,
      })
    end,
  },
}
