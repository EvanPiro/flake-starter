pkgs: pkgs.mkShell {
  buildInputs = with pkgs; [
    postgresql
  ];

  shellHook = ''
    pg_ctl -D ./data -l logfile -o "-k /tmp" start
  '';

  PGHOST = "/tmp";
}
