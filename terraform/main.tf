terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "~> 0.78"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = true # Tailscale経由なので自己署名証明書を許可
}

resource "proxmox_virtual_environment_pool" "practice" {
  pool_id = "practice"
  comment = "Backup practice environment"
}

resource "proxmox_virtual_environment_container" "strapi" {
  description = "Strapi LXC"
  node_name   = var.node_name
  pool_id     = proxmox_virtual_environment_pool.practice.pool_id
  vm_id       = 200
  unprivileged = true

  operating_system {
    template_file_id = "local:vztmpl/ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
    type             = "ubuntu"
  }

  features {
    nesting = true
  }

  initialization {
    hostname = "strapi"

    dns {
      servers = ["1.1.1.1", "8.8.8.8"]
    }

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }
  }

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  disk {
    datastore_id = "local-lvm"
    size         = 20
  }

  network_interface {
    name   = "eth0"
    bridge = "vmbr0"
  }

  started = true
}
