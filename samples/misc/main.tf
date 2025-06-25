# main.tf
# This is a test for Terraform HCL syntax highlighting and language servers.

terraform {
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

resource "local_file" "welcome_message" {
  content  = "Welcome to Rhodium"
  filename = "${path.module}/welcome.txt"
}

output "greeting" {
  value       = local_file.welcome_message.content
  description = "A welcome message for Rhodium."
}
