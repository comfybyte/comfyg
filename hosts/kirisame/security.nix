{ pkgs, ... }: {
  security.rtkit.enable = true;
  security.doas.enable = true;
  security.doas.extraRules = [ 
    {
      groups = [ "wheel" ];
      noPass = true;
      cmd = "nixos-rebuild";
    }
  ];
  security.polkit.enable = true;
  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "polkit-kde-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart =
        "${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
