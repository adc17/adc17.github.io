with (import <nixpkgs> {});
let
  gems = bundlerEnv {
    name = "homepage";
    inherit ruby;
    gemdir = ./.;
  };
in stdenv.mkDerivation {
  name = "homepage";
  buildInputs = [gems ruby];
}
