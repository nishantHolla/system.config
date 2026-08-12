# Backup setup using restic
{ pkgs, config, ...}:

{
    environment.systemPackages = [ pkgs.restic ];

    services.restic.backups.homelab = {
        repository = "sftp:restic-backup@homelab:/var/backup/restic/nixosPavilion";

        paths = [];
        extraBackupArgs = [
            "--files-from=/etc/restic/includes"
            "--exclude-file=/etc/restic/excludes"
            "--one-file-system"
        ];

        passwordFile = "/etc/restic/password";
        environmentFile = "/etc/restic/env";

        pruneOpts = [
            "--keep-monthly 12"
            "--keep-last 1"
        ];

        timerConfig = {
            OnCalendar = "monthly";
            Persistent = true;
        };

        initialize = true;
    };
}
