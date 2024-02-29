# Hardware configuration for my QEMU virtual machine

{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		(modulesPath + "/profiles/qemu-guest.nix")
	];

	boot.initrd.availableKernelModules = [ "ahci" "xhci_pci" "virtio_pci" "virtio_scsi" "sr_mod" "virtio_blk" ];
	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ "kvm-intel" ];
	boot.extraModulePackages = [ ];

	fileSystems."/" = {
		device = "/dev/disk/by-uuid/717cba58-a723-43b9-b783-cb11d30430ec";
		fsType = "ext4";
	};

	fileSystems."/boot" = {
		device = "/dev/disk/by-uuid/C5B9-9D9A";
		fsType = "vfat";
	};

	swapDevices = [ ];

	# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
	# (the default) this is the recommended approach. When using systemd-networkd it's
	# still possible to use this option, but it's recommended to use it in conjunction
	# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
	networking.useDHCP = lib.mkDefault true;
	# networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
