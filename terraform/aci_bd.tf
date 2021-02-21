resource "aci_bridge_domain" "bd_web" {
  tenant_dn          = aci_tenant.terraform_tenant.id
  name               = "bd-web"
  relation_fv_rs_ctx = aci_vrf.vrf_prod.id
}

resource "aci_subnet" "bd_web_subnet" {
  parent_dn = aci_bridge_domain.bd_web.id
  ip        = "10.10.10.1/24"
  scope     = ["private"]
}

resource "aci_bridge_domain" "bd_app" {
  tenant_dn          = aci_tenant.terraform_tenant.id
  name               = "bd-app"
  relation_fv_rs_ctx = aci_vrf.vrf_prod.id
}

resource "aci_subnet" "bd_app_subnet" {
  parent_dn = aci_bridge_domain.bd_app.id
  ip        = "10.10.11.1/24"
  scope     = ["private"]
}

resource "aci_bridge_domain" "bd_db" {
  tenant_dn          = aci_tenant.terraform_tenant.id
  name               = "bd-db"
  relation_fv_rs_ctx = aci_vrf.vrf_prod.id
}

resource "aci_subnet" "bd_db_subnet" {
  parent_dn = aci_bridge_domain.bd_db.id
  ip        = "10.10.12.1/24"
  scope     = ["private"]
}

