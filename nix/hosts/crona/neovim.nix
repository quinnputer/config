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

  files."ftplugin/json.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  files."ftplugin/css.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  files."ftplugin/html.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  files."ftplugin/astro.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  files."ftplugin/typescript.lua".localOpts = {
    shiftwidth = 2;
    tabstop = 2;
    softtabstop = 2;
    expandtab = true;
  };

  files."ftplugin/javascript.lua".localOpts = {
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
      grammars.astro
      grammars.bash
      grammars.css
      grammars.javascript
      grammars.json
      grammars.just
      grammars.lua
      grammars.markdown
      grammars.nix
      grammars.svelte
      grammars.toml
      grammars.typescript
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
        astro = [ "prettier" ];
        css = [ "prettier" ];
        html = [ "prettier" ];
        javascript = [ "prettier" ];
        json = [ "prettier" ];
        nix = [ "nixfmt" ];
        svelte = [ "prettier" ];
        typescript = [ "prettier" ];
      };

      formatters = {
        nixfmt.command = lib.getExe pkgs.nixfmt;
        prettier.command = lib.getExe pkgs.prettier;
      };
    };
  };

  plugins.lsp = {
    enable = true;

    servers = {
      astro.enable = true;
      cssls.enable = true;
      html.enable = true;
      jsonls.enable = true;
      nixd.enable = true;
      svelte.enable = true;
      tailwindcss.enable = true;
      ts_ls.enable = true;
    };
  };

  plugins.blink-cmp = {
    enable = true;

    settings.keymap = {
      preset = "enter";
      "<Tab>" = [ "select_next" ];
      "<S-Tab>" = [ "select_prev" ];
    };
  };

  extraPackages = [
    pkgs.ripgrep
  ];
}
