self: super: {
  # see also
  # https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/misc/uboot/default.nix#L494
  # https://source.denx.de/u-boot/u-boot
  # https://github.com/u-boot/u-boot/
  ubootRaspberryPi_64bit = super.buildUBoot rec {
    defconfig = "rpi_arm64_defconfig";
    extraMeta.platforms = [ "aarch64-linux" ];
    extraConfig = ''
      CONFIG_BOOTDELAY=-2
      CONFIG_SILENT_CONSOLE=y
      CONFIG_SYS_DEVICE_NULLDEV=y
      CONFIG_SILENT_CONSOLE_UPDATE_ON_SET=y
      CONFIG_SILENT_U_BOOT_ONLY=y
      CONFIG_AUTOBOOT_KEYED=y
      CONFIG_AUTOBOOT_PROMPT="NO UART\0"
      CONFIG_AUTOBOOT_DELAY_STR="dfg\0"
      CONFIG_AUTOBOOT_STOP_STR="1234\0"
    '';
    filesToInstall = [ "u-boot.bin" ];
    # version = "2024.04";
    # src = super.fetchFromGitHub {
    #   owner = "u-boot";
    #   repo = "u-boot";
    #   rev = "v${version}";
    #   hash = super.fakeHash;
    # };
  };

  uefi_rpi3 = super.fetchzip {
    url = "https://github.com/pftf/RPi3/releases/download/v1.39/RPi3_UEFI_Firmware_v1.39.zip";
    hash = super.lib.fakeHash;
    stripRoot = false;
  };
  uefi_rpi4 = super.fetchzip {
    url = "https://github.com/pftf/RPi4/releases/download/v1.38/RPi4_UEFI_Firmware_v1.38.zip";
    hash = super.lib.fakeHash;
    stripRoot = false;
  };
  # https://github.com/worproject/rpi5-uefi/
  uefi_rpi5 = super.fetchzip {
    url = "https://github.com/worproject/rpi5-uefi/releases/download/v0.3/RPi5_UEFI_Release_v0.3.zip";
    hash = "sha256-bjEvq7KlEFANnFVL0LyexXEeoXj7rHGnwQpq09PhIb0=";
    stripRoot = false;
  };
}
