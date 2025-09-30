param containerRegistryName string

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-01-31-preview' = {
  location: resourceGroup().location
  name: 'mi-containerapp'
}

// Set ArcPull role assignment for the managed identity on the ACR
resource acrPull 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(managedIdentity.id, 'AcrPull')
  scope: containerRegistry
  properties: {
    roleDefinitionId: subscriptionResourceId(
      'Microsoft.Authorization/roleDefinitions',
      '7f951dda-4ed3-4680-a7ca-43fe172d538d' // AcrPull role ID
    )
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'
  }
}

output managedIdentityId string = managedIdentity.id

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2025-05-01-preview' existing = {
  name: containerRegistryName
}
