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
      docker
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
    kitty = {
      enable = true;
      shellIntegration.enableFishIntegration = true;
      shellIntegration.enableBashIntegration = true;
      font.name = "JetBrains Mono";
      font.size = 12;
      extraConfig = "
      	background              #0b0b0e
      	foreground              #bcb28d
      	cursor                  #bcb28d
      	selection_background    #2c5a65
      	selection_foreground    #eee8d5
      	url_color               #58b2dc
      	color0                  #0b0b0e  
      	color8                  #43474c  
      	color1                  #E6844F  
      	color9                  #E6844F  
      	color2                  #66A866  
      	color10                 #66A866  
      	color3                  #DDA52D  
      	color11                 #DDA52D  
      	color4                  #58b2dc  
      	color12                 #58b2dc  
      	color5                  #E03C8A  
      	color13                 #E03C8A  
      	color6                  #69b0ac  
      	color14                 #69b0ac  
      	color7                  #bcb28d  
      	color15                 #fdf6e3  
      	active_tab_foreground   #fdf6e3
      	active_tab_background   #2c5a65
      	inactive_tab_foreground #707C74
      	inactive_tab_background #282b31
      ";
      keybindings = {
        "ctrl+x" = "fg";
      };
    };

    # Terminal CLI
    atuin.enable = true;

    # Helix IDE
    helix = {
      enable = true;
      settings.theme = "varua";
      languages = {
        language = [
          {
            name = "rust";
            auto-format = true;
            formatter = { command = "cargo fmt"; };
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
            formatter = { command = "pg_format"; args = [ ]; };
            file-types = [ "sql" "pgsql" "psql" ];
          }
        ];
      };
    };
  };
}
