{ pkgs
, configTxt
, firmware ? pkgs.raspberrypifw
, extraDeviceTreeOverlays ? null
}:

pkgs.substituteAll {
  src = ./firmware-builder.sh;
  isExecutable = true;

  inherit (pkgs) bash;
  path = [ pkgs.coreutils ];

  inherit firmware extraDeviceTreeOverlays configTxt;
}
