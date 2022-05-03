param location string = resourceGroup().location

@description('Specify the environment')
@allowed([
  'prod'
  'dev'
])
param environment string

module containerAppEnvironment 'containerappenv.bicep' = {
  name: 'container-app-env'
  params: {
    location: location
  }
}

module containerApp1 'containerapp.bicep' = {
  name: 'container-app-1'
  params: {
    namePrefix: 'containerapp1'
    containerImage: 'ghcr.io/davidtucker/covid-data-api-demo:latest'
    location: 'eastus'
    environment: environment
    containerAppEnvironmentId: containerAppEnvironment.outputs.containerAppEnvironmentId
  }
}

module containerApp2 'containerapp.bicep' = {
  name: 'container-app-2'
  params: {
    namePrefix: 'containerapp2'
    containerImage: 'ghcr.io/davidtucker/covid-data-api-demo:latest'
    location: 'eastus'
    environment: environment
    containerAppEnvironmentId: containerAppEnvironment.outputs.containerAppEnvironmentId
  }
}

module containerApp3 'containerapp.bicep' = if(environment == 'prod') {
  name: 'container-app-3'
  params: {
    namePrefix: 'containerapp3'
    containerImage: 'ghcr.io/davidtucker/covid-data-api-demo:latest'
    location: 'eastus'
    environment: environment
    containerAppEnvironmentId: containerAppEnvironment.outputs.containerAppEnvironmentId
  }
}
