{ config, pkgs, ... }:

# All system packages
let
  gnupg = pkgs.gnupg.overrideAttrs (oldAttrs: rec {
    pname = "gnupg";
    version = "2.3.6";
    src = pkgs.fetchurl {
      url = "mirror://gnupg/gnupg/${pname}-${version}.tar.bz2";
      sha256 = "sha256-Iff+L8XC8hQYSrBQl37HqOME5Yv64qsJj+xp+Pq9qcE=";
    };
  });
  syspkgs = [
    pkgs.bat
    pkgs.bat-extras.batman
    pkgs.bat-extras.batgrep
    pkgs.bat-extras.batdiff
    pkgs.bat-extras.batwatch
    pkgs.bat-extras.prettybat
    pkgs.curl
    pkgs.direnv
    pkgs.fd
    pkgs.fzf
    pkgs.git
    gnupg
    pkgs.gnutls
    pkgs.go
    pkgs.jq
    pkgs.nano
    pkgs.nodejs
    pkgs.openssh
    pkgs.pcsclite
    pkgs.pinentry_mac
    pkgs.procps
    pkgs.python310
    pkgs.python310Packages.pipx
    pkgs.python310Packages.virtualenv
    pkgs.ripgrep
    pkgs.swig
    pkgs.vim
    pkgs.wget
    pkgs.yj
    pkgs.yq-go
    pkgs.zsh
  ];

in
{
  # Default system configurations
  system.defaults.NSGlobalDomain.ApplePressAndHoldEnabled = false;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 10;
  system.defaults.NSGlobalDomain.KeyRepeat = 1;
  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;
  system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
  system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode2 = true;
  system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;

  system.defaults.dock.autohide = true;
  system.defaults.dock.showhidden = true;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.FXEnableExtensionChangeWarning = false;
  system.defaults.finder.QuitMenuItem = true;

  # Program configuration

  programs.bash.enableCompletion = true;
  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.enableSSHSupport = false;
  programs.nix-index.enable = true;
  programs.zsh.enable = true;

  # Environment configuration
  environment.variables.LANG = "en_US.UTF-8";

  # System packages
  environment.systemPackages = syspkgs;

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  system.stateVersion = 4;
  nix.extraOptions = ''
    extra-platforms = aarch64-darwin x86_64-darwin
    experimental-features = nix-command flakes
  '';
}
