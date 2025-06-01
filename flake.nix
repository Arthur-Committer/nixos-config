{
  description = "NixOS configuration flake para R2-D2";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      "R2-D2" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          ({ config, pkgs, ... }: {
            hardware.firmware = [
              (pkgs.runCommandNoCC "mt7961-firmware" { } ''
                mkdir -p $out/lib/firmware/mediatek
                cp ${self}/home/dotfiles/firmware/mediatek/* $out/lib/firmware/mediatek/
              '')
            ];
          })
          # Aqui vem o módulo do Home Manager (injetado via inputs)
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs   = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.arthur    = import ./home/home.nix;
          }
        ];
      };
    };
  };
}

