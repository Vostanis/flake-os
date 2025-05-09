{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
  environment.systemPackages = with pkgs; [
    # Python (version 3.12)
    (python312.withPackages (ps: with ps; [
      altair
      jupyter
      matplotlib
      numpy
      opencv4
      polars
      psycopg2 # dependency of sqlalchemy
      requests
      scipy
      scikit-learn
      sqlalchemy
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
