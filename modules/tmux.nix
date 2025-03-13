{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    tmux
    tmuxPlugins.sensible
    tmuxPlugins.power-theme
  ];

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    mouse = true;
    historyLimit = 10000;
    aggressiveResize = true;

    # Shorten the delay tmux uses to see if an esc key code is actually for a meta combination
    # The default is long enough to cause problems when using modal editing. see:
    # https://evil.readthedocs.io/en/latest/faq.html#problems-with-the-escape-key-in-the-terminal
    escapeTime = 25; # (milliseconds) default is 500ms

    prefix = "C-Space";
    terminal = "screen-256color";

    # bind alt-h and alt-l to prev/next window
    # <prefix> C-o to launch the tms script
    # <prefix> C-g to launch lazygit
    # <prefix> C-j to launch the just command chooser
    extraConfig = ''
      set-option -sa terminal-features ',xterm-kitty:RGB'
      bind -n M-h previous-window
      bind -n M-l next-window

      bind C-s split-window -v
      bind C-v split-window -h
      bind l select-pane -R
      bind k select-pane -U
      bind j select-pane -D
      bind h select-pane -L

      bind-key C-g popup -d "#{pane_current_path}" -h 90% -w 100% -E lazygit
      bind-key C-p popup -d "#{pane_current_path}" -h 80% -w 60% -E lazytsm
      bind-key C-j popup -d "#{pane_current_path}" -h 50% -w 50% -E just --choose
    '';

    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.power-theme;
        extraConfig = "set -g @tmux_power_theme 'everforest'";
      }
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
        # this plugin binds the 'terminal clear' shortcut (C-l), so we make prefix + C-l as a backup.
        extraConfig = "bind C-l send-keys 'C-l'";
      }
    ];
  };
}
