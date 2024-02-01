let
  black = "#000000";
  grey = "#6e738d";
  purple = "#8C00FF";
  violet = "#A000F0";
  pink = "#FF00AA";
  font = {
    family = "Ubuntu Nerd Font";
    size = "18";
  };
in ''
  * {
      width: 600;
      font-family: "${font.family}";
      font-size: ${font.size};
  }

  element-text, element-icon , mode-switcher {
      background-color: inherit;
      text-color: inherit;
  }

  window {
      height: 360px;
      border: 2px;
      border-color: ${purple};
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
      text-color: ${purple};
      border: 1px;
      border-color: ${purple};
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
      text-color: ${purple};
  }

  element-icon {
      size: 25px;
  }

  element selected {
      background-color: transparent;
      text-color: ${pink};
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
      padding: 12px;
      text-color: ${violet};
      background-color: ${black};
  }
''
