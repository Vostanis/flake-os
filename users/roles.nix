{ config, ... }:

{
  users.users.kv = {
      isNormalUser = true;
      description = "kv";
      extraGroups = [ "wheel" "networkmanager" "audio" ];
      initialPassword = "changeme";
  };
}
