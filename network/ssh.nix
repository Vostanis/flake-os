{ ... }:

{
  # SSH configured to require public key authentication (for better security).
  #
  # <https://nixos.wiki/wiki/SSH_public_key_authentication>
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = false;
    };
  };

  # User's public keys.
  users.users = {
    "kv".openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILSC5Ee73nn/1p5qa7nX79VulfXCIpwjHl1WOA+VZ2w8 kv@flakenet"
    ];
  };
}
