let
pkgs = import <nixpkgs> { };
dotfiles = builtins.fetchGit {
    url = "https://github.com/WGUNDERWOOD/dotfiles";
    rev = "c45aa4e8452c36fb1321bbff4172446160ca7c77";
};
programs = "${dotfiles}/programs/";
compress-pdf = pkgs.callPackage "${programs}/compress-pdf/compress-pdf.nix" {};
long-lines = pkgs.callPackage "${programs}/long-lines/long-lines.nix" {};
spell-check = pkgs.callPackage "${programs}/spell-check/spell-check.nix" {};
tex-build = pkgs.callPackage "${programs}/tex-build/tex-build.nix" {};
tex-check = pkgs.callPackage "${programs}/tex-check/tex-check.nix" {};
tex-clean = pkgs.callPackage "${programs}/tex-clean/tex-clean.nix" {};
tex-fmt = pkgs.callPackage "${programs}/tex-fmt/tex-fmt.nix" {};
todo-finder = pkgs.callPackage "${programs}/todo-finder/todo-finder.nix" {};
in pkgs.mkShell {
    buildInputs = [
        pkgs.imagemagick
        pkgs.just
        pkgs.libre-baskerville
        pkgs.source-code-pro
        pkgs.pngquant
        pkgs.poppler_utils
        pkgs.texlive.combined.scheme-full
        compress-pdf
        long-lines
        spell-check
        tex-build
        tex-check
        tex-clean
        tex-fmt
        todo-finder
    ];
}
