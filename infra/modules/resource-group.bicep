metadata description = 'This Bicep file creates a new resource group in the specified location.'

targetScope='subscription'

@description('Name of the resource group to be created')
param resourceGroupName string

@allowed([
  'eastus'
  'eastus2'
])
@description('Location of the resource group')
param resourceGroupLocation string

resource newRG 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}
