{...}: {
  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=60 # Change default timeout for sudo
  '';
}
