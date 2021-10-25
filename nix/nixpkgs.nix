let
  lock = builtins.fromJSON (builtins.readFile ./../flake.lock);
  system = builtins.currentSystem;

  compat = (import (
    let
        lockedCompat = lock.nodes.flake-compat.locked;
      in fetchTarball {
        url = "https://github.com/${lockedCompat.owner}/${lockedCompat.repo}/archive/${lockedCompat.rev}.tar.gz";
        sha256 = lockedCompat.narHash;
      }) {
      src = ./..;
    });

  nixpkgsLocked = lock.nodes.nixpkgs.locked;

  nixpkgs = fetchTarball "https://api.${nixpkgsLocked.host or "github.com"}/repos/${nixpkgsLocked.owner}/${nixpkgsLocked.repo}/tarball/${nixpkgsLocked.rev}";

in
# let
#   src = builtins.fetchTarball {
#     url = "https://github.com/NixOS/nixpkgs/archive/a5d03577f0161c8a6e713b928ca44d9b3feb2c37.tar.gz";
#     sha256 = "16zm06arcwkkp8yw37gr365msvgb1yyqrpy7lan4l85l6ids1jjh";
#   };
# in
  import nixpkgs
