mock_provider "azurerm" {}

variables {
  project             = "ingste1-iac"
  location            = "norwayeast"
  resource_group_name = "ingste1-iac-dev-rg"
}

run "subnettene_har_riktig_cidr" {
  command = plan

  assert {
    condition     = azurerm_subnet.main.address_prefixes[0] == "10.0.1.0/24"
    error_message = "Subnettet skal ha CIDR 10.0.1.0/24."
  }

  assert {
    condition     = azurerm_subnet.data.address_prefixes[0] == "10.0.2.0/24"
    error_message = "Data-subnettet skal ha CIDR 10.0.2.0/24."
  }
}

run "navnene_bruker_prefikset" {
  command = plan

  assert {
    condition     = azurerm_virtual_network.main.name == "ingste1-iac-vnet"
    error_message = "VNet-navnet skal være <name_prefix>-vnet."
  }
}

run "ugyldig_project_avvises" {
  command = plan

  variables {
    project = "Tim84 IAC"
  }

  expect_failures = [var.project]
}

run "ssh_er_ikke_aapent_for_internett" {
  command = plan

  assert {
    condition = alltrue([
      for r in azurerm_network_security_group.this.security_rule :
      r.source_address_prefix != "*" if r.destination_port_range == "22"
    ])
    error_message = "SSH (port 22) skal ikke være åpent fra hele internett."
  }
}