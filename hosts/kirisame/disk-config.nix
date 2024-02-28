# Need (github:nix-community/disko). Untested.
{
  disko.devices = {
    sda = {
      device = "<dunno, you tell me>";
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            type = "EF00";
            size = "500M";
            content = {
              type = "filesystem";
              mountpoint = "/boot";
              format = "vfat";
            };
          };

          root = {
            size = "100%";
            content = {
              type = "filesystem";
              mountpoint = "/";
              format = "ext4";
            };
          };
        };
      };
    };
  };
}
