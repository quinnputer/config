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
    "nvme"
    "sd_mod"
    "thunderbolt"
    "usb_storage"
    "usbhid"
    "xhci_pci"
  ];
}
