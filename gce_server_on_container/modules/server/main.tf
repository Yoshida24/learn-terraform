provider "google" {
  project     = var.project_id
  region      = var.location
}

resource "google_compute_instance" "default" {
  name         = "gce-instance"
  machine_type = "e2-medium"
  zone         = var.zone

  tags = ["http-server"]

  boot_disk {
    initialize_params {
      image = "projects/cos-cloud/global/images/cos-stable-113-18244-85-49"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    "gce-container-declaration" = <<-EOF
    spec:
      containers:
        - name: ${var.container_image}
          image: ${var.container_image}
          ports:
            - containerPort: 80
      restartPolicy: Always
    EOF
  }
}

output "instance_ip" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}

resource "google_compute_firewall" "default" {
  name    = "allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["http-server"]
}

resource "google_compute_address" "default" {
  name = "static-ip"
}

resource "google_compute_global_address" "default" {
  name = "global-ip"
}

resource "google_compute_backend_service" "default" {
  name                  = "backend-service"
  health_checks         = [google_compute_http_health_check.default.self_link]
  load_balancing_scheme = "EXTERNAL"
  backend {
    group = google_compute_instance_group.default.self_link
  }
}

resource "google_compute_instance_group" "default" {
  name        = "instance-group"
  zone        = var.zone
  instances   = [google_compute_instance.default.id]
  named_port {
    name = "http"
    port = 80
  }
}

resource "google_compute_http_health_check" "default" {
  name               = "health-check"
  request_path       = "/"
}

resource "google_compute_url_map" "default" {
  name            = "url-map"
  default_service = google_compute_backend_service.default.self_link
}

resource "google_compute_target_http_proxy" "default" {
  name        = "http-proxy"
  url_map     = google_compute_url_map.default.self_link
}

resource "google_compute_global_forwarding_rule" "default" {
  name        = "http-forwarding-rule"
  target      = google_compute_target_http_proxy.default.self_link
  port_range  = "80"
  ip_address  = google_compute_global_address.default.address
}

output "global_ip" {
  value = google_compute_global_address.default.address
}
