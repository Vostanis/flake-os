{ pkgs, ... }:

{
  home = {
    stateVersion = "24.11"; # 26/03/2025
    username = "kv";

    # User-specific packages.
    packages = with pkgs; [
      # Apps
      brave
      libreoffice
      teamviewer
      tradingview
      vscodium

      # CLI
      curl
      vim
      ripgrep
      jq # JSON
      eza # ls with colors
      bat
      gh # github
      ipfetch
      neofetch

      postgresql
      pgcli
      wasm-pack
      cargo-expand
      cargo-flamegraph
      docker-compose
      kubernetes

      # LSPs
      rust-analyzer
      nil # nix
      nixpkgs-fmt
      sqls
      pgformatter
      # pylsp
    ];
  };

  programs = {
    # Core
    home-manager.enable = true;
    bash = {
      enable = true;
      shellAliases = {
        ls = "eza -la --color=always --icons";
      };
    };

    # GitHub
    git = {
      enable = true;
      userName = "Vostanis";
      userEmail = "kimonvostanis@gmail.com";
    };

    # Terminal
    ghostty = {
      enable = true;
      enableBashIntegration = true;
    };
    
    # Terminal CLI
    atuin.enable = true;

    # Helix IDE
    helix = {
      enable = true;
      settings.theme = "gruvbox";
      languages = {
        language = [
        	{
        	  name = "rust";
        	  auto-format = true;
        	  formatter = { command = "rustfmt"; };
        	}
          {
            name = "nix";
            auto-format = true;
            formatter = { command = "nixpkgs-fmt"; };
          }
          {
            name = "sql";
            auto-format = true;
            language-servers = [ "sqls" ];
            formatter = { command = "pg_format"; args = []; };
            file-types = [ "sql" "pgsql" "psql" ];
          }
        ];
      };
    };
  };
}
