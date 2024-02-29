# Hardware configuration for my Lenovo laptop

{ config, lib, pkgs, modulesPath, ... }:

{
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];

	boot.initrd.availableKernelModules = [ "xhci_pci" "usb_storage" "usbhid" ];
	boot.initrd.kernelModules = [ ];
	boot.kernelModules = [ "kvm-intel" ];
	boot.extraModulePackages = [ ];

	fileSystems."/" = {
		device = "/dev/disk/by-uuid/1ed7e655-91d7-4458-b051-c74617410a36";
		fsType = "btrfs";
		options = [ "subvol=@nixos" ];
	};

	fileSystems."/boot" = {
		device = "/dev/disk/by-uuid/5CEB-A660";
		fsType = "vfat";
	};

	swapDevices = [
		{
			device = "/dev/disk/by-uuid/1e8b6baa-df38-4abc-9c31-c8cc65a6ba06";
		}
	];

	# Enables DHCP on each ethernet and wireless interface. In case of scripted networking
	# (the default) this is the recommended approach. When using systemd-networkd it's
	# still possible to use this option, but it's recommended to use it in conjunction
	# with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
	networking.useDHCP = lib.mkDefault true;
	# networking.interfaces.enp3s0.useDHCP = lib.mkDefault true;
	# networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
