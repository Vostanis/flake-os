{ pkgs, ... }:

# Security tools & protocols.
{
  # Fail2ban: blocks suspicious behaviour, e.g. scanning directories that do not exist.
  #
  # <https://nixos.wiki/wiki/Fail2ban>
  services.fail2ban = {
    enable = true;
    maxretry = 5;
    bantime = "24h";
    bantime-increment = {
      enable = true;
      formula = "ban.Time * math.exp(float(ban.Count+1)*banFactor)/math.exp(1*banFactor)";
      multipliers = "1 2 4 8 16 32 64";
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true; # Calculate the bantime based on all the violations
    };
    jails = {
      apache-nohome-iptables.settings = {
        # Block an IP address if it accesses a non-existent
        # home directory more than 5 times in 10 minutes,
        # since that indicates that it's scanning.
        filter = "apache-nohome";
        action = ''iptables-multiport[name=HTTP, port="http,https"]'';
        logpath = "/var/log/httpd/error_log*";
        backend = "auto";
        findtime = 600;
        bantime = 600;
        maxretry = 5;
      };
    };
  };

  # Additional security tools
  environment.systemPackages = with pkgs; [
    chkrootkit # detect rootkits (i.e., system already compromised)
    clamav # antivirus
    vulnix # vulnerability scanner
  ];
}
