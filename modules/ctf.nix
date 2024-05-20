{ config, pkgs, ... }:
let
    pythonEnv = pkgs.python311.withPackages(ps: with ps; [ pwntools angr ]);
in {
  home.packages = with pkgs; [
    wireguard-go
    netcat
    nmap
    zip
    unzip
    foremost
    pngcheck
    zsteg
    libxcrypt
    exiftool
    stegsolve
    # binutils # collisions with toybox
    toybox # provides strings
    file
    sqlmap
    binwalk
    wireshark
    dirb
    thc-hydra # network logon cracker
    john
    burpsuite
    steghide
    trufflehog # Dig for credentials in git, FS, s3, docker...
    ghidra-bin
    php
    sqlitebrowser
    httpie
    postman
    wfuzz
  ] ++ [ pythonEnv ];

  # home.sessionVariables = {
  # };

  home.shellAliases = {
    trufflehog = "trufflehog --no-update";
  };
}
