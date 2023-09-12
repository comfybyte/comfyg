{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    extraConfig = ''
    set -g prefix C-s
    unbind C-b

    set -g base-index 1
    set -g pane-base-index 1

    set-window-option -g mode-keys vi
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    # Theming
    set -g mode-style "fg=#d955d9,bg=#3b4261"

    set -g message-style "fg=#d955d9,bg=#3b4261"
    set -g message-command-style "fg=#d955d9,bg=#3b4261"

    set -g pane-border-style "fg=#3b4261"
    set -g pane-active-border-style "fg=#d955d9"

    set -g status "on"
    set -g status-justify "left"

    set -g status-style "fg=#d955d9,bg=#1e2030"

    set -g status-left-length "100"
    set -g status-right-length "100"

    set -g status-left-style NONE
    set -g status-right-style NONE

    set -g status-left "#[fg=#1b1d2b,bg=#d955d9,bold] #S #[fg=#d955d9,bg=#1e2030,nobold,nounderscore,noitalics]"
    set -g status-right "#[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]#[fg=#d955d9,bg=#1e2030] #{prefix_highlight} #[fg=#3b4261,bg=#1e2030,nobold,nounderscore,noitalics]#[fg=#d955d9,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#d955d9,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#1b1d2b,bg=#d955d9,bold] #h "

    setw -g window-status-activity-style "underscore,fg=#828bb8,bg=#1e2030"
    setw -g window-status-separator ""
    setw -g window-status-style "NONE,fg=#828bb8,bg=#1e2030"
    setw -g window-status-format "#[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#1e2030,bg=#1e2030,nobold,nounderscore,noitalics]"
    setw -g window-status-current-format "#[fg=#1e2030,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#d955d9,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#1e2030,nobold,nounderscore,noitalics]"
    '';
  };
}
