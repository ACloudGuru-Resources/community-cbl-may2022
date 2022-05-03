param location string = resourceGroup().location

@description('Specify the environment')
@allowed([
  'prod'
  'dev'
])
param environment string

var environmentSettings = {
  prod: {
    storageSKUName: 'Standard_LRS'
  }
  dev: {
    storageSKUName: 'Standard_GRS'
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  kind: 'StorageV2'
  sku: {
    name: environmentSettings[environment].storageSKUName
  }
  location: location
  name: 'cblmay2022t'
}
