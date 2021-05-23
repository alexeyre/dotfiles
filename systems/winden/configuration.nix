{ config, pkgs, ... }: {
  imports = [ ../../os/darwin ];
  networking.hostName = "winden";
  nix.trustedUsers = [ "alex" ];
  services.nix-daemon.enable = false;

  # tmux reattach
  home-manager.users."${config.main-user}".programs.brew.formulae =
    [ "fabianishere/personal/pam_reattach" ];

  # set the main user of the machine!
  main-user = "alex";
}
