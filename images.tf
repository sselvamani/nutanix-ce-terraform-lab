resource "nutanix_image" "ubuntu_2204" {
  name       = "Ubuntu-22.04-cloudimg"
  source_url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  image_type = "ISO_IMAGE"
}

// resource "nutanix_image" "win2022_iso" { name = "Win2022"; source_url = "file:///home/youruser/ISOs/Win2022.iso"; image_type = "ISO_IMAGE" }
// resource "nutanix_image" "win10_iso"   { name = "Win10";   source_url = "file:///home/youruser/ISOs/Win10.iso";   image_type = "ISO_IMAGE" }
// resource "nutanix_image" "win11_iso"   { name = "Win11";   source_url = "file:///home/youruser/ISOs/Win11.iso";   image_type = "ISO_IMAGE" }