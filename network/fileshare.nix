{ ... }:

{
  # Build a remotely shared file system, using `syncthing`.
  #
  # Official nix doc
  # <https://wiki.nixos.org/wiki/Syncthing>
  #
  # Config doc
  # <https://search.nixos.org/options?channel=24.11&from=0&size=50&sort=relevance&type=packages&query=syncthing>
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    configDir = "/.config/syncthing"; # storage for 
    guiAddress = "0.0.0.0:8384";
    settings = {
      # Define devices of the system, where `id` has been built with.
      # 
      # <https://wiki.nixos.org/wiki/Syncthing#Declarative_node_IDs>
      devices = {
        mainserver = {
          name = "mainserver";
          id = "NEED_ID";
        };

        mainclient = {
          name = "mainclient";
          id = "NEED_ID";
        };
      };

      # Build a remote directory "/remote/shared".
      #
      # <https://wiki.nixos.org/wiki/Syncthing#Sync_folders_and_trusted_remote_hosts>
      folders = {
        "shared" = {
          path = "/remote/shared";
          devices = [
            "mainserver"
            "mainclient"
          ];

          # When files are changed, syncthing will keep new versions of the files for the first hour;
          # hourly versions for the first day;
          # daily versions for the first month;
          # and weekly versions for 180 days.
          versioning = {
            type = "staggered";
            params = {
              cleanInterval = "3600"; # 1 hr
              maxAge = "15552000"; # 180 days
            };
          };
        };
      };
    };
  };
}
