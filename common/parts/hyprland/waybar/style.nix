''
  * {
    min-height: 0;
    margin: 0;
    font-family: "Iosevka Nerd Font";
    font-size: .7rem;
    color: #EA9A97;
  }

  #waybar {
    background: rgba(0, 0, 0, 0.98);
    border: 1px solid #000;
  }

  #cpu,
  #memory,
  #temperature,
  #pulseaudio,
  #network {
    font-weight: bolder;
    padding: 0 10px;
  }

  #cpu.warning,
  #cpu.critical {
    background: transparent;
    color: #EA9A97;
  }

  #memory.warning {
    color: #A000F0;
  }

  #memory.critical {
    color: #FF00AA;
  }

  #tray {
    margin: 6px 20px;
  }

  #clock {
    font-weight: bolder;
    border-left: 1px solid #EA9A97;
    padding-right: 4px;
    padding-left: 12px;
  }

  #temperature.critical {
    color: #f00;
  }

  #pulseaudio {
    border-right: 1px solid #EA9A97;
    padding-right: 16px;
  }

  #workspaces {
    padding: 0;
  }

  #workspaces button {
    font-size: .4em;

    border: 2px solid transparent;
    border-radius: 0;
    padding: 4px 12px;
  }


  #workspaces button.active {
    border: 2px solid #EA9A97;
    transition: border .75s;
  }
''
