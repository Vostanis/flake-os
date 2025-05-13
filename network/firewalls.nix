{ ... }:

{
  # <https://search.nixos.org/options?channel=24.11&from=0&size=50&sort=relevance&type=packages&query=networking.firewall>
  networking.firewall = {
    enable = true;

    allowedTCPPorts = [
      22 # SSH
      8384 # Syncthing GUI
      10101 # mx-dwh
      22000 # Syncthing transfer
    ];

    allowedUDPPorts = [
      21027 # Syncthing discovery
    ];
  };
}
