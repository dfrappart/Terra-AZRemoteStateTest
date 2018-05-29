######################################################
# This file deploys the subnet and NSG for 
#Basic linux architecture Architecture
######################################################

######################################################################
# Subnet and NSG
######################################################################

######################################################################
# Subnet1
######################################################################

#Subnet1 NSG

module "NSG_Subnet1" {
  #Module location
  #source = "./Modules/07 NSG"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//07 NSG/"

  #Module variable
  NSGName             = "NSG_${lookup(var.SubnetName, 0)}"
  RGName              = "${module.ResourceGroup.Name}"
  NSGLocation         = "${var.AzureRegion}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

#Bastion_Subnet

module "Subnet1" {
  #Module location
  #source = "./Modules/06 Subnet"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//06 Subnet/"

  #Module variable
  SubnetName          = "${lookup(var.SubnetName, 0)}"
  RGName              = "${module.ResourceGroup.Name}"
  vNetName            = "${module.SampleArchi_vNet.Name}"
  Subnetaddressprefix = "${lookup(var.SubnetAddressRange, 0)}"
  NSGid               = "${module.NSG_Subnet1.Id}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}
