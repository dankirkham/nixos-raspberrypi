{ pkgs
, configTxt
, firmware ? pkgs.raspberrypifw
, extraDeviceTreeOverlays
}:

let
  firmwareWithExtraBlobs = pkgs.runCommand "add-user-device-tree-blobs" {
    nativeBuildInputs = [ pkgs.coreutils ];
  } ''
    mkdir -p $out
    cp -r ${firmware}/* $out/
    cp ${extraDeviceTreeOverlays}/* $out/share/raspberrypi/boot/overlays/
  '';
in

pkgs.substituteAll {
  src = ./firmware-builder.sh;
  isExecutable = true;

  inherit (pkgs) bash;
  path = [ pkgs.coreutils ];

  inherit firmwareWithExtraBlobs configTxt;
}
