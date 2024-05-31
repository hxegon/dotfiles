{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs;
    [
      clojure
      neil
    ];
}
