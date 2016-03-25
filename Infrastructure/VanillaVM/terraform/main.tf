# Configure the VMware vSphere Provider
provider "vsphere" {
  user           = "root"
  password       = "Telent2016"
  vsphere_server = "137.221.108.88"
  allow_unverified_ssl = true
}

# Create a virtual machine within the folder
resource "vsphere_virtual_machine" "scaa-01" {
  name   = "dmmc-scaa-01"
  vcpu   = 2
  memory = 4096

  network_interface {
    label = "VM Network"
	ipv4_address = "10.250.15.10"
  }
  
  disk {
    size = 40
	template = "hashicorp/logstream"
	datastore = "datastore1"
  }
  
}