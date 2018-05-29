##############################################################
#This file creates Centos Linux VM with custom extensio script 
#using tempalte capabilities of Terraform
##############################################################

#NSG Rules

module "AllowSSHFromInternetIn" {
  #Module source
  #source = "./Modules/08 NSGRule"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//08 NSGRule"

  #Module variable
  RGName                          = "${module.ResourceGroup.Name}"
  NSGReference                    = "${module.NSG_Subnet1.Name}"
  NSGRuleName                     = "AllowSSHFromInternetVMIn"
  NSGRulePriority                 = 101
  NSGRuleDirection                = "Inbound"
  NSGRuleAccess                   = "Allow"
  NSGRuleProtocol                 = "Tcp"
  NSGRuleSourcePortRange          = "*"
  NSGRuleDestinationPortRange     = 22
  NSGRuleSourceAddressPrefix      = "Internet"
  NSGRuleDestinationAddressPrefix = "${lookup(var.SubnetAddressRange, 2)}"
}

module "AllowHTTPFromInternetVMIn" {
  #Module source
  #source = "./Modules/08 NSGRule"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//08 NSGRule"

  #Module variable
  RGName                          = "${module.ResourceGroup.Name}"
  NSGReference                    = "${module.NSG_Subnet1.Name}"
  NSGRuleName                     = "AllowHTTPFromInternetVMIn"
  NSGRulePriority                 = 102
  NSGRuleDirection                = "Inbound"
  NSGRuleAccess                   = "Allow"
  NSGRuleProtocol                 = "Tcp"
  NSGRuleSourcePortRange          = "*"
  NSGRuleDestinationPortRange     = 80
  NSGRuleSourceAddressPrefix      = "Internet"
  NSGRuleDestinationAddressPrefix = "${lookup(var.SubnetAddressRange, 2)}"
}

#VM public IP Creation

module "VMPublicIP" {
  #Module source
  #source = "./Modules/10 PublicIP"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//10 PublicIP"

  #Module variables

  PublicIPName        = "vmpip"
  PublicIPLocation    = "${var.AzureRegion}"
  RGName              = "${module.ResourceGroup.Name}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

#Availability set creation

module "AS_VM" {
  #Module source

  #source = "./Modules/13 AvailabilitySet"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//13 AvailabilitySet"

  #Module variables
  ASName              = "AS_VM"
  RGName              = "${module.ResourceGroup.Name}"
  ASLocation          = "${var.AzureRegion}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

#NIC Creation

module "NICs_VM" {
  #module source

  #source = "./Modules/12 NICwithPIPWithCount"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//12 NICwithPIPWithCount"

  #Module variables

  NICCount            = "1"
  NICName             = "NIC_VM"
  NICLocation         = "${var.AzureRegion}"
  RGName              = "${module.ResourceGroup.Name}"
  SubnetId            = "${module.Subnet1.Id}"
  PublicIPId          = ["${module.VMPublicIP.Ids}"]
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

#Datadisk creation

module "DataDisks_VM" {
  #Module source

  #source = "./Modules/06 ManagedDiskswithcount"
  source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//06 ManagedDiskswithcount"

  #Module variables

  ManageddiskName     = "DataDisk_VM"
  RGName              = "${module.ResourceGroup.Name}"
  ManagedDiskLocation = "${var.AzureRegion}"
  StorageAccountType  = "${lookup(var.Manageddiskstoragetier, 0)}"
  CreateOption        = "Empty"
  DiskSizeInGB        = "63"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
}

#VM creation

module "VMs_VM" {
  #module source

  source = "github.com/dfrappart/Terra-AZCloudInit//Modules//01 LinuxVMWithCountwithCustomData"

  #Module variables

  VMName              = "VM"
  VMLocation          = "${var.AzureRegion}"
  VMRG                = "${module.ResourceGroup.Name}"
  VMNICid             = ["${module.NICs_VM.Ids}"]
  VMSize              = "${lookup(var.VMSize, 4)}"
  ASID                = "${module.AS_VM.Id}"
  VMStorageTier       = "${lookup(var.Manageddiskstoragetier, 0)}"
  VMAdminName         = "${var.VMAdminName}"
  VMAdminPassword     = "${var.VMAdminPassword}"
  DataDiskId          = ["${module.DataDisks_VM.Ids}"]
  DataDiskName        = ["${module.DataDisks_VM.Names}"]
  DataDiskSize        = ["${module.DataDisks_VM.Sizes}"]
  VMPublisherName     = "${lookup(var.PublisherName, 4)}"
  VMOffer             = "${lookup(var.Offer, 4)}"
  VMsku               = "${lookup(var.sku, 4)}"
  DiagnosticDiskURI   = "${module.DiagStorageAccount.PrimaryBlobEP}"
  PublicSSHKey        = "${var.AzurePublicSSHKey}"
  EnvironmentTag      = "${var.EnvironmentTag}"
  EnvironmentUsageTag = "${var.EnvironmentUsageTag}"
  CloudinitscriptPath = "./Scripts/installnginxubuntu.sh"
}
