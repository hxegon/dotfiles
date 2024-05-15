{ config, pkgs, ... }:
let
    pythonEnv = pkgs.python311.withPackages(ps: with ps; [ pwntools angr ]);
in {
  home.packages = with pkgs; [
    # core doom emacs dependencies
    wireguard-go
    unixtools.xxd
    nmap
    binwalk
    wireshark
    thc-hydra # network logon cracker
    burpsuite
    john
    steghide
    trufflehog # Dig for credentials in git, FS, s3, docker...
    ghidra-bin
  ] ++ [ pythonEnv ];

  # home.sessionPath = [ "$HOME/.config/emacs/bin" ];
  # home.sessionVariables = { EDITOR = editorCommand; };

  # home.shellAliases = { dm = editorCommand; };
}
