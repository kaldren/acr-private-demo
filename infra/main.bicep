targetScope = 'subscription'

param resourceGroupName string
param resourceGroupLocation string
param containerRegistryName string
param containerAppEnvironmentName string
param backendAppName string
param backendImage string = 'backend'
param backendTag string = 'latest'
param frontendAppName string
param frontendImage string = 'frontend'
param frontendTag string = 'latest'
param deployContainerApp bool
param randomSuffix string = uniqueString(resourceGroupName)

module rg 'modules/resource-group.bicep' = {
  name: '${resourceGroupName}-${randomSuffix}'
  params: {
    resourceGroupName: resourceGroupName
    resourceGroupLocation: resourceGroupLocation
  }
}

module acr 'modules/container-registry.bicep' = {
  name: 'acr-${randomSuffix}'
  params: {
    containerRegistryName: containerRegistryName
  }
  dependsOn: [
    rg
  ]
  scope: resourceGroup(resourceGroupName)
}

module managedIdentity 'modules/managed-identity.bicep' = {
  name: 'managedIdentity-${randomSuffix}'
  params: {
    containerRegistryName: containerRegistryName
  }
  dependsOn: [
    acr
  ]
  scope: resourceGroup(resourceGroupName)
}

// Deploy container image

module backend 'modules/container-app-backend.bicep' = if (deployContainerApp) {
  name: 'app-backend-${randomSuffix}'
  params: {
    location: resourceGroupLocation
    containerAppEnvironmentName: containerAppEnvironmentName
    containerAppName: backendAppName
    containerRegistryName: containerRegistryName
    imageName: backendImage
    imageTag: backendTag
  }
  dependsOn: [
    managedIdentity
  ]
  scope: resourceGroup(resourceGroupName)
}

module frontend 'modules/container-app-frontend.bicep' = if (deployContainerApp) {
  name: 'app-frontend-${randomSuffix}'
  params: {
    location: resourceGroupLocation
    containerAppEnvironmentName: containerAppEnvironmentName
    containerAppName: frontendAppName
    containerRegistryName: containerRegistryName
    imageName: frontendImage
    imageTag: frontendTag
  }
  dependsOn: [
    managedIdentity
  ]
  scope: resourceGroup(resourceGroupName)
}
