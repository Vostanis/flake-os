{ ... }:

{
  # SSH configured to require public key authentication (for better security).
  #
  # <https://nixos.wiki/wiki/SSH_public_key_authentication>
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  # User's public keys.
  users.users = {
    "kv".openssh.authorizedKeys.keys = [ ];
  };
}
