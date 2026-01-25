# Install
1. Use minimal installer ISO.
2. Connect to internet.
3. `git clone https://github.com/peterc-s/dotfiles` and switch to correct branch.
4. Use the correct disko config, if using LUKS with password file, write the password file.
5. `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount disk-config.nix`.
6. Create `/mnt/home/pete` and copy `dotfiles` to it.
7. `sudo nixos-install --flake /mnt/home/pete/dotfiles/nixos/#<hostname>`.
8. `sudo nixos-enter -c 'passwd pete'` to set user password, then `sudo nixos-enter -c 'chown pete: /home/pete/dotfiles'` (UNTESTED, but can do this after rebooting).
9. Reboot.

# New Host
1. Use minimal installer ISO.
2. Connect to internet.
3. `git clone https://github.com/peterc-s/dotfiles` and switch to correct branch.
4. Write disko config to `./nixos/hosts/<hostname>/disk-config.nix`, if using LUKS with password file, write the password file.
5. `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount disk-config.nix`.
6. `nixos-generate-config --no-filesystems --root .` and copy the `./etc/nixos/hardware-configuration.nix` to `./dotfiles/nixos/hosts/<hostname>/`.
7. Write the `./nixos/hosts/<hostname>/configuration.nix`, pull in any of the required modules.
8. Make sure to stage git changes.
9. Create `/mnt/home/pete` and copy `dotfiles` to it.
10. `sudo nixos-install --flake /mnt/home/pete/dotfiles/nixos/#<hostname>`.
11. `sudo nixos-enter -c 'passwd pete'` to set user password, then `sudo nixos-enter -c 'chown pete: /home/pete/dotfiles'` (UNTESTED, but can do this after rebooting).
12. Reboot.
13. Remember to set up git and push new host to git.
