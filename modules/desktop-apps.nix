{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [
    obsidian
    # vscode
    # zoom-us
    # whatsapp-for-linux
    (config.lib.nixGL.wrap whatsapp-for-linux)
    chromium
    discord
    libreoffice
    # gimp # Photo editing
    # rawtherapee # raw photo editing
    vlc
    spotify
    deluge # torrent client
  ];
}
