using '../main.bicep'

param resourceGroupLocation = 'eastus'
param resourceGroupName = 'rg-containers-demo-dev'

param containerRegistryName = 'crcontainersdemo2025'
param containerAppEnvironmentName = 'env-demo-dev'
param backendAppName = 'app-backend-dev'
param backendImage = 'backend'
param backendTag = 'latest'
param frontendAppName = 'app-frontend-dev'
param frontendImage = 'frontend'
param frontendTag = 'latest'
param deployContainerApp = false
