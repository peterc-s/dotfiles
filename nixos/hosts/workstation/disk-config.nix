{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };

            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted-main";
                settings.allowDiscards = true;
                passwordFile = "/tmp/password";
                content = {
                  type = "lvm_pv";
                  vg = "pool_main";
                };
              };
            };
          };
        };
      };

      secondary = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted-secondary";
                settings.allowDiscards = true;
                passwordFile = "/tmp/password";
                content = {
                  type = "lvm_pv";
                  vg = "pool_main";
                };
              };
            };
          };
        };
      };

      bulk = {
        type = "disk";
        device = "/dev/sda";
        content = {
          type = "gpt";
          partitions = {
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted-bulk";
                settings.allowDiscards = true;
                passwordFile = "/tmp/password";
                content = {
                  type = "lvm_pv";
                  vg = "pool_bulk";
                };
              };
            };
          };
        };
      };
    };

    lvm_vg = {
      pool_main = {
        type = "lvm_vg";
        lvs = {
          swap = {
            size = "24G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };

          root = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];
              subvolumes = {
                "/root" = {
                  mountpoint = "/";
                  mountOptions = ["compress=zstd" "noatime"];
                };
                "/home" = {
                  mountpoint = "/home";
                  mountOptions = ["compress=zstd" "noatime"];
                };
                "/nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["compress=zstd" "noatime"];
                };
              };
            };
          };
        };
      };

      pool_bulk = {
        type = "lvm_vg";
        lvs = {
          bulk = {
            size = "100%FREE";
            content = {
              type = "btrfs";
              extraArgs = ["-f"];
              subvolumes = {
                "/bulk" = {
                  mountpoint = "/bulk";
                  mountOptions = ["compress=zstd" "noatime"];
                };
              };
            };
          };
        };
      };
    };
  };
}
