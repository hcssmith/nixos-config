{pkgs, ...}: 
{
    imports = [./hardware-configuration.nix];

    networking = {
        hostName = "arnor";
        networkmanager.enable = true;
    };

    time.timeZone = "Europe/London";

    services.xserver.enable = true;
    
    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;
    services.xserver = {
        layout = "gb";
        xkbVariant = "";
    };

    console.keyMap = "uk";
    
    # Enable sound with pipewire.

    # Auto login stuff
    # Enable automatic login for the user.
    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "hcssmith";

    # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    users.users.hcssmith = {
        isNormalUser = true;
        description = "Hallam Smith";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
            home-manager
        ];
    };

    system.stateVersion = "22.11";

    nix = {
        package = pkgs.nixFlakes; # or versioned attributes like nix_2_7
        extraOptions = ''
        experimental-features = nix-command flakes
        '';
    };
}
