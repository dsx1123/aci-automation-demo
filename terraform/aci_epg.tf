resource "aci_application_profile" "terraform_app" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "terraform_app"
}

resource "aci_application_epg" "epg_web" {
  application_profile_dn = aci_application_profile.terraform_app.id
  name                   = "epg-web"
  relation_fv_rs_bd      = aci_bridge_domain.bd_web.id
  relation_fv_rs_cons    = [aci_contract.web_to_app.id]
}

resource "aci_epg_to_domain" "web_vmm" {
  application_epg_dn    = aci_application_epg.epg_web.id
  tdn                   = data.aci_vmm_domain.vds.id
  vmm_allow_promiscuous = "accept"
  vmm_forged_transmits  = "reject"
  vmm_mac_changes       = "accept"
}

resource "aci_application_epg" "epg_app" {
  application_profile_dn = aci_application_profile.terraform_app.id
  name                   = "epg-app"
  relation_fv_rs_bd      = aci_bridge_domain.bd_app.id
  relation_fv_rs_prov    = [aci_contract.web_to_app.id]
  relation_fv_rs_cons    = [aci_contract.app_to_db.id]
}

resource "aci_epg_to_domain" "app_vmm" {
  application_epg_dn    = aci_application_epg.epg_app.id
  tdn                   = data.aci_vmm_domain.vds.id
  vmm_allow_promiscuous = "accept"
  vmm_forged_transmits  = "reject"
  vmm_mac_changes       = "accept"
}

resource "aci_application_epg" "epg_db" {
  application_profile_dn = aci_application_profile.terraform_app.id
  name                   = "epg-db"
  relation_fv_rs_bd      = aci_bridge_domain.bd_db.id
  relation_fv_rs_prov    = [aci_contract.app_to_db.id]
}

resource "aci_epg_to_domain" "db_vmm" {
  application_epg_dn    = aci_application_epg.epg_db.id
  tdn                   = data.aci_vmm_domain.vds.id
  vmm_allow_promiscuous = "accept"
  vmm_forged_transmits  = "reject"
  vmm_mac_changes       = "accept"
}
