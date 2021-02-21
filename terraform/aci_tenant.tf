resource "aci_tenant" "terraform_tenant" {
  name        = "TERRAFROM_DEMO"
  description = "This tenant is created by terraform ACI provider"
}
