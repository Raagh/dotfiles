{ pkgs, ... }:

let
  mountPoint = "/mnt/google-drive";
in
{
  home.packages = [ pkgs.rclone ];

  systemd.user.services.rclone-google-drive = {
    Unit = {
      Description = "Mount Google Drive with rclone";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };

    Service = {
      Type = "notify";
      ExecStartPre = "${pkgs.bash}/bin/bash -lc '${pkgs.fuse3}/bin/fusermount3 -uz ${mountPoint} 2>/dev/null || true; ${pkgs.coreutils}/bin/mkdir -p ${mountPoint}'";
      ExecStart = "${pkgs.rclone}/bin/rclone mount gdrive: ${mountPoint} --config %h/.config/rclone/rclone.conf --vfs-cache-mode full --vfs-write-back 1s --dir-cache-time 24h --poll-interval 15s --attr-timeout 1s --contimeout 10s --timeout 30s --rc --rc-addr 127.0.0.1:5572 --rc-no-auth";
      ExecStartPost = "${pkgs.bash}/bin/bash -c '${pkgs.rclone}/bin/rclone rc --rc-addr 127.0.0.1:5572 vfs/refresh _async=true || true'";
      ExecStop = "${pkgs.fuse3}/bin/fusermount3 -uz ${mountPoint}";
      Restart = "on-failure";
      RestartSec = 10;
    };

    Install.WantedBy = [ "default.target" ];
  };

  systemd.user.services.rclone-google-drive-refresh = {
    Unit = {
      Description = "Refresh the Google Drive directory cache asynchronously";
      After = [ "rclone-google-drive.service" ];
      Requires = [ "rclone-google-drive.service" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.rclone}/bin/rclone rc --rc-addr 127.0.0.1:5572 vfs/refresh _async=true";
    };
  };

  systemd.user.timers.rclone-google-drive-refresh = {
    Unit.Description = "Periodically refresh the Google Drive directory cache";
    Timer = {
      OnBootSec = "2m";
      OnUnitActiveSec = "15m";
      Unit = "rclone-google-drive-refresh.service";
    };
    Install.WantedBy = [ "timers.target" ];
  };

  home.file.".config/rclone/README".text = ''
    This mount expects an rclone remote called 'gdrive'.

    One-time setup:
      rclone config

    Then rebuild and start the service:
      sudo nixos-rebuild switch --flake /home/raagh/Code/dotfiles/personal#nixos
      systemctl --user start rclone-google-drive

    The drive will be mounted at:
      /mnt/google-drive
  '';
}
