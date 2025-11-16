{ config, pkgs, ... }:

{
  # Restic backup service
  # This is a template - configure with your backup repository details

  environment.systemPackages = with pkgs; [
    restic
  ];

  # Example systemd timer for automated backups
  # Uncomment and configure when ready to use

  # services.restic.backups = {
  #   localBackup = {
  #     paths = [
  #       "/home"
  #       "/var/lib/docker/volumes"
  #     ];
  #     repository = "/mnt/backup/restic";
  #     passwordFile = "/etc/nixos/secrets/restic-password";
  #
  #     timerConfig = {
  #       OnCalendar = "daily";
  #       Persistent = true;
  #     };
  #
  #     pruneOpts = [
  #       "--keep-daily 7"
  #       "--keep-weekly 4"
  #       "--keep-monthly 6"
  #     ];
  #   };
  # };
}
