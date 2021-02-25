terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = ">=1.0.0"
    }
  }
  required_version = ">= 0.14"
}

provider "proxmox" {
    pm_api_url = "https://192.168.178.42:8006/api2/json" 
    pm_user = "root@pam"
    pm_password = "******"
    pm_tls_insecure = "true"
}

variable "ssh_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4S8N8DqXNFyJNrvOPLGWy1ego339A/mEktbS2KS2Azf38HaAFY/cyRI/lM3NkEw68b3dgGuBGdu2G8CtX6TiBWxOBClUkLsk5jX+ojItnf1BfJqbkgj+gxRy9i+/I/4SpiMYeYsWOQxy9JR/FHywJoN22XrLQSS7S7f5cGYFgVzhmBTb+pt7VhjLn5mCUEsLfq4Jxxh1bNYTKtUf73vtN+8LOziR9hdgmzRcXfsE3gatV8H+y6ikrgUcIX5CEPtqy/rIrzsXdGs7sG/yYupkRCo2Xa/+LnUM6StarO/PIl3YYkdDyjhIHS04BgW3ITpt5DkTKNllWJIc9tCBdrcqH root@homeville"
}

resource "proxmox_vm_qemu" "proxmox_vm" {
  name              = "tf-vm-1"
  target_node       = "homeville"
  iso = "local:iso/rancheros-proxmoxve.iso"
  os_type="ubuntu"
  cores             = 1
  sockets           = "1"
  memory            = 2048
disk {
    size            = "20G"
    type            = "scsi"
    storage         = "TestVMs"
  }
network {
    model           = "virtio"
    bridge          = "vmbr0"
  }
lifecycle {
    ignore_changes  = [
      network,
    ]
  }
}
