@description('Name of the Container Registry')
param containerRegistryName string

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2025-05-01-preview' = {
  name: containerRegistryName
  location: resourceGroup().location
  identity: {
    type: 'SystemAssigned'
  }
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

output containerRegistry object = {
  name: containerRegistry.name
  endpoint: containerRegistry.properties.loginServer
}
