resource "aci_vrf" "vrf_prod" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "vrf-prod"
}
