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
            redhat.java
            vscjava.vscode-java-debug
            vscjava.vscode-java-test
            vscjava.vscode-java-dependency
            redhat.vscode-yaml
          ];
        };
      in
      {
        packages.default = vscode-with-extensions;
      }
    );
}