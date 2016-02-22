variable "vsphere_user" {
    type = "string"
	default="user"
}
variable "vsphere_password" {
    type = "string"
	default="password"
}
variable "vsphere_server" {
    type = "string"
	default="137.221.104.112"
}

# Configure the VMware vSphere Provider
provider "vsphere" {
  user           = "${var.vsphere_user}"
  password       = "${var.vsphere_password}"
  vsphere_server = "${var.vsphere_server}"
}

# Create a folder
resource "vsphere_folder" "Panorama" {
  path = "frontend"
}

# Create a virtual machine within the folder
resource "vsphere_virtual_machine" "web" {
  name   = "terraform_web"
  folder = "${vsphere_folder.frontend.path}"
  vcpu   = 2
  memory = 4096

  network_interface {
    label = "VM Network"
  }

  disk {
    template = "mmlfvs/VanillaVM"
  }
}