{ lib, pkgs, ... }:

{
  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16;
    port = 5432;

    ensureDatabases = [
      "mx-dwh"
    ];

    ensureUsers = [
      {
        name = "kv";
        ensureClauses = {
          login = true;
          superuser = true;
        };
      }
      {
        name = "fr";
      }
    ];

    authentication = ''
      # TYPE  DATABASE        USER            ADDRESS                 METHOD
      local   all             all                                     md5
      host    all             all             127.0.0.1/32            md5
      host    all             all             ::1/128                 md5
    '';

    initialScript = pkgs.writeText "init-sql-script" ''
      ALTER USER kv WITH PASSWORD 'mypassword';
      ALTER USER fr WITH PASSWORD 'mypassword';
    '';

    settings = {
      log_connections = true;
      log_statement = "all";
      log_destination = lib.mkForce "syslog";
    };
  };

  # Web GUI for postgresql
  # services.pgadmin = {
  #   enable = true;
  #   port = 25;
  #   initialEmail = "example@example.com";
  #   initialPasswordFile = "./pg_init";
  # };
}
