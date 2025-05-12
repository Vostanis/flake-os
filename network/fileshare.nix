{ ... }:

{
  # Build a remotely shared file system, using `syncthing`.
  #
  # <https://wiki.nixos.org/wiki/Syncthing>
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    settings = {
      # Define devices of the system, where `id` has been built with.
      # 
      # <https://wiki.nixos.org/wiki/Syncthing#Declarative_node_IDs>
      devices = {
        "server-main" = { id = "ID_NEEDED"; };
        "laptop-main" = { id = "ID_NEEDED"; };
      };

      # Build a remote directory "/remote/shared".
      #
      # <https://wiki.nixos.org/wiki/Syncthing#Sync_folders_and_trusted_remote_hosts>
      folders = {
        "shared" = {
          path = "/remote/shared";
          devices = [ "server-main" "laptop-main" ];
        };
      };
    };
  };
}
