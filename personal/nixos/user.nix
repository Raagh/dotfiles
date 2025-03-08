{
  config,
  lib,
  pkgs,
  assets,
  ...
}:

{
  users.users.raagh = {
    isNormalUser = true;
    description = "raagh";
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
      "video"
      "audio"
    ];
  };

  boot.postBootCommands =
    let
      gdm_user_conf = ''
        [User]
        Session=
        XSession=
        Icon=${../../assets/profile_picture.jpeg}
        SystemAccount=false
      '';
    in
    ''
      echo '${gdm_user_conf}' > /var/lib/AccountsService/users/raagh
    '';
}
