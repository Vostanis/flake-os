# flake-os

There are 3 major sectors to this NixOS network config;

### 1. core
This consists of the fundamental settings, like:
- audio
- desktop UI
- keyboard layout
- network access
- nixOS version
- programming languages

### 2. machines
These are the hardware configurations for each machine used so far (produced by `nixos-generate-config`).

### 3. users
`home-manager` configurations for each user. 

The name of each directory is a username, and within `./users/roles.nix` is the definition for permissions.

Most of the system packages are defined in `home.nix`, per user, as are terminal settings (in particular: `github` usernames & emails).
