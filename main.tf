terraform {
  required_providers {
    vsphere = {
      source  = "vmware/vsphere"
      version = "~> 2.5"
    }
  }
}

provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

# --- Data sources ---
data "vsphere_datacenter" "dc" {
  name = var.datacenter
}

data "vsphere_resource_pool" "pool" {
  name          = "Resources"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "datastore" {
  name          = var.datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "app_ingress" {
  name          = var.network_app_ingress
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "internal_mgmt" {
  name          = var.network_internal_mgmt
  datacenter_id = data.vsphere_datacenter.dc.id
}

# --- VM Resources ---

resource "vsphere_virtual_machine" "Bright-NFS" {
  name             = "Bright-NFS"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 2048
  guest_id = "ubuntu64Guest"

  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  network_interface {
    network_id   = data.vsphere_network.internal_mgmt.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "bright-nfs-dev-disk0"
    size             = 100
    thin_provisioned = true
  }

  cdrom {
    datastore_id = data.vsphere_datastore.datastore.id
    path         = var.iso_path
  }
}

resource "vsphere_virtual_machine" "Bright-CP" {
  name             = "Bright-CP"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 4096
  guest_id = "ubuntu64Guest"

  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  network_interface {
    network_id   = data.vsphere_network.app_ingress.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "bright-k8s-cp-disk0"
    size             = 50
    thin_provisioned = true
  }

  cdrom {
    datastore_id = data.vsphere_datastore.datastore.id
    path         = var.iso_path
  }
}

resource "vsphere_virtual_machine" "Bright-Wkr01" {
  name             = "Bright-Wkr01"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 2048
  guest_id = "ubuntu64Guest"

  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  network_interface {
    network_id   = data.vsphere_network.app_ingress.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "bright-k8s-wkr01-disk0"
    size             = 50
    thin_provisioned = true
  }

  cdrom {
    datastore_id = data.vsphere_datastore.datastore.id
    path         = var.iso_path
  }
}

resource "vsphere_virtual_machine" "Bright-Wkr02" {
  name             = "Bright-Wkr02"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 2048
  guest_id = "ubuntu64Guest"

  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  network_interface {
    network_id   = data.vsphere_network.app_ingress.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "bright-k8s-wkr02-disk0"
    size             = 50
    thin_provisioned = true
  }

  cdrom {
    datastore_id = data.vsphere_datastore.datastore.id
    path         = var.iso_path
  }
}

resource "vsphere_virtual_machine" "Bright-Jenkins" {
  name             = "Bright-Jenkins"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus = 2
  memory   = 4096
  guest_id = "ubuntu64Guest"

  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  network_interface {
    network_id   = data.vsphere_network.app_ingress.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = "bright-jenkins-disk0"
    size             = 50
    thin_provisioned = true
  }

  cdrom {
    datastore_id = data.vsphere_datastore.datastore.id
    path         = var.iso_path
  }
}
