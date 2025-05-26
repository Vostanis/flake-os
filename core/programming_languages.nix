{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
  environment.systemPackages = with pkgs; [
    # Python (version 3.12)
    (python312.withPackages (ps: with ps; [
      # Package manager
      jupyter

      # LSP
      python-lsp-server

      # HTTP
      requests

      # Data handlers
      pandas
      numpy
      sqlalchemy
      psycopg2

      # Visuals
      altair
      matplotlib

      # ML/DL
      opencv4
      scipy
      scikit-learn
      torch
      torchvision
      xgboost
    ]))

    # Rust
    rust-bin.stable.latest.default
    openssl
    pkg-config
    gcc

    # Zig
    zig
  ];
}
