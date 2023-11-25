{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.evremap ];
  environment.etc."evremap.toml".text = ''
  device_name = "SEMICO USB Keyboard"
  phys = "usb-0000:00:14.0-2/input0"

  [[dual_role]]
  input = "KEY_CAPSLOCK"
  hold = [ "KEY_LEFTCTRL" ]
  tap = [ "KEY_ESC" ]
  '';
  systemd.services.evremap = {
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      WorkingDirectory = "/";
      ExecStart = "${pkgs.evremap}/bin/evremap remap /etc/evremap.toml";
      Restart = "always";
    };
  };
}
