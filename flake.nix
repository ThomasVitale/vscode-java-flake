{
  description = "VSCode with Java extensions";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          config.allowUnfree = true;
          inherit system;
        };

        vscode-with-extensions = pkgs.vscode-with-extensions.override {
          vscode = pkgs.vscodium;
          vscodeExtensions = with pkgs.vscode-extensions; [
            redhat.java
            redhat.vscode-yaml
            vscjava.vscode-java-debug
            vscjava.vscode-java-test
            vscjava.vscode-java-dependency
            vscjava.vscode-spring-initializr
            visualstudioexptteam.vscodeintellicode
          ]
          ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
            {
              name = "vscode-spring-boot";
              publisher = "vmware";
              sha256 = "sha256-ILUyJkmkGyiFxPNTPxix3GppEumA/WDu9XUOPM6RSvs=";
              version = "1.63.0";
            }
            {
              name = "vscode-spring-boot-dashboard";
              publisher = "vscjava";
              sha256 = "sha256-AwcJrCjKjlBi5McCbr0MGIBi3gIQn4mtcq5eK85YylQ=";
              version = "0.14.0";
            }
          ];
        };
      in
      {
        packages.default = vscode-with-extensions;
      }
    );
}