{
  config,
  lib,
  pkgs,
  ...
}:
let
  grammars = config.plugins.treesitter.package.builtGrammars;
in
{
  plugins = {
    neo-tree.enable = true;
    noice.enable = true;
    telescope.enable = true;
  };

  globals = {
    mapleader = " ";
  };

  opts = {
    termguicolors = true;
    wrap = false;
    number = true;
    relativenumber = true;
    signcolumn = "yes";

    shiftwidth = 4;
    tabstop = 4;
    softtabstop = 4;
    expandtab = false;
    smartindent = true;
    list = true;

    swapfile = false;
    backup = false;
    undofile = true;
    undodir = lib.nixvim.mkRaw ''vim.fn.stdpath("data") .. "/neovim/undodir"'';

    hlsearch = false;
    incsearch = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>fp";
      action = lib.nixvim.mkRaw ''require("telescope.builtin").find_files'';

      options = {
        silent = true;
        desc = "Find files";
      };
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = lib.nixvim.mkRaw ''require("telescope.builtin").live_grep'';

      options = {
        silent = true;
        desc = "Live grep";
      };
    }
    {
      mode = "n";
      key = "<leader>fe";
      action = lib.nixvim.mkRaw ''function() vim.cmd.Neotree("toggle") end'';

      options = {
        silent = true;
        desc = "Toggle file tree";
      };
    }
  ];

  files."ftplugin/nix.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  colorschemes.catppuccin = {
    enable = true;

    settings = {
      flavour = "mocha";
      transparent_background = true;
    };
  };

  plugins.mini-icons = {
    enable = true;
    mockDevIcons = true;
  };

  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    indent.enable = true;

    grammarPackages = [
      grammars.bash
      grammars.just
      grammars.lua
      grammars.markdown
      grammars.nix
      grammars.toml
      grammars.xml
      grammars.yaml
    ];
  };

  plugins.conform-nvim = {
    enable = true;

    settings = {
      format_on_save = {
        timeout_ms = 500;
        lsp_format = "fallback";
      };

      formatters_by_ft = {
        nix = [ "nixfmt" ];
      };

      formatters = {
        nixfmt.command = lib.getExe pkgs.nixfmt;
      };
    };
  };

  plugins.lsp = {
    enable = true;

    servers = {
      nixd.enable = true;
    };
  };

  extraPackages = [
    pkgs.ripgrep
  ];
}
