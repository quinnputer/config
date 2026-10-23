{
  hardware = {
    enableRedistributableFirmware = true;
  };

  hardware.cpu.amd = {
    updateMicrocode = true;
  };

  boot.kernelModules = [
    "kvm-amd"
  ];

  boot.initrd.availableKernelModules = [
    "ata_piix"
    "sd_mod"
    "uhci_hcd"
    "virtio_pci"
    "virtio_scsi"
  ];
}
