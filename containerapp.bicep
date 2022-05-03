/*
  Based off of the Azure Container App Quickstart (Part of Azure Quickstart Templates)
  See: https://github.com/Azure/azure-quickstart-templates/blob/master/quickstarts/microsoft.app/container-app-azurevote/main.bicep
*/

@description('Specifies a prefix for resource names')
param namePrefix string

@description('Specifies the name of the container app.')
param containerAppName string = '${namePrefix}-${uniqueString(resourceGroup().id)}'

param containerAppEnvironmentId string

@description('Specify the environment')
@allowed([
  'prod'
  'dev'
])
param environment string

@description('Specifies the location for all resources.')
@allowed([
  'eastus'
  'northeurope'
  'canadacentral'
])
param location string

@description('Specifies the docker container image to deploy.')
param containerImage string = 'ghcr.io/davidtucker/covid-data-api-demo:latest'

@description('Minimum number of replicas that will be deployed')
@minValue(0)
@maxValue(25)
param minReplica int = 0

@description('Maximum number of replicas that will be deployed')
@minValue(0)
@maxValue(25)
param maxReplica int = 3

var environmentSettings = {
  prod: {
    cpu: json('1')
    memory: '2Gi'
  }
  dev: {
    cpu: json('.25')
    memory: '.5Gi'
  }
}

resource containerApp 'Microsoft.App/containerApps@2022-01-01-preview' = {
  name: containerAppName
  location: location
  properties: {
    managedEnvironmentId: containerAppEnvironmentId
    configuration: {
      ingress: {
        external: true
        targetPort: 8080
        allowInsecure: false
        traffic: [
          {
            latestRevision: true
            weight: 100
          }
        ]
      }
    }
    template: {
      revisionSuffix: 'firstrevision'
      containers: [
        {
          name: containerAppName
          image: containerImage
          resources: {
            cpu: environmentSettings[environment].cpu
            memory: environmentSettings[environment].memory
          }
        }
      ]
      scale: {
        minReplicas: minReplica
        maxReplicas: maxReplica
        rules: [
          {
            name: 'http-requests'
            http: {
              metadata: {
                concurrentRequests: '10'
              }
            }
          }
        ]
      }
    }
  }
}

output containerAppFQDN string = containerApp.properties.configuration.ingress.fqdn
