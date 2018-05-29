######################################################
# This file defines which value are sent to output
######################################################

######################################################
# Resource group info Output

output "ResourceGroupName" {
  value = "${module.ResourceGroup.Name}"
}

output "ResourceGroupId" {
  value = "${module.ResourceGroup.Id}"
}

######################################################
# vNet info Output

output "vNetName" {
  value = "${module.SampleArchi_vNet.Name}"
}

output "vNetId" {
  value = "${module.SampleArchi_vNet.Id}"
}

output "vNetAddressSpace" {
  value = "${module.SampleArchi_vNet.AddressSpace}"
}

######################################################
# Log&Diag Storage account Info

output "DiagStorageAccountName" {
  value = "${module.DiagStorageAccount.Name}"
}

output "DiagStorageAccountID" {
  value = "${module.DiagStorageAccount.Id}"
}

output "DiagStorageAccountPrimaryBlobEP" {
  value = "${module.DiagStorageAccount.PrimaryBlobEP}"
}

output "DiagStorageAccountPrimaryQueueEP" {
  value = "${module.DiagStorageAccount.PrimaryQueueEP}"
}

output "DiagStorageAccountPrimaryTableEP" {
  value = "${module.DiagStorageAccount.PrimaryTableEP}"
}

output "DiagStorageAccountPrimaryFileEP" {
  value = "${module.DiagStorageAccount.PrimaryFileEP}"
}

output "DiagStorageAccountPrimaryAccessKey" {
  sensitive = true
  value     = "${module.DiagStorageAccount.PrimaryAccessKey}"
}

output "DiagStorageAccountSecondaryAccessKey" {
  sensitive = true
  value     = "${module.DiagStorageAccount.SecondaryAccessKey}"
}

######################################################
# Files Storage account Info

output "FilesExchangeStorageAccountName" {
  value = "${module.FilesExchangeStorageAccount.Name}"
}

output "FilesExchangeStorageAccountID" {
  value = "${module.FilesExchangeStorageAccount.Id}"
}

output "FilesExchangeStorageAccountPrimaryBlobEP" {
  value = "${module.FilesExchangeStorageAccount.PrimaryBlobEP}"
}

output "FilesExchangeStorageAccountPrimaryQueueEP" {
  value = "${module.FilesExchangeStorageAccount.PrimaryQueueEP}"
}

output "FilesExchangeStorageAccountPrimaryTableEP" {
  value = "${module.FilesExchangeStorageAccount.PrimaryTableEP}"
}

output "FilesExchangeStorageAccountPrimaryFileEP" {
  value = "${module.FilesExchangeStorageAccount.PrimaryFileEP}"
}

output "FilesExchangeStorageAccountPrimaryAccessKey" {
  sensitive = true
  value     = "${module.FilesExchangeStorageAccount.PrimaryAccessKey}"
}

output "FilesExchangeStorageAccountSecondaryAccessKey" {
  sensitive = true
  value     = "${module.FilesExchangeStorageAccount.SecondaryAccessKey}"
}

######################################################
# Subnet info Output
######################################################

######################################################
#Bastion_Subnet

output "Subnet1Name" {
  value = "${module.Subnet1.Name}"
}

output "Subnet1Id" {
  value = "${module.Subnet1.Id}"
}

output "Subnet1AddressPrefix" {
  value = "${module.Subnet1.AddressPrefix}"
}

######################################################
#Bastion Output

output "VMfqdn" {
  value = ["${module.VMPublicIP.fqdns}"]
}
