terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "0.5.4"
    }
  }
}

variable "password" {
  description = "APIC password"
  type        = string
  sensitive   = true
}

data "aci_vmm_domain" "vds" {
  provider_profile_dn = "uni/vmmp-VMware/"
  name                = "vds-site1"
}

provider "aci" {
  username = "admin"
  password = var.password
  url      = "https://10.195.225.136"
  insecure = true
}
