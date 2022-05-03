/*
  Based off of the Azure Container App Quickstart (Part of Azure Quickstart Templates)
  See: https://github.com/Azure/azure-quickstart-templates/blob/master/quickstarts/microsoft.app/container-app-azurevote/main.bicep
*/

@description('Specifies the location for all resources.')
@allowed([
  'eastus'
  'northeurope'
  'canadacentral'
])
param location string

@description('Specifies the name of the container app environment.')
param containerAppEnvName string = 'containerapp-env-${uniqueString(resourceGroup().id)}'

@description('Specifies the name of the log analytics workspace.')
param containerAppLogAnalyticsName string = 'containerapp-log-${uniqueString(resourceGroup().id)}'

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-06-01' = {
  name: containerAppLogAnalyticsName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
  }
}

resource containerAppEnv 'Microsoft.App/managedEnvironments@2022-01-01-preview' = {
  name: containerAppEnvName
  location: location
  properties: {
    appLogsConfiguration: {
      destination: 'log-analytics'
      logAnalyticsConfiguration: {
        customerId: logAnalytics.properties.customerId
        sharedKey: logAnalytics.listKeys().primarySharedKey
      }
    }
  }
}

output containerAppEnvironmentId string = containerAppEnv.id 
