{ pkgs, ... }: {
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 10;
  };
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.kernel.sysctl."fs.inotify.max_user_watches" = 1048576;
  boot.kernel.sysctl."kernel.sysrq" = 1;
}
