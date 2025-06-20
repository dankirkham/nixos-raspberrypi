{ pkgs
, configTxt
, firmware ? pkgs.raspberrypifw
, extraDeviceTreeOverlays ? null
}:

let
  firmwareWithExtraBlobs = if
    extraDeviceTreeOverlays
  then
    (pkgs.runCommand "add-user-device-tree-blobs" {
      nativeBuildInputs = [ pkgs.coreutils ];
    } ''
      mkdir -p $out
      cp -r ${firmware}/* $out/
      cp ${extraDeviceTreeOverlays}/* $out/share/raspberrypi/boot/overlays/
    '')
  else
    firmware;
in

pkgs.substituteAll {
  src = ./firmware-builder.sh;
  isExecutable = true;

  inherit (pkgs) bash;
  path = [ pkgs.coreutils ];

  inherit firmwareWithExtraBlobs configTxt;
}
