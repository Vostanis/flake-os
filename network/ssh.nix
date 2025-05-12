{ ... }:

{
  # SSH configured to require public key authentication (for better security).
  #
  # <https://nixos.wiki/wiki/SSH_public_key_authentication>
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };

  users.users = {
    "kv".openssh.authorizedKeys.keys = [ ];
  };
}
