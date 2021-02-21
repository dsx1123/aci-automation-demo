resource "aci_contract" "web_to_app" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "web_to_app"
  scope     = "tenant"
}

resource "aci_contract" "app_to_db" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "app_to_db"
  scope     = "tenant"
}

resource "aci_contract_subject" "app_traffic" {
  contract_dn                  = aci_contract.web_to_app.id
  name                         = "app_traffic"
  relation_vz_rs_subj_filt_att = [aci_filter.tomcat.id]
}

resource "aci_contract_subject" "mysql_traffic" {
  contract_dn                  = aci_contract.app_to_db.id
  name                         = "mysql"
  relation_vz_rs_subj_filt_att = [aci_filter.mysql.id]
}

resource "aci_filter" "tomcat" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "http"
}

resource "aci_filter_entry" "tomcat" {
  filter_dn   = aci_filter.tomcat.id
  name        = "tomcat"
  ether_t     = "ip"
  prot        = "tcp"
  d_from_port = "8080"
  d_to_port   = "8080"
}

resource "aci_filter" "mysql" {
  tenant_dn = aci_tenant.terraform_tenant.id
  name      = "mysql"
}

resource "aci_filter_entry" "mysql" {
  filter_dn   = aci_filter.mysql.id
  name        = "mysql"
  ether_t     = "ip"
  prot        = "tcp"
  d_from_port = "3306"
  d_to_port   = "3306"
}

