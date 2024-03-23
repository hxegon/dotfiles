{ config, pkgs, ... }:

{
    home.packages = with pkgs; [
        git
        lazygit # tui for git
        delta # pager with syntax highlighting and 'inline' git diffs
    ];

    programs.git.enable = true;

    home.file = {
        ".gitconfig".source = ../sources/git/.gitconfig;
        ".config/lazygit/config.yml".source = ../sources/lazygit/.config/lazygit/config.yml;
    };
}
