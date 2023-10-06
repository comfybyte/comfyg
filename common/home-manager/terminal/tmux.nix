{ config, lib, ... }:
let cfg = config.inner.tmux;
in with lib; {
  options.inner.tmux.enable = mkEnableOption "Enable tmux.";

  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      extraConfig = ''
        set -g prefix C-s
        unbind C-b
        set -g base-index 1
        set -g pane-base-index 1

        set-window-option -g mode-keys vi
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R
        bind c new-window -c "#{pane_current_path}"
        bind  %  split-window -h -c "#{pane_current_path}"
        bind '"' split-window -v -c "#{pane_current_path}"


        # Theming
        set -g mode-style "fg=#ffffff,bg=#3b4261"

        set -g message-style "fg=#ffffff,bg=#3b4261"
        set -g message-command-style "fg=#ffffff,bg=#3b4261"

        set -g pane-border-style "fg=#3b4261"
        set -g pane-active-border-style "fg=#ffffff"

        set -g status "on"
        set -g status-justify "centre"

        set -g status-style "fg=#ffffff,bg=#1e2030"

        set -g status-left-length "100"
        set -g status-right-length "100"

        set -g status-left-style NONE
        set -g status-right-style NONE

        set -g status-left "#[fg=#1b1d2b,bg=#ffffff,bold] #S #[fg=#ffffff,bg=#1e2030,nobold,nounderscore,noitalics]"
        set -g status-right ""

        setw -g window-status-activity-style "underscore,fg=#828bb8,bg=#1e2030"
        setw -g window-status-separator ""
        setw -g window-status-style "NONE,fg=#828bb8,bg=#1e2030"
        setw -g window-status-format "#[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]#[default] #W #F #[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]"
        setw -g window-status-current-format "#[fg=#1e2030,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#ffffff,bg=#3b4261,bold] #W #F #[fg=#3b4261,bg=#1e2030,nobold,nounderscore,noitalics]"
      '';
    };
  };
}
