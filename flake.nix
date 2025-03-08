{
  description = "hxegon's home-manager config";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixGL = {
      url = "github:nix-community/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lazytsm = {
      url = "github:hxegon/lazytsm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixGL,
    nvf,
    lazytsm,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    setup = {
      username = "hxegon";
      shell = "zsh";
      languages = [
        "web"
        "go"
      ];
    };
  in {
    defaultPackage."${system}" = home-manager.defaultPackage."${system}";

    homeConfigurations.${setup.username} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      extraSpecialArgs = {
        inherit system;
        inherit setup;
        inherit nixGL;
        inherit lazytsm;
      };

      modules = [
        nvf.homeManagerModules.default
        ./home.nix
      ];
    };
  };
}
