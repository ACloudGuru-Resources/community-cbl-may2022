param location string = resourceGroup().location

@description('Specify the environment')
@allowed([
  'prod'
  'dev'
])
param environment string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-08-01' = {
  name: 'cblmay2022test'
  kind: 'StorageV2'
  location: location
  sku: {
    name: (environment == 'dev') ? 'Standard_LRS' : 'Standard_GRS'
  }
}
