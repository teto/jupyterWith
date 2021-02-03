nixpkgsArgs:

let
  defaultOverlays = [
    (import ./haskell-overlay.nix)
    (import ./python-overlay.nix)
  ];
  overlaysAll = defaultOverlays ++ (nixpkgsArgs.overlays or []);
in
  import ./nixpkgs.nix (nixpkgsArgs // { overlays=overlaysAll; })
