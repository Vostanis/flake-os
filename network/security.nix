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
      maxtime = "168h"; # Do not ban for more than 1 week
      overalljails = true; # Calculate the bantime based on all the violations
    };
  };

  # Additional security tools
  environment.systemPackages = with pkgs; [
    chkrootkit # detect rootkits (i.e., system already compromised)
    clamav # antivirus
    vulnix # vulnerability scanner
  ];
}
