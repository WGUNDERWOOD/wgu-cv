{
  description = "CV";
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    flake-utils.url = github:numtide/flake-utils;
    dotfiles.url = github:wgunderwood/dotfiles;
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    dotfiles,
  }:
    with flake-utils.lib; eachSystem allSystems (system: let
      pkgs = nixpkgs.legacyPackages.${system};
      programs = "${dotfiles}/programs/";
      compress-pdf = pkgs.callPackage "${programs}/compress-pdf/compress-pdf.nix" {};
      long-lines = pkgs.callPackage "${programs}/long-lines/long-lines.nix" {};
      spell-check = pkgs.callPackage "${programs}/spell-check/spell-check.nix" {};
      tex-build = pkgs.callPackage "${programs}/tex-build/tex-build.nix" {};
      tex-check = pkgs.callPackage "${programs}/tex-check/tex-check.nix" {};
      tex-clean = pkgs.callPackage "${programs}/tex-clean/tex-clean.nix" {};
      todo-finder = pkgs.callPackage "${programs}/todo-finder/todo-finder.nix" {};
      aspell = pkgs.aspellWithDicts (d: [d.en]);
    in rec {
      packages = {
        document = pkgs.stdenvNoCC.mkDerivation rec {
          name = "wgu-cv";
          src = self;
          buildInputs = [
            pkgs.coreutils
            pkgs.just
            pkgs.bash
            pkgs.gnugrep
            pkgs.libre-baskerville
            pkgs.source-code-pro
            pkgs.pngquant
            pkgs.poppler_utils
            pkgs.imagemagick
            pkgs.tex-fmt
            aspell
            compress-pdf
            long-lines
            spell-check
            tex-build
            tex-check
            tex-clean
            todo-finder
          ];
          phases = ["unpackPhase" "buildPhase" "installPhase"];
          buildPhase = ''
            export PATH="${pkgs.lib.makeBinPath buildInputs}";
            export TEXMFVAR="$(mktemp -d)";
            export SOURCE_DATE_EPOCH=${toString self.lastModified};
            just
          '';
          installPhase = ''
            mkdir -p $out
            cp WGUnderwood.pdf $out/
          '';
        };
      };
      defaultPackage = packages.document;
    });
}
