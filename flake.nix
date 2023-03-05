{
  description = "My NixOs configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nur.url = "github:nix-community/NUR/master";
    utils.url = "github:gytis-ivaskevicius/flake-utils-plus/v1.3.1";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    my-nix-overlay = {
      #url = "path:/var/home/hcssmith/Projects/my-nix-overlay";
      url = "github:hcssmith/my-nix-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, nur, utils, neovim-nightly-overlay, my-nix-overlay }:
  utils.lib.mkFlake {
    inherit self inputs;

    channelsCongih.allowUnfree = true;

    sharedOverlays = [
      nur.overlay
      neovim-nightly-overlay.overlay
      my-nix-overlay.overlay
    ];

    hosts.arnor.modules = [
          ./hosts/arnor
          ./modules/i18n
          ./modules/sound
          ./modules/uefi
        ];
  };
}
