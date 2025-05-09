{ pkgs }:

pkgs.stdenv.mkDerivation rec {
  pname = "aerospace-swipe";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "acsandmann";
    repo = "aerospace-swipe";
    rev = "main";
    sha256 = "sha256-mwpK7w+VCy0ilV+hDwa7rsve/Om3yEy8E9bRHFLVvro=";
  };

  # Patches to fix build issues
  patchPhase = ''
    # Fix kIOMainPortDefault issue
    substituteInPlace src/haptic.c \
      --replace "kIOMainPortDefault" "kIOMasterPortDefault"
    
    # Fix duplicate symbol g_event_tap issue
    # Change from definition to declaration in header
    substituteInPlace src/event_tap.h \
      --replace "struct event_tap g_event_tap;" "extern struct event_tap g_event_tap;"
    
    # And add definition in implementation file
    echo "struct event_tap g_event_tap;" >> src/event_tap.m
  '';

  nativeBuildInputs = [ pkgs.gnumake ];
  buildInputs = with pkgs.darwin.apple_sdk.frameworks; [
    CoreFoundation
    IOKit
    MultitouchSupport
    ApplicationServices
    Cocoa
  ];

  # Override the build phase to explicitly only build the swipe binary
  buildPhase = ''
    # Only build the swipe binary, skip bundle target
    make swipe
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp swipe $out/bin/swipe
    runHook postInstall
  '';
} 
