resource "google_compute_network" "auto-network-tf" {
  name = "auto-network-tf"
  auto_create_subnetworks = true
}

resource "google_compute_network" "custom-network-tf" {
  name = "custom-network-tf"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "custom-subnetwork-tf-1" {
  name = "auto-subnetwork-tf-1"
  network = google_compute_network.custom-network-tf.id
  ip_cidr_range = "10.0.0.0/24"
  region = "us-central1"
  private_ip_google_access = true
}

resource "google_compute_firewall" "allow-web-traffic" {
    name = "allow-web-traffic"
    network = google_compute_network.custom-network-tf.id
    source_ranges =  ["0.0.0.0/0" ]
    allow { 
        ports = [ "80", "443" ]
        protocol = "tcp"
    }
}


output "auto_network_info" {
  value = <<-EOT
    Network Name: ${google_compute_network.auto-network-tf.name}
    Net URI: ${google_compute_network.auto-network-tf.self_link}
    Net ID: ${google_compute_network.auto-network-tf.id}
  EOT
}

output "custom_network_info" {
    value = <<-EOT
    Net Name: ${google_compute_network.custom-network-tf.name}
    Net URI: ${google_compute_network.custom-network-tf.self_link}
    Net ID: ${google_compute_network.custom-network-tf.id}
    EOT
}


output "name_of_subnetwork" {
    value = google_compute_subnetwork.custom-subnetwork-tf-1.name
  
}