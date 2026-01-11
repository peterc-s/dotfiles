{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    uv
    python3
    ruff
    black
    pylint
    pyright
    ty
  ];
}
