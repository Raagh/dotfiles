{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    packages = with pkgs; [
      nodejs-12_x
      nodePackages.npm
    ];
}
