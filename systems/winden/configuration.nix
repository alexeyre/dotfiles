{ config, pkgs, ... }: {
  imports = [ ../../os/darwin ];
  networking.hostName = "winden";
  nix.trustedUsers = [ "alex" ];
  services.nix-daemon.enable = false;

  nix.extraOptions = ''
    system = aarch64-darwin
    # extra-platforms = aarch64-darwin x86_64-darwin
  '';


  # tmux reattach
  home-manager.users."${config.main-user}" = {
    programs.brew.formulae =
      [ "fabianishere/personal/pam_reattach" ];
      home.packages = [ (pkgs.writeScriptBin "rtorrent-tmux" "/usr/bin/arch -arm64 ${pkgs.tmux}/bin/tmux new-session -d -s rtorrent '/usr/bin/arch -arm64 ${pkgs.rtorrent}/bin/rtorrent'") ];
    };

  # set the main user of the machine!
  main-user = "alex";
}
