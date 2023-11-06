let
  sapphire = "#74c7ec";
  cloudy = "#cff0ff";
  mint = "#a1fff4";
  red = "#f38ba8";
  black = "#000000";
  grey = "#6e738d";
  font = "Agave Nerd Font 16";
in ''
  * {
      width: 600;
      font: "${font}";
  }

  element-text, element-icon , mode-switcher {
      background-color: inherit;
      text-color: inherit;
  }

  window {
      height: 360px;
      border: 2px;
      border-color: ${sapphire};
      background-color: ${black};
  }

  mainbox {
      background-color: ${black};
  }

  inputbar {
      children: [prompt,entry];
      background-color: transparent;
      padding: 2px;
  }

  textbox-prompt-colon {
      expand: false;
      str: ":";
  }

  prompt {
    enabled: false;
  }

  entry {
      padding: 6px;
      margin: 16px 12px;
      text-color: ${sapphire};
      border: 1px;
      border-color: ${mint};
      background-color: ${black};
  }

  listview {
      border: 0px 0px 0px;
      padding: 6px 0px 0px;
      margin: 10px 0px 0px 20px;
      columns: 2;
      lines: 5;
      background-color: ${black};
  }

  element {
      padding: 5px;
      background-color: ${black};
      text-color: ${cloudy}  ;
  }

  element-icon {
      size: 25px;
  }

  element selected {
      background-color: transparent;
      text-color: ${mint};
  }

  mode-switcher {
      spacing: 0;
    }

  button {
      padding: 10px;
      background-color: ${black};
      text-color: ${grey};
      vertical-align: 0.5; 
      horizontal-align: 0.5;
  }

  message {
      background-color: ${black};
      margin: 2px;
      padding: 2px;
      border-radius: 5px;
  }

  textbox {
      padding: 6px;
      text-color: ${red};
      background-color: ${black};
  }
''
