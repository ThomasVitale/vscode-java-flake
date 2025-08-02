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
          vscodeExtensions = with pkgs.vscode-extensions; [
            continue.continue
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
              sha256 = "sha256-4b8lt5XxP8S1mK3lM9DY3JYJYyBwNv1RBM0sMXeWf5U=";
              version = "2.0.2025073100";
            }
            {
              name = "vscode-spring-boot-dashboard";
              publisher = "vscjava";
              sha256 = "sha256-gtEn4UD5Ft+JJqHcz/Eh4t2njOZJg2NRVtfD8Hy4LT8=";
              version = "0.14.2025041702";
            }
          ];
        };
      in
      {
        packages.default = vscode-with-extensions;
      }
    );
}