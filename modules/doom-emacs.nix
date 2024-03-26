{ config, pkgs, ... }:
{
    home.packages = with pkgs; [
        # core doom emacs dependencies
        git
        emacs
        ripgrep
        coreutils
        fd
        clang

        shellcheck
    ];

    home.sessionPath = [
        "$HOME/.config/emacs/bin"
    ];

    home.shellAliases = {
        e = "emacs -nw";
    };

    home.file.".config/doom" = {
    	enable = true;
	    source = ../sources/doom_emacs/.config/doom;
	    recursive = true;
        # onChange = "~/.config/emacs/bin/doom sync";
    };
}
