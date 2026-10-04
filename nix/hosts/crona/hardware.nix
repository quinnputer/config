{
  hardware = {
    enableRedistributableFirmware = true;
  };

  hardware.cpu.intel = {
    updateMicrocode = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.amdgpu = {
    initrd.enable = true;
    opencl.enable = true;
  };

  boot.initrd.availableKernelModules = [
    "ahci"
    "nvme"
    "sd_mod"
    "usb_storage"
    "usbhid"
    "xhci_pci"
  ];

  boot.kernelModules = [
    "kvm-intel"
  ];
}
