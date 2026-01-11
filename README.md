# My Dotfiles
For use with NixOS:
```sh
./scripts/setup.sh <hostname>
```

This will:
- Bootstrap `/etc/nixos/configuration.nix` (**this will delete the old configuration.nix**)
- Copy over some useful scripts for rebuilding into `~/.local/bin/`
- Rebuild
