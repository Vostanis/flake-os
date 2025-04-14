{ inputs, pkgs, ... }:

{
  nixpkgs.overlays = [ inputs.rust-overlay.overlays.default ];
  environment.systemPackages = with pkgs; [
    # Rust
    rust-bin.stable.latest.default
    openssl
    pkg-config
    gcc

    # Zig
    zig
  ];
}
