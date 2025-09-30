param location string = resourceGroup().location
param containerAppEnvironmentName string
param containerAppName string
param containerRegistryName string
param imageName string
param imageTag string

resource containerAppEnvironment 'Microsoft.App/managedEnvironments@2025-02-02-preview' = {
  name: containerAppEnvironmentName
  location: location
  properties: {}
}

resource containerApp 'Microsoft.App/containerApps@2022-03-01' ={
  name: containerAppName
  location: location
  identity: {
    type: 'SystemAssigned, UserAssigned'
    userAssignedIdentities: {
      '${managedIdentity.id}': {}
    }
  }
  properties:{
    managedEnvironmentId: containerAppEnvironment.id
    configuration: {
      ingress: {
        targetPort: 8686
        external: false
      }
      registries: [
        {
          server: '${containerRegistry.name}.azurecr.io'
          identity: managedIdentity.id
        }
      ]
    }
    template: {
      containers: [
        {
          image: '${containerRegistry.name}.azurecr.io/${imageName}:${imageTag}'
          name: imageName
        }
      ]
    }
  }
}

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2025-05-01-preview' existing = {
  name: containerRegistryName
}

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-01-31-preview' existing = {
  name: 'mi-containerapp'
}
