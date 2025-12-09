output "vms" {
  description = "List of all VMs created"
  value = {
    Bright-NFS     = vsphere_virtual_machine.Bright-NFS.id
    Bright-CP      = vsphere_virtual_machine.Bright-CP.id
    Bright-Wkr01   = vsphere_virtual_machine.Bright-Wkr01.id
    Bright-Wkr02   = vsphere_virtual_machine.Bright-Wkr02.id
    Bright-Jenkins = vsphere_virtual_machine.Bright-Jenkins.id
  }
}
