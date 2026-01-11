#/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./setup.sh <hostname>"
  exit 1
fi

set_hostname="$1"
script_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
dotfiles_dir=$(dirname "$script_dir")
nixos_dir="$dotfiles_dir/nixos"
nixos_switch_log="$nixos_dir/nixos-switch.log"
nixcfg_template="$nixos_dir/configuration.nix.template"
local_bin="$HOME/.local/bin"

if [ ! -f "$nixos_dir/$set_hostname.nix" ]; then
  echo "Error: $set_hostname.nix does not exist in $nixos_dir."
  exit 1
fi

# bootstrap nix config
cat "$nixcfg_template" | sed "s/{{HOSTNAME}}/$set_hostname/" | sudo tee "/etc/nixos/configuration.nix" > /dev/null

# symlink
mkdir -p $local_bin
for script in "$script_dir"/rb*; do
  if [ -f "$script" ]; then
    ln -sf "$script" "$local_bin"/
  fi
done

echo "NixOS Rebuilding..."
sudo nixos-rebuild switch &>"$nixos_switch_log" || (cat "$nixos_switch_log" | grep --color error && exit 1)
notify-send -e "NixOS Rebuilt OK!" --icon=software-update-available
